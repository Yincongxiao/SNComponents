//
//  SNTableLoadingMoreCellItem.m
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTableLoadingMoreCellItem.h"
#import "SNTableLoadingMoreCell.h"

@implementation SNTableLoadingMoreCellItem

- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.cellClass = [SNTableLoadingMoreCell class];
        self.selectable = NO;
        self.showSpinner = NO;
        self.cellHeight = 85;
        self.cellAccessoryType = UITableViewCellAccessoryNone;
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)reset {
    self.showSpinner = NO;
}

+ (instancetype)fakeLoadMoreCellItem {
    SNTableLoadingMoreCellItem *shouldNotLoadMoreCellItem = [[SNTableLoadingMoreCellItem alloc] init];
    shouldNotLoadMoreCellItem.shouldNotLoadMore = YES;
    return shouldNotLoadMoreCellItem;
}

+ (instancetype)defaultCellItem {
    return [[SNTableLoadingMoreCellItem alloc] init];
}

+ (instancetype)cellItemWithTitle:(NSString *)title {
    SNTableLoadingMoreCellItem *cellItem = [[SNTableLoadingMoreCellItem alloc] init];
    cellItem.title = title;
    return cellItem;
}

@end
