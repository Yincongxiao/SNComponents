//
//  UIButton+SNAdditions.h
//  QDaily
//
//  Created by AsnailNeo on 4/6/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SNAdditions)

@property(nonatomic, assign) UIEdgeInsets sn_hitTestEdgeInsets;

@end

@interface UIButton (SNImageTitleCentering)

- (void)sn_centerImageAndTitleWithSpacing:(CGFloat)spacing;
- (void)sn_swapImageAndText;

@end
