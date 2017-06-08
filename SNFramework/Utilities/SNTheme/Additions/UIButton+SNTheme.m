//
//  UIButton+SNTheme.m
//  QDaily
//
//  Created by AsnailNeo on 4/6/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIButton+SNTheme.h"
#import "SNTheme+Private.h"
#import "NSDictionary+SNAdditions.h"

@interface UIButton ()

@property (nonatomic, copy) NSString *sn_themePath;

@end

@implementation UIButton (SNTheme)

- (void)sn_applyTheme:(NSString *)themePath {
    
    if ([self.sn_themePath isEqualToString:themePath]) return;
    
    self.sn_themePath = themePath;

    NSDictionary *themeDict = [[SNThemeManager defaultManager] themeDictionaryWithThemePath:themePath];

    //  Set BackgroundColor
    self.backgroundColor = [UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathBackgroundColor]];
    
    //  Set Normal Title Color
    [self setTitleColor:[UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywrodPathTextColorNormal]] forState:UIControlStateNormal];
    //  Set Title ShadowColor
    [self setTitleShadowColor:[UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathTextColorShadow]] forState:UIControlStateNormal];
    
    //  Set Selected Title Color
    [self setTitleColor:[UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathTextColorSelected]] forState:UIControlStateSelected];
    //  Set Highlighted Title Color
    [self setTitleColor:[UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathTextColorHighlighted]] forState:UIControlStateHighlighted];
    
    //  Set Disabled Title Color
    [self setTitleColor:[UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathTextColorDisabled]] forState:UIControlStateDisabled];
    //  Set Disabled Title Shadow Color
    [self setTitleShadowColor:[UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathTextColorShadow]] forState:UIControlStateDisabled];

    //  Set Title ShadowOffset
    [self.titleLabel setShadowOffset:[SNThemeHelper sn_sizeWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathTextShadowOffset]]];
    //  Set Title Textfont
    
    NSDictionary *adaptiveFontDict = [themeDict sn_themeObjectForKey:SNThemeKeywordPathTextFont];
    
    self.titleLabel.font = [UIFont sn_fontWithDict:adaptiveFontDict];
    
    //  Set Title Edge Insets if any
    UIEdgeInsets titleEdgeInsets = [SNThemeHelper sn_edgeInsetsWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathTitleEdgeInsets]];
    if (!UIEdgeInsetsEqualToEdgeInsets(titleEdgeInsets, UIEdgeInsetsZero)) {
        self.titleEdgeInsets = titleEdgeInsets;
    }
    
    if ([themeDict[SNThemeKeywordAttributeUseImage] boolValue]) {
        // Set Normal BackgroundImage
        [self setImage:[UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathImageNormal]] forState:UIControlStateNormal];
        // Set Highlighted BackgroundImage
        [self setImage:[UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathImageHighlighted]] forState:UIControlStateHighlighted];
        //  Set Disabled BackgroundImage
        [self setImage:[UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathImageDisabled]] forState:UIControlStateDisabled];
        //  Set Selected BackgroundImage
        [self setImage:[UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathImageSelected]] forState:UIControlStateSelected];
        // Set ImageEdgeInsets if any
        UIEdgeInsets imageInsets = [SNThemeHelper sn_edgeInsetsWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathImageEdgeInsets]];
        if (!UIEdgeInsetsEqualToEdgeInsets(imageInsets, UIEdgeInsetsZero)) {
            self.imageEdgeInsets = imageInsets;
        }
    } else {
        // Set Normal BackgroundImage
        [self setImage:[UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathIconNormal]] forState:UIControlStateNormal];
        // Set Highlighted BackgroundImage
        [self setImage:[UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathIconHighlighted]] forState:UIControlStateHighlighted];
        // Set Normal Background Imgae
        [self setBackgroundImage:[UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathImageNormal]] forState:UIControlStateNormal];
        // Set Highlighted Background Image
        [self setBackgroundImage:[UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathImageHighlighted]] forState:UIControlStateHighlighted];
        //  Set Disabled BackgroundImage
        [self setBackgroundImage:[UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathImageDisabled]]
                          forState:UIControlStateDisabled];
        //  Set Selected BackgroundImage
        [self setBackgroundImage:[UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathImageSelected]]
                          forState:UIControlStateSelected];
    }
    
    if ([[themeDict sn_safeObjectForKey:SNThemeKeywordAttributeSizeToFit] boolValue]) {
        [self sizeToFit];
    }
}

@end
