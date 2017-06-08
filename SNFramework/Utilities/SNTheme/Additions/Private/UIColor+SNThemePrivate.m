//
//  UIColor+SNThemePrivate.m
//  QDaily
//
//  Created by AsnailNeo on 4/5/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIColor+SNThemePrivate.h"
#import "SNThemeManager+Private.h"
#import "UIColor+SNAdditions.h"
#import "SNFrameworkGlobal.h"

@implementation UIColor (SNThemePrivate)

+ (instancetype)sn_colorWithColorDict:(NSDictionary *)colorDict {

    if (!colorDict) return [UIColor clearColor]; // By default return a clearColor.
    
    NSString *selectorName = colorDict[SNThemeKeywordAttributeSelector];
    
    if (selectorName.length) return [SNThemeManager objectByPerformSelectorWithName:selectorName withClass:[UIColor class]];
    
    NSUInteger r = [colorDict[SNThemeKeywordAttributeColorRed] integerValue];
    NSUInteger g = [colorDict[SNThemeKeywordAttributeColorGreen] integerValue];
    NSUInteger b = [colorDict[SNThemeKeywordAttributeColorBlue] integerValue];
    CGFloat a = [colorDict[SNThemeKeywordAttributeColorAlpha] integerValue];
    
    return sn_RGBACOLOR(r, g, b, a);
}

@end
