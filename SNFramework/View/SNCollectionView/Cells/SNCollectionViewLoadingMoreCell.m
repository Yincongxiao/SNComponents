//
//  SNCollectionViewLoadingMoreCell.m
//  QDaily
//
//  Created by AsnailNeo on 3/3/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewLoadingMoreCellItem.h"

static const NSUInteger kSNCollectionViewLoadingMoreCellDefaultSpinnerWidth = 20;

#import "SNCollectionViewLoadingMoreCell.h"

@implementation SNCollectionViewLoadingMoreCell

#pragma mark -
#pragma mark Accessors

- (UIActivityIndicatorView *)spinner {
    if (nil == _spinner) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _spinner;
}

#pragma mark -
#pragma mark Initalization

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }

    [self addSubview:self.spinner];
    
    return self;
    
}

- (void)prepareForSettingCellItem:(SNCollectionViewLoadingMoreCellItem *)cellItem {
    
    self.spinner.frame = CGRectMake(floorf((cellItem.cellWidth - kSNCollectionViewLoadingMoreCellDefaultSpinnerWidth) / 2), floorf((cellItem.cellHeight - 20) / 2), kSNCollectionViewLoadingMoreCellDefaultSpinnerWidth, kSNCollectionViewLoadingMoreCellDefaultSpinnerWidth);
    
    if (cellItem.showSpinner) {
        [self.spinner startAnimating];
    } else {
        [self.spinner stopAnimating];
    }
    
}

@end
