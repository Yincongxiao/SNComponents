//
//  SNTableLoadingMoreCellItem.h
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTableCellItem.h"

@interface SNTableLoadingMoreCellItem : SNTableCellItem

@property (nonatomic, assign) BOOL showSpinner;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL shouldNotLoadMore;

- (void)reset;
+ (instancetype)defaultCellItem;
+ (instancetype)fakeLoadMoreCellItem;
+ (instancetype)cellItemWithTitle:(NSString *)title;

@end
