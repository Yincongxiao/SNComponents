//
//  SNCollectionViewEmptyCellItem.h
//  QDaily
//
//  Created by AsnailNeo on 3/3/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewCellItem.h"

@interface SNCollectionViewEmptyCellItem : SNCollectionViewCellItem

@property (nonatomic, copy) NSString *tipImageName;
@property (nonatomic, copy) NSString *tipString;
@property (nonatomic, assign) CGRect tipImageRect;

+ (instancetype)itemWithTipString:(NSString *)tipString;

+ (instancetype)itemWithTipString:(NSString *)tipString tipImageName:(NSString *)tipImageName cellHeight:(NSUInteger)cellHeight;

@end
