//
//  SNTableLoadingMoreCell.m
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTableLoadingMoreCell.h"
#import "SNTableLoadingMoreCellItem.h"

static const NSUInteger kSNCollectionViewLoadingMoreCellDefaultSpinnerWidth = 20;

@implementation SNTableLoadingMoreCell

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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellItem:(SNTableCellItem *)cellItem {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier cellItem:cellItem];
    
    if (!self) {
        return nil;
    }
    
    [self addSubview:self.spinner];
    
    return self;
}

- (void)prepareForSettingCellItem:(SNTableLoadingMoreCellItem *)cellItem {
    
    self.spinner.frame = CGRectMake(floorf((cellItem.cellWidth - kSNCollectionViewLoadingMoreCellDefaultSpinnerWidth) / 2), floorf((cellItem.cellHeight - kSNCollectionViewLoadingMoreCellDefaultSpinnerWidth) / 2), kSNCollectionViewLoadingMoreCellDefaultSpinnerWidth, kSNCollectionViewLoadingMoreCellDefaultSpinnerWidth);
    
    if (cellItem.showSpinner) {
        [self.spinner startAnimating];
    } else {
        [self.spinner stopAnimating];
    }
}

@end
