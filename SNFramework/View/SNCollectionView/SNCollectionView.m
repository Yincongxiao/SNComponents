//
//  SNCollectionView.m
//  QDaily
//
//  Created by AsnailNeo on 2/1/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionView.h"
#import "SNCollectionViewEmptyCellItem.h"
#import "SNCollectionViewLoadingCellItem.h"
#import "SNCollectionViewLoadingMoreCellItem.h"
#import "SNCollectionViewPlaceholderCellItem.h"
#import "SNGifRefreshHeader.h"
#import "SNRefreshHeader+Private.h"
#import "UIView+SNAdditions.h"
#import "UIScrollView+SNHeaderView.h"
#import "SNFrameworkGlobal.h"

NSString * const SNCollectionViewCellActionInfoCellKey = @"SNCollectionViewCellActionCellKey";
NSString * const SNCollectionViewCellActionInfoCellItemKey = @"SNCollectionViewCellActionCellItemKey";
NSString * const SNCollectionViewCellActionInfoIndexPathKey = @"SNCollectionViewCellActionIndexPathKey";
NSString * const SNCollectionViewCellActionInfoControlKey = @"SNCollectionViewCellActionControlKey";
NSString * const SNCollectionViewCellActionInfoUserInfoKey = @"SNCollectionViewCellActionUserInfoKey";

//static const NSTimeInterval SNCollectionViewMinimalLoadingDelaySeconds = 0.20f;

@interface SNCollectionView ()

@property (nonatomic, assign) CGPoint defaultContentOffset;
@property (nonatomic, assign) CGPoint previousContentOffset;
@property (nonatomic, assign, readwrite) SNCollectionViewVerticalScrollDirection verticalScrollDirection;
@property (nonatomic, assign) BOOL needReloadData; // iOS10 处理
//@property (nonatomic, strong) SNRefreshHeader *refreshControl;

@end

@implementation SNCollectionView {
    BOOL _firstLoad;
}

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark -
#pragma mark Setter & Getter

- (SNCollectionViewCellItem *)emptyCellItem {
    if (nil == _emptyCellItem) {
        _emptyCellItem = [[SNCollectionViewEmptyCellItem alloc] init];
        _emptyCellItem.cellHeight = self.height;
    }
    return _emptyCellItem;
}

- (SNCollectionViewCellItem *)loadingCellItem {
    if (nil == _loadingCellItem) {
        _loadingCellItem = [[SNCollectionViewLoadingCellItem alloc] init];
        _loadingCellItem.cellHeight = self.height;
    }
    return _loadingCellItem;
}

- (SNCollectionViewLayout *)lfCollectionViewLayout {
    if ([self.collectionViewLayout isKindOfClass:[SNCollectionViewLayout class]]) {
        return (SNCollectionViewLayout *)self.collectionViewLayout;
    }
    return nil;
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
    self.contentOffset = self.defaultContentOffset;
}

- (CGPoint)defaultContentOffset {
    return CGPointMake(0, -self.contentInset.top);
}

- (void)setSn_headerView:(UIView *)sn_headerView {
    self.lfCollectionViewLayout.headerViewMargin = sn_headerView.height + sn_headerView.top;
    [super setSn_headerView:sn_headerView];
}

