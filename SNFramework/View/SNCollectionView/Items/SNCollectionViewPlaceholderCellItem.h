//
//  SNCollectionViewPlaceholderCellItem.h
//  QDaily
//
//  Created by AsnailNeo on 4/12/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewCellItem.h"

@interface SNCollectionViewPlaceholderCellItem : SNCollectionViewCellItem

+ (instancetype)defaultCellItem;

- (instancetype)initWithHeight:(CGFloat)height;

@end
