//
//  UIView+SNTheme.h
//  QDaily
//
//  Created by AsnailNeo on 4/5/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SNTheme)

@property (nonatomic, copy, readonly) NSString *sn_themePath;

- (void)sn_applyTheme:(NSString *)themePath;

@end
