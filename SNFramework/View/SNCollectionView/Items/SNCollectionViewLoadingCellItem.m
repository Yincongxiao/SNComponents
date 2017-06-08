//
//  SNCollectionViewLoadingCellItem.m
//  QDaily
//
//  Created by AsnailNeo on 3/3/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewLoadingCellItem.h"
#import "SNCollectionViewLoadingCell.h"
#import "SNAdditions.h"

@implementation SNCollectionViewLoadingCellItem

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
        self.cellWidth = cellWidth;
        self.cellHeight = cellHeight;
        
        self.cellClass = [SNCollectionViewLoadingCell class];
        self.selectable = NO;
        self.showLoadingSpinner = YES;
    }
    return self;
}

- (void)layoutRects {
    //  Reset the rects of tipLabel and Spinner
    if ([self.loadingTip length] == 0) {
        self.tipLabelRect = CGRectZero;
        self.spinnerRect = CGRectMake(floorf((self.cellWidth - 20) / 2), floorf((self.cellHeight - 20) / 2), 20, 20);
    }
}

@end
