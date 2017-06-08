//
//  SNTableEmptyCellItem.m
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTableEmptyCellItem.h"
#import "SNTableViewEmptyCell.h"
#import "UIScreen+SNAdditions.h"

@implementation SNTableEmptyCellItem

+ (instancetype)itemWithTipString:(NSString *)tipString {
    SNTableEmptyCellItem *cellItem = [[SNTableEmptyCellItem alloc] init];
    cellItem.tipString = tipString;
    return cellItem;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.cellHeight = [UIScreen sn_screenHeight];
        self.cellClass = [SNTableViewEmptyCell class];
        self.selectable = NO;
        self.cellAccessoryType = UITableViewCellAccessoryNone;
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
