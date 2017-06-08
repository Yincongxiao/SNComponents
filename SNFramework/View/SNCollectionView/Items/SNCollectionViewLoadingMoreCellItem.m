//
//  SNCollectionViewLoadingMoreCellItem.m
//  QDaily
//
//  Created by AsnailNeo on 2/27/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewLoadingMoreCellItem.h"
#import "SNCollectionViewLoadingMoreCell.h"

@implementation SNCollectionViewLoadingMoreCellItem

- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.cellClass = [SNCollectionViewLoadingMoreCell class];
        self.selectable = NO;
        self.showSpinner = NO;
        self.cellHeight = 75;
    }
    return self;
}

- (void)reset {
    self.showSpinner = NO;
}

+ (instancetype)fakeLoadMoreCellItem {
    SNCollectionViewLoadingMoreCellItem *shouldNotLoadMoreCellItem = [[SNCollectionViewLoadingMoreCellItem alloc] init];
    shouldNotLoadMoreCellItem.shouldNotLoadMore = YES;
    return shouldNotLoadMoreCellItem;
}

+ (instancetype)defaultCellItem {
    return [[SNCollectionViewLoadingMoreCellItem alloc] init];
}

+ (instancetype)cellItemWithTitle:(NSString *)title {
    SNCollectionViewLoadingMoreCellItem *cellItem = [[SNCollectionViewLoadingMoreCellItem alloc] init];
    cellItem.title = title;
    return cellItem;
}

@end
