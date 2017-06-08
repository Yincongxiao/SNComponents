//
//  SNCollectionViewEmptyCellItem.m
//  QDaily
//
//  Created by AsnailNeo on 3/3/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewEmptyCellItem.h"
#import "SNCollectionViewEmptyCell.h"

@implementation SNCollectionViewEmptyCellItem

- (instancetype)init {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.cellClass = [SNCollectionViewEmptyCell class];
    self.selectable = NO;
    self.cellHeight = [UIScreen mainScreen].bounds.size.height;
    
    return self;
}

+ (instancetype)itemWithTipString:(NSString *)tipString tipImageName:(NSString *)tipImageName cellHeight:(NSUInteger)cellHeight {
    SNCollectionViewEmptyCellItem *cellItem = [[SNCollectionViewEmptyCellItem alloc] init];
    cellItem.tipString = tipString;
    cellItem.tipImageName = tipImageName;
    cellItem.cellHeight = cellHeight;
    return cellItem;
}

+ (instancetype)itemWithTipString:(NSString *)tipString {
    SNCollectionViewEmptyCellItem *cellItem = [[SNCollectionViewEmptyCellItem alloc] init];
    cellItem.tipString = tipString;
    return cellItem;
}

@end
