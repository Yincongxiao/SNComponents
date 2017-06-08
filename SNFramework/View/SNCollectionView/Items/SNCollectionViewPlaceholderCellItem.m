//
//  SNCollectionViewPlaceholderCellItem.m
//  QDaily
//
//  Created by AsnailNeo on 4/12/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewPlaceholderCellItem.h"

@implementation SNCollectionViewPlaceholderCellItem

+ (instancetype)defaultCellItem {
    return [[SNCollectionViewPlaceholderCellItem alloc] init];
}

- (instancetype)init {
    return [self initWithHeight:50];
}

- (instancetype)initWithHeight:(CGFloat)height {
    if (self = [super init]) {
        self.cellHeight = height;
        self.selectable = NO;
    }
    return self;
}

@end