#pragma mark -
#pragma mark Initialization

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(SNCollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (!self) {
        return nil;
    }
    
    _firstLoad = YES;
    
    self.delegate = self;
    self.dataSource = self;
    self.allowScrolling = YES;
    if ([DeviceInfo isiOS10plus]) {
        self.prefetchingEnabled = NO;
    }
    
    return self;
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (SNCollectionSupplementaryViewItem *)supplementaryItemAtIndexPath:(NSIndexPath *)indexPath withKind:(NSString *)kind {
    
    if ([self.lfDelegate respondsToSelector:@selector(supplementaryItemAtIndexPath:withKind:)]) {
        NSArray *supplementaryItems = [self.lfDelegate supplementaryItemsForCollectionView:self withKind:kind];
        
        id theItem = [supplementaryItems sn_objectAtSafeIndex:indexPath.section];
        if ([theItem isKindOfClass:[SNCollectionSupplementaryViewItem class]]) {
            return (SNCollectionSupplementaryViewItem *)theItem;
        } else if ([theItem isKindOfClass:[NSArray class]]) {
            NSArray *sectionItems = (NSArray *)theItem;
            SNCollectionSupplementaryViewItem *itemInSection = [sectionItems sn_objectAtSafeIndex:indexPath.item];
            if ([itemInSection isKindOfClass:[SNCollectionSupplementaryViewItem class]]) {
                return itemInSection;
            }
        }
    }
    
    LogE(@"Invalid SNCollectionSupplementaryViewItem! Please check your data source provider.");
    return nil;
}

// Getting SNCellItem

- (NSMutableArray *)cellItemsOfSection:(NSUInteger)section {
    return [[self.lfDelegate cellItemSectionsForCollectionView:self] sn_dataSourceOfSection:section];
}

- (SNCollectionViewCellItem *)cellItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SNCollectionViewCellItem *cellItem = nil;
    
    self.scrollEnabled = self.allowScrolling;
    
    if ([[self.lfDelegate cellItemSectionsForCollectionView:self] count] == 0) {
        
        if (_firstLoad) {
            self.scrollEnabled = NO;
            cellItem = self.loadingCellItem;
        } else {
            cellItem = self.emptyCellItem;
        }
        
    } else {
        
        cellItem = [[self cellItemsOfSection:indexPath.section] sn_objectAtSafeIndex:indexPath.item];
        
        if (![cellItem isKindOfClass:[SNCollectionViewCellItem class]]) {
            cellItem = self.emptyCellItem;
            LogW(@"Invalid cell item!");
        } else if (self.bottomPlaceholderCellItem && indexPath.item == [[self cellItemsOfSection:indexPath.section] count]) {
            cellItem = self.bottomPlaceholderCellItem;
        }
    }
    
    return cellItem;
}

// Getting Item and Section Metrics


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    NSUInteger itemsCount = [[self cellItemsOfSection:section] count];
    
    // At least we have one item here: your cell item or SNEmptyCellItem or SNLoadingCellItem.
    return MAX(itemsCount, 1);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    NSUInteger itemsCount = [[self.lfDelegate cellItemSectionsForCollectionView:self] count];
    
    return MAX(itemsCount, 1);
}

// Getting Views for Items

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    SNCollectionSupplementaryViewItem *supplementaryViewItem = (SNCollectionSupplementaryViewItem *)[self cellItemAtIndexPath:indexPath];
    
    if (!supplementaryViewItem) {
        LogE(@"Can't find avaliable SNCollectionSupplementaryViewItem at IndexPath: %@", indexPath);
        return nil;
    }
    
    if ([supplementaryViewItem isKindOfClass:[SNCollectionSupplementaryViewItem class]]) {
        
        if ([supplementaryViewItem.supplementaryElementKind isEqualToString:kind]) {
            if ([[supplementaryViewItem.nibName sn_trim] length]) {
                [collectionView registerNib:[UINib nibWithNibName:supplementaryViewItem.nibName bundle:nil] forSupplementaryViewOfKind:supplementaryViewItem.supplementaryElementKind withReuseIdentifier:supplementaryViewItem.identifier];
            } else {
                [collectionView registerClass:supplementaryViewItem.cellClass forSupplementaryViewOfKind:supplementaryViewItem.supplementaryElementKind withReuseIdentifier:supplementaryViewItem.identifier];
            }
        } else {
            LogE(@"Invalid SNCollectionSupplementaryViewItem for supplementary element kind of %@! Please check your datasource.", kind);
            return nil;
        }
        
    } else {
        LogE(@"Invalid SNCollectionSupplementaryViewItem class (%@)! Please check your datasource.", [supplementaryViewItem class]);
        return nil;
    }
    
    SNCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:supplementaryViewItem.identifier forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.cellItem = supplementaryViewItem;
    cell.indexPath = indexPath;
    
    return cell;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SNCollectionViewCellItem *cellItem = [self cellItemAtIndexPath:indexPath];
    cellItem.collectionView = self;
    
    if (!cellItem) {
        LogE(@"Can't find avaliable SNCollectionCellItem at IndexPath: %@", indexPath);
        return nil;
    }
    
    if ([cellItem isKindOfClass:[SNCollectionViewCellItem class]]) {
        
        if ([[cellItem.nibName sn_trim] length]) {
            [collectionView registerNib:[UINib nibWithNibName:cellItem.nibName bundle:nil] forCellWithReuseIdentifier:cellItem.identifier];
        } else {
            [collectionView registerClass:cellItem.cellClass forCellWithReuseIdentifier:cellItem.identifier];
        }
        
    } else {
        LogE(@"Invalid SNCollectionViewCellItem class (%@)! Please check your datasource.", [cellItem class]);
        return nil;
    }
    
    SNCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellItem.identifier forIndexPath:indexPath];
    
    cell.delegate = self;
    
    if ([cellItem isKindOfClass:[SNCollectionViewLoadingMoreCellItem class]]) {
        SNCollectionViewLoadingMoreCellItem *moreCellItem = (SNCollectionViewLoadingMoreCellItem *)cellItem;
        moreCellItem.showSpinner = YES;
        if (![DeviceInfo isiOS10plus] && !moreCellItem.shouldNotLoadMore && [self.lfDelegate respondsToSelector:@selector(moreItemsWillLoadWithCollectionView:)]) {
            [self.lfDelegate moreItemsWillLoadWithCollectionView:self];
            
            /*
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(SNCollectionViewMinimalLoadingDelaySeconds * NSEC_PER_SEC));
            
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.lfDelegate moreItemsWillLoadWithCollectionView:self];
            });
             */
        }
    }
    cell.cellItem = cellItem;
    cell.indexPath = indexPath;
    
    _firstLoad = NO; // Should always keep this statement at the end of the method.
    
    return cell;
}

