//
//  UIFont+SNThemePrivate.m
//  QDaily
//
//  Created by AsnailNeo on 4/5/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIFont+SNThemePrivate.h"
#import "SNTheme+Private.h"

@implementation UIFont (SNThemePrivate)

+ (UIFont *)sn_fontWithDict:(NSDictionary *)fontDict {
    
    
    
    if (!fontDict) return [UIFont systemFontOfSize:12.0f]; // default font size is 12.0
    
    NSString *selectorName = fontDict[SNThemeKeywordAttributeSelector];
    
    if (selectorName.length) return [SNThemeManager objectByPerformSelectorWithName:selectorName withClass:[UIFont class]];
    
    BOOL bold = [[fontDict sn_themeObjectForKey:SNThemeKeywordAttributeFontBold] boolValue];
    
    CGFloat fontSize = [[fontDict sn_themeObjectForKey:SNThemeKeywordAttributeSize] floatValue];
    
    return bold ? [UIFont boldSystemFontOfSize:fontSize] : [UIFont systemFontOfSize:fontSize];
}

@end
