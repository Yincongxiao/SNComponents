//
//  SNTableViewEmptyCell.m
//  QDaily
//
//  Created by AsnailNeo on 5/7/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTableViewEmptyCell.h"
#import "SNTableEmptyCellItem.h"
#import "UIView+SNAdditions.h"

@implementation SNTableViewEmptyCell

#pragma mark -
#pragma mark Accessors
- (UIImageView *)tipImageView {
    if (nil == _tipImageView) {
        _tipImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _tipImageView.backgroundColor = [UIColor clearColor];
    }
    return _tipImageView;
}

- (UILabel *)tipLabel {
    if (nil == _tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:14];
    }
    return _tipLabel;
}

#pragma mark -
#pragma mark Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellItem:(SNTableEmptyCellItem *)cellItem {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier cellItem:cellItem];

    if (self) {
        [self addSubview:self.tipLabel];
    }
    
    return self;
}

- (void)prepareForSettingCellItem:(SNTableEmptyCellItem *)cellItem {
    [super prepareForSettingCellItem:cellItem];
    
    self.tipLabel.text = cellItem.tipString;
    self.tipLabel.height = cellItem.cellHeight;
}

@end
