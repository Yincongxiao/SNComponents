//
//  SNTableViewCell.h
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNTableCellItem.h"

@class SNTableViewCell;

@protocol SNTableViewCellAction <NSObject>

@optional

- (void)tableViewCell:(SNTableViewCell *)tableViewCell
      actionOnControl:(id)control
         controlEvent:(UIControlEvents)event
             userInfo:(id)userInfo;

- (void)tableViewCell:(SNTableViewCell *)tableViewCell
      actionOnControl:(id)control
         controlEvent:(UIControlEvents)event
             userInfo:(id)userInfo
             selector:(SEL)selector;

@end

@interface SNTableViewCell : UITableViewCell

@property (nonatomic, weak) id<SNTableViewCellAction> delegate;
@property (nonatomic, weak) SNTableCellItem *cellItem;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                     cellItem:(SNTableCellItem *)cellItem;

@end

@interface SNTableViewCell (SNSubclassing)

// Methods in this class are meant to be overridden.
// Called by the SNCollectionViewCell before the instance is about to be associated with a new SNCollectionViewCellItem.
// Subclassers must call super.
- (void)prepareForSettingCellItem:(SNTableCellItem *)cellItem;
- (void)finalizeSettingCellItem:(SNTableCellItem *)cellItem;

@end
