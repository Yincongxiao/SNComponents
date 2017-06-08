//
//  SNCollectionViewDelegate.h
//  QDaily
//
//  Created by AsnailNeo on 2/1/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SNCollectionView;
@class SNCollectionViewCell;
@class SNCollectionViewCellItem;

@protocol SNCollectionViewDelegate <NSObject>

@required

#pragma mark - Data Source (CellItem - Cell)

- (NSMutableArray *)cellItemSectionsForCollectionView:(SNCollectionView *)collectionView;

@optional

#pragma mark - Data Source (Supplementary)

- (NSMutableArray *)supplementaryItemsForCollectionView:(SNCollectionView *)collectionView withKind:(NSString *)kind;

#pragma mark - CollectionView Delegate

- (void)collectionView:(SNCollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
          withCellItem:(SNCollectionViewCellItem *)cellItem;

- (void)collectionView:(SNCollectionView *)collectionView
       willDisplayCell:(SNCollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
          withCellItem:(SNCollectionViewCellItem *)cellItem;

- (void)collectionView:(SNCollectionView *)collectionView
       didEndDisplayCell:(SNCollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
          withCellItem:(SNCollectionViewCellItem *)cellItem;

#pragma mark - Update DataSource

- (void)moreItemsWillLoadWithCollectionView:(SNCollectionView *)collectionView;
- (void)itemsWillReloadWithCollectionView:(SNCollectionView *)collectionView;
- (void)skyRefreshToggledWithCollectionView:(SNCollectionView *)collectionView;

#pragma mark - CollectionViewCell Actions

- (void)collectionView:(SNCollectionView *)collectionView
          actionOnCell:(SNCollectionViewCell *)collectionViewCell
             indexPath:(NSIndexPath *)indexPath
              cellItem:(SNCollectionViewCellItem *)cellItem
               control:(id)control
          controlEvent:(UIControlEvents)event
              userInfo:(id)userInfo;

- (void)collectionView:(SNCollectionView *)collectionView
    actionWithSelector:(SEL)selector
                  info:(NSDictionary *)info;

#pragma mark - UIScrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

@end

