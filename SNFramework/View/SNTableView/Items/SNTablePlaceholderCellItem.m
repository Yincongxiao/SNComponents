//
//  LBTablePlaceholderCellItem.m
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTablePlaceholderCellItem.h"
#import "SNTableViewCell.h"

@implementation SNTablePlaceholderCellItem

- (instancetype)init {
    return [self initWithHeight:50];
}

- (instancetype)initWithTabbarHeight {
    return [self initWithHeight:60];
}

- (instancetype)initWithHeight:(CGFloat)height {
    if (self = [super init]) {
        self.cellHeight = height;
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
        self.cellAccessoryType = UITableViewCellAccessoryNone;
        self.cellClass = [SNTableViewCell class];
        self.selectable = NO;
    }
    return self;
}

+ (instancetype)defaultCellItem {
    return [[SNTablePlaceholderCellItem alloc] init];
}

+ (instancetype)itemWithHeight:(CGFloat)height {
    return [[SNTablePlaceholderCellItem alloc] initWithHeight:height];
}

@end