#pragma mark -
#pragma mark UICollectionView Actions

- (void)insertCellItem:(SNCollectionViewCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath {
    
    if (!cellItem) {
        LogI(@"Invalid SNCollectionViewCellItem to insert!");
        return;
    }
    
    NSMutableArray *items = [self.lfDelegate cellItemSectionsForCollectionView:self];
    
    if (!items.count) {
        [items addObject:[NSMutableArray array]];
    }
    
    if (indexPath.section > items.count - 1) {
        LogI(@"Invalid section to insert!");
        return;
    }
    
    NSMutableArray *cellItemsForTheSection = [items objectAtIndex:indexPath.section];
    
    if (indexPath.item > cellItemsForTheSection.count) {
        LogI(@"Invalid section to insert!");
        return;
    }
    
    [cellItemsForTheSection insertObject:cellItem atIndex:indexPath.item];
    [self insertItemsAtIndexPaths:@[indexPath]];
}

- (void)insertCellItems:(NSArray <SNCollectionViewCellItem *>*)cellItems atIndexPaths:(NSArray <NSIndexPath *>*)indexPaths {
    
    if (cellItems.count != indexPaths.count) {
        LogI(@"Invalid indexPaths to insert!");
        return;
    }
    
    if (cellItems.count == 0) {
        LogI(@"Invalid cellItems to insert!");
        return;
    }
    
    for (int i = 0; i < cellItems.count; i ++) {
        
        if (![cellItems[i] isKindOfClass:[SNCollectionViewCellItem class]]) {
            LogI(@"Invalid SNCollectionViewCellItem to insert!");
            return;
        }
        
        NSMutableArray *items = [self.lfDelegate cellItemSectionsForCollectionView:self];
        
        if (!items.count) {
            [items addObject:[NSMutableArray array]];
        }
        
        NSIndexPath *indexPath = [indexPaths sn_objectAtSafeIndex:i];
        
        SNCollectionViewCellItem *cellItem = [cellItems sn_objectAtSafeIndex:i];
        
        if (items.count > 0 && indexPath.section > items.count - 1) {
            LogI(@"Invalid section to insert!");
            return;
        }
        
        NSMutableArray *cellItemsForTheSection = [items sn_objectAtSafeIndex:0];
        
        if (indexPath.item > cellItemsForTheSection.count) {
            LogI(@"Invalid item to insert!");
            return;
        }
        
        [cellItemsForTheSection insertObject:cellItem atIndex:indexPath.item];
    }
    
    [self insertItemsAtIndexPaths:indexPaths];
}

- (void)deleteCellItem:(SNCollectionViewCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath {
    if (!cellItem) {
        LogI(@"Invalid SNCollectionViewCellItem to delete!");
        return;
    }
    
    NSMutableArray *items = [self.lfDelegate cellItemSectionsForCollectionView:self];
    
    if (indexPath.section > items.count - 1) {
        LogI(@"Invalid section to delete!");
        return;
    }
    
    NSMutableArray *cellItemsForTheSection = [items objectAtIndex:indexPath.section];
    
    if (indexPath.item > cellItemsForTheSection.count) {
        LogI(@"Invalid section to delete!");
        return;
    }
    [cellItemsForTheSection removeObject:cellItem];
    [self deleteItemsAtIndexPaths:@[indexPath]];
}

- (void)reloadCellItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath == nil)
        return;
    [self reloadItemsAtIndexPaths:@[indexPath]];
}

