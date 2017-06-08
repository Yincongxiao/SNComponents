//
//  UIBarButtonItem+SNTheme.h
//  QDaily
//
//  Created by AsnailNeo on 5/2/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SNTheme)

+ (UIBarButtonItem *)sn_barbuttonItemWithTheme:(NSString *)theme target:(id)target action:(SEL)selector;
+ (UIBarButtonItem *)sn_barbuttonItemWithTheme:(NSString *)theme target:(id)target action:(SEL)selector alignmentLeft:(BOOL)left;
+ (UIBarButtonItem *)sn_barbuttonItemWithTheme:(NSString *)theme title:(NSString *)title target:(id)target action:(SEL)selector alignmentLeft:(BOOL)left;
+ (UIBarButtonItem *)sn_modalBarbuttonItemWithTheme:(NSString *)theme title:(NSString *)title target:(id)target action:(SEL)selector alignmentLeft:(BOOL)left;

@end
