//
//  SNTableView.m
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTableView.h"
#import "SNTableCellItem.h"
#import "SNTableViewCell.h"

#import "SNTableLoadingMoreCellItem.h"
#import "SNTableLoadingCellItem.h"
#import "SNTablePlaceholderCellItem.h"
#import "SNTableEmptyCellItem.h"
#import "UIView+SNAdditions.h"
#import "NSDictionary+SNAdditions.h"
#import "NSArray+SNAdditions.h"
#import "SNFrameworkGlobal.h"

NSString * const SNTableViewCellActionInfoCellKey = @"SNTableViewCellActionInfoCellKey";
NSString * const SNTableViewCellActionInfoCellItemKey = @"SNTableViewCellActionInfoCellItemKey";
NSString * const SNTableViewCellActionInfoIndexPathKey = @"SNTableViewCellActionInfoIndexPathKey";
NSString * const SNTableViewCellActionInfoControlKey = @"SNTableViewCellActionInfoControlKey";
NSString * const SNTableViewCellActionInfoUserInfoKey= @"SNTableViewCellActionInfoUserInfoKey";

static const NSTimeInterval SNTableViewMinimalLoadingDelaySeconds = 0.20f;

@interface SNTableView () <SNTableViewCellAction>

@property (nonatomic, assign) CGPoint defaultContentOffset;

@end

@implementation SNTableView {
    BOOL _firstLoad;
}

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark -
#pragma mark Accessors

- (CGPoint)defaultContentOffset {
    return CGPointMake(0, -self.defaultScrollViewInsets.top);
}

- (void)setDefaultScrollViewInsets:(UIEdgeInsets)defaultScrollViewInsets {
    _defaultScrollViewInsets = defaultScrollViewInsets;
    self.contentInset = defaultScrollViewInsets;
    self.contentOffset = self.defaultContentOffset;
}

- (SNTableCellItem *)bottomPlaceholderCellItem {
    if (nil == _bottomPlaceholderCellItem) {
        _bottomPlaceholderCellItem = [SNTablePlaceholderCellItem defaultCellItem];
    }
    return _bottomPlaceholderCellItem;
}

- (SNTableCellItem *)emptyCellItem {
    if (nil == _emptyCellItem) {
        _emptyCellItem = [SNTableEmptyCellItem itemWithTipString:@""];
        _emptyCellItem.cellHeight = self.height - self.contentInset.top;
    }
    return _emptyCellItem;
}

- (SNTableCellItem *)loadingCellItem {
    if (nil == _loadingCellItem) {
        _loadingCellItem = [[SNTableLoadingCellItem alloc] init];
        _loadingCellItem.cellHeight = self.height - self.contentInset.top;
    }
    return _loadingCellItem;
}

#pragma mark -
#pragma mark Initializtion

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if ((self = [super initWithFrame:frame style:style])) {
        
        self.defaultScrollViewInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _firstLoad = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.dataSource = self;
        self.delegate = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.allowScrolling = YES;
//        self.subViewsShouldSyncScrollEnabledStatus = NO;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero style:UITableViewStylePlain];
}

#pragma mark -
#pragma mark TableView Behaviours

- (void)delayReloadData {
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.2f];
}