#pragma mark -
#pragma mark UICollectionView Behaviour

- (void)scrollToTopAnimated:(BOOL)animated {
    [self setContentOffset:self.defaultContentOffset animated:animated];
}

#pragma mark -
#pragma mark PullDown Refresh

- (void)enablePullDownRefreshWithDrawingImage:(NSArray *)drawingImages loadingImage:(NSArray *)loadingImages height:(CGFloat)height imageSize:(CGSize)size {
    
    __weak SNCollectionView *weakSelf = self;
    
    [self sn_addRefreshHeaderWithRefreshingBlock:^{
        [weakSelf refreshControlDidTriggered];
    } withRefreshHeaderClass:[SNGifRefreshHeader class]];
    
    SNGifRefreshHeader *gifRefreshHeader = (SNGifRefreshHeader *)self.sn_refreshHeader;
    
    self.sn_refreshHeader.height = height;
    gifRefreshHeader.imageSize = size;
    
    [gifRefreshHeader setImages:drawingImages forState:SNRefreshHeaderStateIdle];
    [gifRefreshHeader setImages:loadingImages forState:SNRefreshHeaderStateRefreshing];
}

- (void)enableDragDownRefreshControl {
    
    __weak SNCollectionView *weakSelf = self;
    
    [self sn_addRefreshHeaderWithRefreshingBlock:^{
        [weakSelf refreshControlDidTriggered];
    } withRefreshHeaderClass:[SNDragDownRefreshHeader class]];
    
}

- (void)pullDownRefreshDidFinish {
    if (self.sn_refreshHeader) {
        [self.sn_refreshHeader endRefreshing];
    }
}

- (void)refreshControlDidTriggered {
    if (self.lfDelegate && [self.lfDelegate respondsToSelector:@selector(itemsWillReloadWithCollectionView:)]) {
        [self.lfDelegate itemsWillReloadWithCollectionView:self];
    }
}

- (void)skyRefreshControlDidTriggered {
    if (self.lfDelegate && [self.lfDelegate respondsToSelector:@selector(skyRefreshToggledWithCollectionView:)]) {
        [self.lfDelegate skyRefreshToggledWithCollectionView:self];
    }
}

- (void)doPulldownRefreshAnimated:(BOOL)animated {
    if (self.sn_refreshHeader) {
        [self.sn_refreshHeader beginRefreshing];
    } else {
        [self scrollToTopAnimated:animated];
    }
}
- (void)removeRefreshControl{
    [self.sn_refreshHeader removeFromSuperview];
    self.sn_refreshHeader = nil;
}
#pragma mark -
#pragma mark UICollectionViewDelegate

// Managing the Selected Cells

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SNCollectionViewCellItem *cellItem = [self cellItemAtIndexPath:indexPath];
    
    if (!cellItem.selectable) {
        return;
    }
    
    if (cellItem.selectable && cellItem.deselectAfterSelecting) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
    
    if ([self.lfDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:withCellItem:)]) {
        [self.lfDelegate collectionView:self
               didSelectItemAtIndexPath:indexPath
                           withCellItem:cellItem];
    }
}

