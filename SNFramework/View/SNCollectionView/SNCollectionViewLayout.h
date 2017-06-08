//
//  SNCollectionViewLayout.h
//  QDaily
//
//  Created by AsnailNeo on 3/1/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNCollectionView;
@class SNCollectionViewCellItem;

@interface SNCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) BOOL onlyCalculateNewAddedItems; // Default is NO
@property (nonatomic, assign) BOOL extendContentSize;
@property (nonatomic, strong) NSIndexPath *lastCellItemIndexPath;
@property (nonatomic, assign, readonly) CGPoint lastCellLeftBottom;
@property (nonatomic, assign) CGFloat headerViewMargin;
@property (nonatomic, assign) BOOL invalidateLayoutWhenBoundsChange;

@property (nonatomic, readonly) SNCollectionView *lfCollectionView;

// This method will be called as the first line of code in -prepareLayout to provide a opportunity to prepare any relevant calculations.
// Subclasses should always call super if they override.
- (void)willPrepareLayout;

- (void)resetLayoutProperties;

// This method will be called during -prepareLayout to provide a opportunity to prepare layout attributes for SNCellItems.
// Subclasses should always call super if they override.
- (CGPoint)prepareLayoutattributesForCellItem:(SNCollectionViewCellItem *)cellItem
                           withCollectionView:(SNCollectionView *)collectionView;

@end
