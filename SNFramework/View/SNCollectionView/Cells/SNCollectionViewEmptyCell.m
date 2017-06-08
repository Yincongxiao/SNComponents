//
//  SNCollectionViewEmptyCell.m
//  QDaily
//
//  Created by AsnailNeo on 3/3/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewEmptyCell.h"
#import "SNCollectionViewEmptyCellItem.h"
#import "UIView+SNAdditions.h"

@implementation SNCollectionViewEmptyCell

#pragma mark -
#pragma mark Accessors
- (UIImageView *)tipImageView {
    if (nil == _tipImageView) {
        _tipImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _tipImageView;
}

- (UILabel *)tipLabel {
    if (nil == _tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    return _tipLabel;
}

#pragma mark -
#pragma mark Life cycle

- (void)prepareForSettingCellItem:(SNCollectionViewEmptyCellItem *)cellItem {

    [super prepareForSettingCellItem:cellItem];
        
    if (cellItem.tipImageName) {
        if (!self.tipImageView.superview) {
            [self addSubview:self.tipImageView];
        }
    }
    
    self.tipLabel.text = cellItem.tipString;
    self.tipLabel.height = cellItem.cellHeight;
    
    if (cellItem.tipImageName) {
        
        self.tipImageView.image = [UIImage imageNamed:cellItem.tipImageName];
        [self.tipImageView sizeToFit];
        self.tipImageView.left = (self.width - self.tipImageView.width)/2;
        self.tipImageView.top = cellItem.cellHeight/2 - self.tipImageView.height/2 - 10;
        
        [self.tipLabel sizeToFit];
        self.tipLabel.left = (self.width - self.tipLabel.width)/2;
        self.tipLabel.top = self.tipImageView.bottom + 15;
        
    }

}

@end