// Tracking the Addition and Removal of Views

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SNCollectionViewCell *willDisplayCell = (SNCollectionViewCell *)cell;
    [willDisplayCell willDisplay];
    
    if ([self.lfDelegate respondsToSelector:@selector(collectionView:willDisplayCell:forItemAtIndexPath:withCellItem:)]) {
        [self.lfDelegate collectionView:self
                        willDisplayCell:(SNCollectionViewCell *)cell
                     forItemAtIndexPath:indexPath
                           withCellItem:[self cellItemAtIndexPath:indexPath]];
    }
    
    if ([DeviceInfo isiOS10plus]) {
        SNCollectionViewCellItem *cellItem = [self cellItemAtIndexPath:indexPath];
        if ([cellItem isKindOfClass:[SNCollectionViewLoadingMoreCellItem class]]) {
            SNCollectionViewLoadingMoreCellItem *moreCellItem = (SNCollectionViewLoadingMoreCellItem *)cellItem;
            if (!moreCellItem.shouldNotLoadMore && [self.lfDelegate respondsToSelector:@selector(moreItemsWillLoadWithCollectionView:)]) {
                [self.lfDelegate moreItemsWillLoadWithCollectionView:self];
            }
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SNCollectionViewCell *didEndDisplayCell = (SNCollectionViewCell *)cell;
    [didEndDisplayCell didEndDisplay];
    
    if ([self.lfDelegate respondsToSelector:@selector(collectionView:didEndDisplayCell:forItemAtIndexPath:withCellItem:)]) {
        [self.lfDelegate collectionView:self
                      didEndDisplayCell:(SNCollectionViewCell *)cell
                     forItemAtIndexPath:indexPath
                           withCellItem:[self cellItemAtIndexPath:indexPath]];
    }
}

#pragma mark -
#pragma mark SNCollectionViewCellAction Deleagte

- (void)collectionViewCell:(SNCollectionViewCell *)collectionViewCell
           actionOnControl:(id)control
              controlEvent:(UIControlEvents)event
                  userInfo:(id)userInfo
{
    [self collectionViewCell:collectionViewCell
             actionOnControl:control
                controlEvent:event
                    userInfo:userInfo
                    selector:nil];
}

- (void)collectionViewCell:(SNCollectionViewCell *)collectionViewCell
           actionOnControl:(id)control
              controlEvent:(UIControlEvents)event
                  userInfo:(id)userInfo
                  selector:(SEL)selector
{
    NSIndexPath *indexPath = collectionViewCell.indexPath;
    
    if ([indexPath compare:[self indexPathForCell:collectionViewCell]] != NSOrderedSame) {
        indexPath = [self indexPathForCell:collectionViewCell];
    }
    
    SNCollectionViewCellItem *cellItem = [self cellItemAtIndexPath:indexPath];
    
    if (selector && [self.lfDelegate respondsToSelector:@selector(collectionView:actionWithSelector:info:)]) {
        if (collectionViewCell && cellItem && control && indexPath) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            
            [dict sn_setSafeObject:collectionViewCell forKey:SNCollectionViewCellActionInfoCellKey];
            [dict sn_setSafeObject:cellItem forKey:SNCollectionViewCellActionInfoCellItemKey];
            [dict sn_setSafeObject:control forKey:SNCollectionViewCellActionInfoControlKey];
            [dict sn_setSafeObject:indexPath forKey:SNCollectionViewCellActionInfoIndexPathKey];
            [dict sn_setSafeObject:userInfo forKey:SNCollectionViewCellActionInfoUserInfoKey];
            
            [self.lfDelegate collectionView:self
                         actionWithSelector:selector
                                       info:dict];
        }
    } else if ([self.lfDelegate respondsToSelector:@selector(collectionView:actionOnCell:indexPath:cellItem:control:controlEvent:userInfo:)]) {
        [self.lfDelegate collectionView:self
                           actionOnCell:collectionViewCell
                              indexPath:indexPath
                               cellItem:cellItem
                                control:control
                           controlEvent:event
                               userInfo:userInfo];
    }
}


#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.lfDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.lfDelegate scrollViewWillBeginDragging:scrollView];
    }
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.lfDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.lfDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.lfDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.lfDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y != self.previousContentOffset.y) {
        self.verticalScrollDirection = scrollView.contentOffset.y > self.previousContentOffset.y ? SNCollectionViewVerticalScrollDirectionUp : SNCollectionViewVerticalScrollDirectionDown;
        self.previousContentOffset = scrollView.contentOffset;
    }
    
    if (self.disableTopBounces) {
        if (scrollView.isTracking) {
            if (scrollView.contentOffset.y <= self.defaultContentOffset.y) {
                self.bounces = NO;
            }
        } else if (scrollView.contentOffset.y == self.defaultContentOffset.y) {
            self.bounces = NO;
        } else {
            self.bounces = YES;
        }
    }
    
    if ([self.lfDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.lfDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.lfDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.lfDelegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.lfDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.lfDelegate scrollViewDidEndDecelerating:scrollView];
    }
    
    if (_needReloadData && self.contentOffset.y >= self.defaultContentOffset.y) {
        _needReloadData = NO;
        [super reloadData];
    }
}

@end