#pragma mark -
#pragma mark DataSource Loading

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:animation];
}

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath {
    [self reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -
#pragma mark Data source

- (SNTableCellItem *)cellItemAtIndexPath:(NSIndexPath *)indexPath  {

    SNTableCellItem *theCellItem = nil;
    
    if ([[self.lfDelegate cellItemsForTableView:self] count] == 0) {
        
        if (_firstLoad) {
            self.scrollEnabled = NO;
            return self.loadingCellItem;
        } else {
            self.scrollEnabled = self.allowScrolling;
            return self.emptyCellItem;
        }
        
    } else {
        
        self.scrollEnabled = self.allowScrolling;
        
        NSArray *dataSource = [self.lfDelegate cellItemsForTableView:self];
        if (indexPath.row < [dataSource count]) {
            id item = [[self.lfDelegate cellItemsForTableView:self] sn_objectAtSafeIndex:indexPath.row];
            if ([item isKindOfClass:[SNTableCellItem class]]) {
                theCellItem = (SNTableCellItem *)item;
            } else {
                LogE(@"Invalid TableCell item!");
            }
        } else {
            return self.bottomPlaceholderCellItem;
        }
    }
    
    return theCellItem;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // For this moment we do not support section yet. A little different from SNCollectionView.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger itemsCount = [[self.lfDelegate cellItemsForTableView:self] count];
    return MAX(itemsCount, 1);
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SNTableCellItem *cellItem = [self cellItemAtIndexPath:indexPath];
    
    cellItem.indexPath = indexPath;
    
    if (cellItem.cellWidth < 0) cellItem.cellWidth = self.width;
    
    SNTableViewCell *cell = (SNTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellItem.identifier];
    
    if (!cell) {
        cell = [[cellItem.cellClass alloc] initWithStyle:cellItem.cellStyle reuseIdentifier:cellItem.identifier cellItem:cellItem];
        cell.delegate = self;
    }
    
    //  Set all kinds of types
    cell.accessoryType = cellItem.cellAccessoryType;
    cell.selectionStyle = cellItem.cellSelectionStyle;
    
    if ([cellItem isKindOfClass:[SNTableLoadingMoreCellItem class]] ) {

        SNTableLoadingMoreCellItem *loadingMoreCellItem = (SNTableLoadingMoreCellItem *)cellItem;

        loadingMoreCellItem.showSpinner = YES;
        
        if (!loadingMoreCellItem.shouldNotLoadMore && [self.lfDelegate respondsToSelector:@selector(moreItemsWillLoadWithTableView:)]) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(SNTableViewMinimalLoadingDelaySeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.lfDelegate moreItemsWillLoadWithTableView:self];
            });
        }
    }
    
    if (cellItem) {
        cell.cellItem = cellItem;
    }
    
    cell.indexPath = indexPath;
    
    _firstLoad = NO;
    return cell;
    
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SNTableCellItem *item = [self cellItemAtIndexPath:indexPath];
    
    if (!item.selectable) {
        return;
    }
    
    if (item.selectable && item.deselectAfterSelecting) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    if ([self.lfDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:withCellItem:)]) {
        [self.lfDelegate tableView:self didSelectRowAtIndexPath:indexPath withCellItem:item];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.lfDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:withCellItem:)]) {
        SNTableCellItem *item = [self cellItemAtIndexPath:indexPath];
        [self.lfDelegate tableView:self
                   willDisplayCell:(SNTableViewCell *)cell
                 forRowAtIndexPath:indexPath
                      withCellItem:item];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SNTableCellItem *item = [self cellItemAtIndexPath:indexPath];
    return item.cellHeight;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if (fromIndexPath.row == toIndexPath.row) {
        return;
    }
    
    NSMutableArray *dataSource = [self.lfDelegate cellItemsForTableView:self];
    
    SNTableCellItem *cellItem = [self cellItemAtIndexPath:fromIndexPath];
    
    [dataSource removeObjectAtIndex:fromIndexPath.row];
    [dataSource insertObject:cellItem atIndex:toIndexPath.row];
    
    if ([self.lfDelegate respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [self.lfDelegate tableView:tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.lfDelegate respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        return [self.lfDelegate tableView:self canMoveRowAtIndexPath:indexPath];
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteCellAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)moveCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSMutableArray *items = (NSMutableArray *)[self.lfDelegate cellItemsForTableView:self];
    SNTableCellItem *cellItem = [items objectAtIndex:fromIndexPath.row];
    [items removeObjectAtIndex:fromIndexPath.row];
    [items insertObject:cellItem atIndex:toIndexPath.row];
}

- (void)deleteCellAtIndexPaths:(NSArray *)indexPathArray withRowAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray *items = (NSMutableArray *)[self.lfDelegate cellItemsForTableView:self];
    if ([items count] == 1) {
        [items removeAllObjects];
        [self reloadData];
        return;
    }
    NSMutableArray *deleteCellItems = [NSMutableArray arrayWithCapacity:[indexPathArray count]];
    for (NSIndexPath *indexPath in indexPathArray) {
        [deleteCellItems addObject:[items objectAtIndex:indexPath.row]];
    }
    [items removeObjectsInArray:deleteCellItems];
    [self beginUpdates];
    [self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:animation];
    [self endUpdates];
    [self delayReloadData];
}

- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    
    NSMutableArray *items = (NSMutableArray *)[self.lfDelegate cellItemsForTableView:self];
    if ([items count] == 1 && indexPath.row == 0) {
        [items removeAllObjects];
        [self reloadData];
        return;
    }
    
    [self beginUpdates];
    
    SNTableCellItem *itemToRemove = [items objectAtIndex:indexPath.row];
    [items removeObjectAtIndex:indexPath.row];
    [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:animation];
    [self endUpdates];
    
    if ([self.lfDelegate respondsToSelector:@selector(tableView:cellItemDidDelete:atIndexPath:)]) {
        [self.lfDelegate tableView:self cellItemDidDelete:itemToRemove atIndexPath:indexPath];
    }
    [self delayReloadData];
}

