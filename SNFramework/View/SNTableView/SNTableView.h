//
//  SNTableView.h
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNTableViewDelegate.h"
#import "SNTableEmptyCellItem.h"
#import "SNTablePlaceholderCellItem.h"
#import "SNTableLoadingMoreCellItem.h"
#import "SNTableLoadingCellItem.h"

extern NSString * const SNTableViewCellActionInfoCellKey;
extern NSString * const SNTableViewCellActionInfoCellItemKey;
extern NSString * const SNTableViewCellActionInfoIndexPathKey;
extern NSString * const SNTableViewCellActionInfoControlKey;
extern NSString * const SNTableViewCellActionInfoUserInfoKey;

@interface SNTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<SNTableViewDelegate> lfDelegate;
@property (nonatomic, assign) BOOL allowScrolling;

@property (nonatomic, assign) UIEdgeInsets defaultScrollViewInsets;

@property (nonatomic, strong) SNTableCellItem *emptyCellItem;
@property (nonatomic, strong) SNTableCellItem *loadingCellItem;
@property (nonatomic, strong) SNTableCellItem *bottomPlaceholderCellItem;

- (void)delayReloadData;

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)insertCellItems:(NSArray *)cellItems atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)insertCellItem:(SNTableCellItem *)cellItem AtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

- (SNTableCellItem *)cellItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface NSMutableArray (SNTableView)

- (CGFloat)sn_totalCellItemHeight;
- (void)sn_trimDataSource;

@end
