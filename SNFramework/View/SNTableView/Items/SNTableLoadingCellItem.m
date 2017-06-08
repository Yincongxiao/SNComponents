//
//  LBTableLoadingCellItem.m
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTableLoadingCellItem.h"
#import "SNTableLoadingCell.h"
#import "UIScreen+SNAdditions.h"

@implementation SNTableLoadingCellItem

#pragma mark -
#pragma mark Accessors

- (void)setLoadingTip:(NSString *)loadingTip {
    if (loadingTip != _loadingTip) {
        _loadingTip = [loadingTip copy];
    }
    [self layoutRects];
}

- (void)setCellHeight:(CGFloat)cellHeight {
    [super setCellHeight:cellHeight];
    [self layoutRects];
}

- (void)setCellWidth:(CGFloat)cellWidth {
    [super setCellWidth:cellWidth];
    [self layoutRects];
}

#pragma mark -
#pragma mark Life cycle

- (instancetype)init {
    return [self initWithLoadingTip:nil cellHeight:[UIScreen sn_screenHeight] cellWidth:[UIScreen sn_screenWidth]];
}

- (instancetype)initWithCellHeight:(CGFloat)cellHeight cellWidth:(CGFloat)cellWidth {
    return [self initWithLoadingTip:nil cellHeight:cellHeight cellWidth:cellWidth];
}

- (instancetype)initWithLoadingTip:(NSString *)loadingTip cellHeight:(CGFloat)cellHeight cellWidth:(CGFloat)cellWidth {
    self = [super init];
    if (self) {
        self.loadingTip = loadingTip;
        self.cellHeight = cellHeight;
        self.cellWidth = cellWidth;
        
        self.cellClass = [SNTableLoadingCell class];
        self.selectable = NO;
        self.showLoadingSpinner = YES;
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
        self.cellAccessoryType = UITableViewCellAccessoryNone;
        
        [self layoutRects];
    }
    return self;
}

- (void)layoutRects {
    if ([self.loadingTip length] == 0) {
        self.tipLabelRect = CGRectZero;
        self.spinnerRect = CGRectMake(floorf((self.cellWidth - 20) / 2), floorf((self.cellHeight - 20) / 2), 20, 20);
    }
}

@end
