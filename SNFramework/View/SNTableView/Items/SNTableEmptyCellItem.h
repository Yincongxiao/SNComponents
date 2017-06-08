//
//  SNTableEmptyCellItem.h
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTableCellItem.h"

@interface SNTableEmptyCellItem : SNTableCellItem

@property (nonatomic, copy) NSString *tipString;
@property (nonatomic, assign) CGRect tipImageRect;

+ (instancetype)itemWithTipString:(NSString *)tipString;

@end
