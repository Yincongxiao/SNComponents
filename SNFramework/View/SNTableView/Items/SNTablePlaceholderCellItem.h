//
//  LBTablePlaceholderCellItem.h
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTableCellItem.h"

@interface SNTablePlaceholderCellItem : SNTableCellItem

- (instancetype)initWithHeight:(CGFloat)height;
- (instancetype)initWithTabbarHeight;

+ (instancetype)defaultCellItem;
+ (instancetype)itemWithHeight:(CGFloat)height;

@end
