//
//  SNTableLoadingCell.h
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNTableViewCell.h"

@interface SNTableLoadingCell : SNTableViewCell

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end
