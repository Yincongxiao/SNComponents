//
//  SNTableLoadingCell.m
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTableLoadingCell.h"
#import "SNTableLoadingCellItem.h"

@implementation SNTableLoadingCell

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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellItem:(SNTableCellItem *)cellItem {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier cellItem:cellItem];
    if (self) {
        
        [self.contentView addSubview:self.tipLabel];
        [self.contentView addSubview:self.spinner];
        [self.spinner startAnimating];
        
    }
    return self;
}

- (void)prepareForSettingCellItem:(SNTableLoadingCellItem *)cellItem {
    [super prepareForSettingCellItem:cellItem];
    
    self.tipLabel.frame = cellItem.tipLabelRect;
    self.tipLabel.text = cellItem.loadingTip;
    self.spinner.frame = cellItem.spinnerRect;
    
    if (cellItem.showLoadingSpinner) {
        [self.spinner startAnimating];
    }
}


@end
