//
//  SNCollectionViewLodingCell.h
//  QDaily
//
//  Created by AsnailNeo on 3/3/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewCell.h"

@interface SNCollectionViewLoadingCell : SNCollectionViewCell

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end
