//
//  UIColor+SNTheme.m
//  QDaily
//
//  Created by 都基鹏 on 15/7/7.
//  Copyright (c) 2016年 Personal. All rights reserved.
//

#import "UIColor+SNTheme.h"
#import "SNThemeManager.h"
#import "SNTheme+Private.h"
#import "UIColor+SNAdditions.h"
@implementation UIColor (SNTheme)
+ (instancetype)sn_textColorNormalWithTheme:(NSString *)theme{
    NSDictionary *themeDict = [[SNThemeManager defaultManager] themeDictionaryWithThemePath:theme];
    
    NSDictionary *adaptiveFontDict = [themeDict sn_themeObjectForKey:SNThemeKeywrodPathTextColorNormal];
    return [UIColor sn_colorWithColorDict:adaptiveFontDict];
}
@end
