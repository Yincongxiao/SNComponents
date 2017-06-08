//
//  UIImage+SNThemePrivate.m
//  QDaily
//
//  Created by AsnailNeo on 4/5/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIImage+SNThemePrivate.h"
#import "SNTheme+Private.h"
#import "SNThemeHelper.h"

@implementation UIImage (SNThemePrivate)

+ (UIImage *)sn_imageWithDict:(NSDictionary *)imageDict {
    
    if (!imageDict) return nil;
    
    if (nil != [imageDict sn_themeObjectForKey:SNThemeKeywordPathImageNormal]) {
        imageDict = [imageDict sn_themeObjectForKey:SNThemeKeywordPathImageNormal];
    }
    
    UIImage *theImage = nil;
    
    NSString *imageName = [imageDict sn_themeObjectForKey:SNThemeKeywordAttributeImageName];
    
    if ([imageDict sn_themeObjectForKey:SNThemeKeywordAttributeLeftCapWidth]) {
        theImage = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:[[imageDict sn_themeObjectForKey:SNThemeKeywordAttributeLeftCapWidth] integerValue] topCapHeight:[[imageDict sn_themeObjectForKey:SNThemeKeywordAttributeTopCapWidth] integerValue]];
    } else if (nil != [imageDict sn_themeObjectForKey:SNThemeKeywordPathCapEdgeInsets]) {
        UIEdgeInsets edgeInsets = [SNThemeHelper sn_edgeInsetsWithDict:[imageDict sn_themeObjectForKey:SNThemeKeywordPathCapEdgeInsets]];
        theImage = [[UIImage imageNamed:imageName] resizableImageWithCapInsets:edgeInsets];
    } else {
        theImage = [UIImage imageNamed:imageName];
    }
    
    return theImage;
}

@end