@implementation NSMutableArray (SNCollectionView)

- (void)sn_addObjectsToLastSectionFromArray:(NSArray *)objects {
    
    if (!objects.count) {
        LogW(@"Empty objects attempts to be added into SNCollectionView Datasource!");
        return;
    }
    
    if (!self.count) {
        [self addObject:[NSMutableArray arrayWithArray:objects]];
    } else {
        NSMutableArray *lastSection = [self sn_dataSourceOfSection:self.count - 1];
        [lastSection addObjectsFromArray:objects];
    }
}

- (void)sn_addObjectToLastSection:(id)object {
    
    if (!object) {
        LogW(@"Nil object attempts to be added into SNCollectionView Datasource!");
        return;
    }
    
    if (!self.count) {
        [self addObject:[NSMutableArray arrayWithObject:object]];
    } else {
        NSMutableArray *lastSection = [self sn_dataSourceOfSection:self.count - 1];
        [lastSection sn_addNonnilObject:object];
    }
}

- (void)sn_insertObjectsToLastSectionFromArray:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    
    if (!objects.count) {
        LogW(@"Empty objects attempts to be insert into SNCollectionView Datasource!");
        return;
    }
    
    if (!self.count) {
        [self addObject:[NSMutableArray arrayWithArray:objects]];
    } else {
        NSMutableArray *lastSection = [self sn_dataSourceOfSection:self.count - 1];
        if (indexes.firstIndex > lastSection.count) {
            
            return;
        }
        [lastSection insertObjects:objects atIndexes:indexes];
    }
}

- (void)sn_insertObjectToLastSection:(id)object atIndex:(NSUInteger)index{
    
    if (!object) {
        LogW(@"Nil object attempts to be added into SNCollectionView Datasource!");
        return;
    }
    
    if (!self.count) {
        [self addObject:[NSMutableArray arrayWithObject:object]];
    } else {
        
        NSMutableArray *lastSection = [self sn_dataSourceOfSection:self.count - 1];
        
        if (index > lastSection.count) {
            LogW(@"Invalid index to insert!");
            return;
        }
        
        [lastSection insertObject:object atIndex:index];
    }
}

- (void)sn_removeObjectFromLastSection:(id)object {
    
    if (!self.count || !object) {
        return;
    } else {
        NSMutableArray *lastSection = [self sn_dataSourceOfSection:self.count - 1];
        [lastSection removeObject:object];
    }
    
}

- (NSMutableArray *)sn_dataSourceOfSection:(NSUInteger)section {
    
    NSMutableArray *array = [self sn_objectAtSafeIndex:section];
    
    if ([array isKindOfClass:[NSMutableArray class]]) {
        return array;
    } else {
        if (self.count) LogE(@"Critical Error: Invalid SNCollectionView datasource type, please verify your datasource provider.");
        return nil;
    }
}

- (void)sn_trimLastSection {
    
    NSMutableArray *array = [self sn_dataSourceOfSection:self.count - 1];
    
    if (array) {
        SNCollectionViewCellItem *lastCellItem = [array lastObject];
        while ([lastCellItem isKindOfClass:[SNCollectionViewLoadingCellItem class]] || [lastCellItem isKindOfClass:[SNCollectionViewLoadingMoreCellItem class]] || [lastCellItem isKindOfClass:[SNCollectionViewPlaceholderCellItem class]]) {
            [array removeLastObject];
            lastCellItem = [array lastObject];
        }
    }
}

- (NSMutableArray *)sn_lastSection {
    NSMutableArray *array = [self sn_dataSourceOfSection:self.count - 1];
    if (array && [array isKindOfClass:[NSMutableArray class]]) {
        return array;
    } else {
        return nil;
    }
}

- (BOOL)sn_isValidIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > self.count - 1) {
        return NO;
    }
    
    if (indexPath.row > [[self objectAtIndex:indexPath.section] count] - 1) {
        return NO;
    }
    
    return YES;
}

- (NSIndexPath *)sn_lastIndexPath {
    if (!self.count) {
        [self addObject:[NSMutableArray array]];
    }
    NSMutableArray *lastSection = [self objectAtIndex:self.count - 1];
    if (!lastSection.count) {
        return [NSIndexPath indexPathForItem:0 inSection:self.count - 1];
    }
    return [NSIndexPath indexPathForItem:lastSection.count - 1 inSection:self.count - 1];
}

@end
