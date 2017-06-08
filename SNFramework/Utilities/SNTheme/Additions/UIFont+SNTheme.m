//
//  UIFont+SNTheme.m
//  QDaily
//
//  Created by AsnailNeo on 4/7/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIFont+SNTheme.h"
#import "SNTheme+Private.h"
#import "UIFont+SNThemePrivate.h"

@implementation UIFont (SNTheme)

+ (UIFont *)sn_fontWithTheme:(NSString *)themePath {
    
    NSDictionary *themeDict = [[SNThemeManager defaultManager] themeDictionaryWithThemePath:themePath];

    NSDictionary *adaptiveFontDict = [themeDict sn_themeObjectForKey:SNThemeKeywordPathTextFont];

    return [UIFont sn_fontWithDict:adaptiveFontDict];
}

@end