- (void)appendCellItem:(SNTableCellItem *)cellItem WithRowAnimation:(UITableViewRowAnimation)animation {
    [self appendCellItem:cellItem WithRowAnimation:animation];
    
    NSUInteger itemsCount = [[self.lfDelegate cellItemsForTableView:self] count];
    NSIndexPath *path = [NSIndexPath indexPathForRow:itemsCount inSection:0];
    [self insertCellItem:cellItem AtIndexPath:path withRowAnimation:animation];
}

- (void)insertCellItem:(SNTableCellItem *)cellItem AtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    
    [self beginUpdates];
    NSMutableArray *items = (NSMutableArray *)[self.lfDelegate cellItemsForTableView:self];
    [items insertObject:cellItem atIndex:indexPath.row];
    [self insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:animation];
    [self endUpdates];
    
    [self delayReloadData];
}

- (void)insertCellItems:(NSArray *)cellItems atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    
    [self beginUpdates];
    NSMutableArray *items = (NSMutableArray *)[self.lfDelegate cellItemsForTableView:self];
    
    NSMutableArray *indexes = [NSMutableArray arrayWithCapacity:[cellItems count]];
    NSIndexPath *curIndexPath;
    for (int i = 0; i < [cellItems count]; i++) {
        id item = [cellItems objectAtIndex:i];
        curIndexPath = [NSIndexPath indexPathForRow:indexPath.row + i inSection:indexPath.section];
        [items insertObject:item atIndex:curIndexPath.row];
        [indexes addObject:curIndexPath];
    }
    
    [self insertRowsAtIndexPaths:indexes withRowAnimation:animation];
    [self endUpdates];
    
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

#pragma mark -
#pragma mark SNTableView Editing

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.lfDelegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.lfDelegate tableView:self editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.lfDelegate respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.lfDelegate tableView:self canEditRowAtIndexPath:indexPath];
    }
    return NO;
}

#pragma mark -
#pragma mark SNTableView Cell Actions

- (void)tableViewCell:(SNTableViewCell *)tableViewCell
      actionOnControl:(id)control
         controlEvent:(UIControlEvents)event
             userInfo:(id)userInfo
             selector:(SEL)selector
{
    NSIndexPath *indexPath = tableViewCell.indexPath;
    
    if ([indexPath compare:[self indexPathForCell:tableViewCell]] != NSOrderedSame) {
        indexPath = [self indexPathForCell:tableViewCell];
    }
    
    SNTableCellItem *cellItem = [self cellItemAtIndexPath:indexPath];
    
    if (selector != nil && [self.lfDelegate respondsToSelector:@selector(tableView:actionWithSelector:info:)]) {
        if (tableViewCell && cellItem && control && indexPath) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict sn_setSafeObject:tableViewCell forKey:SNTableViewCellActionInfoCellKey];
            [dict sn_setSafeObject:cellItem forKey:SNTableViewCellActionInfoCellItemKey];
            [dict sn_setSafeObject:control forKey:SNTableViewCellActionInfoControlKey];
            [dict sn_setSafeObject:indexPath forKey:SNTableViewCellActionInfoIndexPathKey];
            [dict sn_setSafeObject:userInfo forKey:SNTableViewCellActionInfoUserInfoKey];
            [self.lfDelegate tableView:self
                    actionWithSelector:selector
                                  info:dict];
        }
    } else if ([self.lfDelegate respondsToSelector:@selector(tableView:actionOnTableCell:atIndexPath:tableCellItem:control:controlEvent:userInfo:)]) {
        [self.lfDelegate tableView:self
                 actionOnTableCell:tableViewCell
                       atIndexPath:indexPath
                     tableCellItem:cellItem
                           control:control
                      controlEvent:event
                          userInfo:userInfo];
    }
}

- (void)tableViewCell:(SNTableViewCell *)tableViewCell
      actionOnControl:(id)control
         controlEvent:(UIControlEvents)event
             userInfo:(id)userInfo
{
    [self tableViewCell:tableViewCell actionOnControl:control controlEvent:event userInfo:userInfo selector:nil];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
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
}

@end

@implementation NSMutableArray (SNTableView)

- (CGFloat)sn_totalCellItemHeight {
    CGFloat totalHeight = 0;
    for (SNTableCellItem *cellItem in self) {
        totalHeight += cellItem.cellHeight;
    }
    return totalHeight;
}

- (void)sn_trimDataSource {
    
    SNTableCellItem *lastCellItem = [self lastObject];
    
    while ([lastCellItem isKindOfClass:[SNTableLoadingMoreCellItem class]] || [lastCellItem isKindOfClass:[SNTableLoadingCellItem class]] || [lastCellItem isKindOfClass:[SNTablePlaceholderCellItem class]]) {
        [self removeLastObject];
        lastCellItem = [self lastObject];
    }
}


@end
