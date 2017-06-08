//
//  SNCollectionView.h
//  QDaily
//
//  Created by AsnailNeo on 2/1/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SNCollectionViewDelegate.h"
#import "SNCollectionViewLayout.h"
#import "SNCollectionViewCell.h"
#import "SNCollectionViewCellItem.h"
#import "SNCollectionSupplementaryViewItem.h"

extern NSString * const SNCollectionViewCellActionInfoCellKey;
extern NSString * const SNCollectionViewCellActionInfoCellItemKey;
extern NSString * const SNCollectionViewCellActionInfoIndexPathKey;
extern NSString * const SNCollectionViewCellActionInfoControlKey;
extern NSString * const SNCollectionViewCellActionInfoUserInfoKey;

typedef NS_ENUM(NSUInteger, SNCollectionViewVerticalScrollDirection) {
    SNCollectionViewVerticalScrollDirectionUp = 1,
    SNCollectionViewVerticalScrollDirectionDown,
};

@interface SNCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate, SNCollectionViewCellAction>

@property (nonatomic, weak) NSObject<SNCollectionViewDelegate> *lfDelegate;
@property (nonatomic, weak, readonly) SNCollectionViewLayout *lfCollectionViewLayout;
@property (nonatomic, assign) BOOL allowScrolling;
@property (nonatomic, assign) BOOL disableTopBounces;
@property (nonatomic, assign, readonly) SNCollectionViewVerticalScrollDirection verticalScrollDirection;

@property (nonatomic, strong) SNCollectionViewCellItem *emptyCellItem;
@property (nonatomic, strong) SNCollectionViewCellItem *loadingCellItem;
@property (nonatomic, strong) SNCollectionViewCellItem *bottomPlaceholderCellItem;

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(SNCollectionViewLayout *)layout;

- (NSMutableArray *)cellItemsOfSection:(NSUInteger)section;
- (SNCollectionViewCellItem *)cellItemAtIndexPath:(NSIndexPath *)indexPath;
- (SNCollectionSupplementaryViewItem *)supplementaryItemAtIndexPath:(NSIndexPath *)indexPath withKind:(NSString *)kind;

//- (void)insertCellItems:(NSArray *)cellItems atIndexPath:(NSIndexPath *)indexPath;
- (void)insertCellItems:(NSArray <SNCollectionViewCellItem *>*)cellItems atIndexPaths:(NSArray <NSIndexPath *>*)indexPaths;
- (void)insertCellItem:(SNCollectionViewCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath;
- (void)deleteCellItem:(SNCollectionViewCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath;
- (void)reloadCellItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)scrollToTopAnimated:(BOOL)animated;

/**
 * Pulldown Refreshing
 */
- (void)enablePullDownRefreshWithDrawingImage:(NSArray *)drawingImages loadingImage:(NSArray *)loadingImages height:(CGFloat)height imageSize:(CGSize)size;
- (void)enableDragDownRefreshControl;
- (void)pullDownRefreshDidFinish;
- (void)doPulldownRefreshAnimated:(BOOL)animated;
- (void)removeRefreshControl;
@end

@interface NSMutableArray (SNCollectionView)

@property (readonly) NSIndexPath *sn_lastIndexPath;

- (BOOL)sn_isValidIndexPath:(NSIndexPath *)indexPath;

- (void)sn_addObjectToLastSection:(id)object;
- (void)sn_removeObjectFromLastSection:(id)object;

- (void)sn_addObjectsToLastSectionFromArray:(NSArray *)objects;

- (NSMutableArray *)sn_dataSourceOfSection:(NSUInteger)section;

- (void)sn_trimLastSection;
- (NSMutableArray *)sn_lastSection;

@end
