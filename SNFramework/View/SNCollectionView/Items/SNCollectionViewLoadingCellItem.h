//
//  SNCollectionViewLoadingCellItem.h
//  QDaily
//
//  Created by AsnailNeo on 3/3/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewCellItem.h"

@interface SNCollectionViewLoadingCellItem : SNCollectionViewCellItem

@property (nonatomic, copy) NSString *loadingTip;
@property (nonatomic, assign) CGRect tipLabelRect;
@property (nonatomic, assign) CGRect spinnerRect;
@property (nonatomic, assign) BOOL showLoadingSpinner;

- (instancetype)initWithCellHeight:(CGFloat)cellHeight cellWidth:(CGFloat)cellWidth;
- (instancetype)initWithLoadingTip:(NSString *)loadingTip cellHeight:(CGFloat)cellHeight cellWidth:(CGFloat)cellWidth;

@end
