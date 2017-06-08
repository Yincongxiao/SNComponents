//
//  SNCollectionViewCell.h
//  QDaily
//
//  Created by AsnailNeo on 2/1/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNCollectionViewCellItem.h"

@class SNCollectionViewCell;

@protocol SNCollectionViewCellAction <NSObject>

@optional

- (void)collectionViewCell:(SNCollectionViewCell *)collectionViewCell
           actionOnControl:(id)control
              controlEvent:(UIControlEvents)event
                  userInfo:(id)userInfo;

- (void)collectionViewCell:(SNCollectionViewCell *)collectionViewCell
           actionOnControl:(id)control
              controlEvent:(UIControlEvents)event
                  userInfo:(id)userInfo
                  selector:(SEL)selector;

@end

@interface SNCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<SNCollectionViewCellAction> delegate;
@property (nonatomic, weak) SNCollectionViewCellItem *cellItem;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)willDisplay;
- (void)didEndDisplay;

@end

@interface SNCollectionViewCell (SNSubclassing)

// Methods in this class are meant to be overridden.
// Called by the SNCollectionViewCell before the instance is about to be associated with a new SNCollectionViewCellItem.
// Subclassers must call super.
- (void)prepareForSettingCellItem:(SNCollectionViewCellItem *)cellItem;
- (void)finalizeSettingCellItem:(SNCollectionViewCellItem *)cellItem;

@end
