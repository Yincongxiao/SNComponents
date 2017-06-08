//
//  UILabel+SNTheme.m
//  QDaily
//
//  Created by AsnailNeo on 4/7/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UILabel+SNTheme.h"
#import "SNTheme+Private.h"
#import "SNThemeHelper.h"

@interface UILabel ()

@property (nonatomic, copy) NSString *sn_themePath;

@end

@implementation UILabel (SNTheme)

- (void)sn_applyTheme:(NSString *)themePath {
    
    if ([self.sn_themePath isEqualToString:themePath]) return;
    
    self.sn_themePath = themePath;
    
    NSDictionary *themeDict = [[SNThemeManager defaultManager] themeDictionaryWithThemePath:themePath];

    //  Set BackgroundColor
    self.backgroundColor = [UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathBackgroundColor]];
    
    //  Set TextColor
    self.textColor = [UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywrodPathTextColorNormal]];
    
    //  Set TextHighlightedColor
    if ([themeDict sn_themeObjectForKey:SNThemeKeywordPathTextColorHighlighted]) {
        self.highlightedTextColor = [UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathTextColorHighlighted]];
    } else {
        self.highlightedTextColor = self.textColor;
    }

    //  Set TextShadowColor
    self.shadowColor = [UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathTextColorShadow]];
    
    //  Set TextShadowOffset
    self.shadowOffset = [SNThemeHelper sn_sizeWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathTextShadowOffset]];
    
    //  Set TextFont
    NSDictionary *adaptiveFontDict = [themeDict sn_themeObjectForKey:SNThemeKeywordPathTextFont];

    self.font = [UIFont sn_fontWithDict:adaptiveFontDict];
    
    //  Set TextAlignment
    self.textAlignment = [[themeDict sn_themeObjectForKey:SNThemeKeywordAttributeTextAlignment] sn_textAlignment];
    
    //  Set
    self.lineBreakMode = NSLineBreakByTruncatingTail;
    
    //  Set TextLineNumber
    NSNumber *adaptiveValue = [themeDict sn_themeObjectForKey:SNThemeKeywordAttributeTextLineNumber];;
    
    self.numberOfLines = [adaptiveValue integerValue];

    if ([[themeDict sn_themeObjectForKey:SNThemeKeywordAttributeSizeToFit] boolValue]) {
        [self sizeToFit];
    }
}

@end
