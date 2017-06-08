//
//  CGAdditions.m
//  QDaily
//
//  Created by AsnailNeo on 4/5/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNThemeHelper.h"
#import "SNTheme+Private.h"

@implementation SNThemeHelper

+ (CGSize)sn_sizeWithDict:(NSDictionary *)sizeDict {
    if (!sizeDict) return CGSizeZero;
    
    NSInteger width = [sizeDict[SNThemeKeywordAttributeWidth] integerValue];
    NSInteger height = [sizeDict[SNThemeKeywordAttributeHeight] integerValue];
    
    return CGSizeMake(width, height);
}

+ (UIEdgeInsets)sn_edgeInsetsWithDict:(NSDictionary *)edgeDict {
    
    if (!edgeDict) {
        return UIEdgeInsetsZero;
    }
    
    NSUInteger top = [edgeDict[SNThemeKeywordAttributeTop] integerValue];
    NSUInteger left = [edgeDict[SNThemeKeywordAttributeLeft] integerValue];
    NSUInteger bottom = [edgeDict[SNThemeKeywordAttributeBottom] integerValue];
    NSUInteger right = [edgeDict[SNThemeKeywordAttributeRight] integerValue];
    
    return UIEdgeInsetsMake(top, left, bottom, right);
}

+ (NSUInteger)sn_lineNumberWithDict:(NSDictionary *)dict {
    
    if (!dict) return 0;
    
    NSNumber *adaptiveValue = nil;
    adaptiveValue = [dict sn_themeObjectForKey:SNThemeKeywordAttributeTextLineNumber];
    if (!adaptiveValue) adaptiveValue = @0;
    
    return [adaptiveValue integerValue];
}

@end
