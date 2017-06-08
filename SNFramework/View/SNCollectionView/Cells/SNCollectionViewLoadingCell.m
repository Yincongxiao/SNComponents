//
//  SNCollectionViewLodingCell.m
//  QDaily
//
//  Created by AsnailNeo on 3/3/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewLoadingCell.h"
#import "SNCollectionViewLoadingCellItem.h"

@implementation SNCollectionViewLoadingCell

#pragma mark -
#pragma mark Accessors
- (UILabel *)tipLabel {
    if (nil == _tipLabel) {
        _tipLabel = [[UILabel alloc] init];
    }
    return _tipLabel;
}

- (UIActivityIndicatorView *)spinner {
    if (nil == _spinner) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _spinner.backgroundColor = [UIColor clearColor];
    }
    return _spinner;
}

#pragma mark -
#pragma mark Life cycle

- (instancetype)init {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    [self.contentView addSubview:self.tipLabel];
    [self.contentView addSubview:self.spinner];
    [self.spinner startAnimating];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)prepareForSettingCellItem:(SNCollectionViewLoadingCellItem *)cellItem {
    
    [super prepareForSettingCellItem:cellItem];
    
    if (![cellItem isKindOfClass:[SNCollectionViewLoadingCellItem class]]) {
        return;
    }
    
    self.tipLabel.frame = cellItem.tipLabelRect;
    self.tipLabel.text = cellItem.loadingTip;
    self.spinner.frame = cellItem.spinnerRect;
    
    if (cellItem.showLoadingSpinner) {
        [self.spinner startAnimating];
    }
}

@end
