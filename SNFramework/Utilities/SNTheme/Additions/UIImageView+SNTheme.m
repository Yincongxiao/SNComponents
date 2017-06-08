//
//  UIImageView+SNTheme.m
//  QDaily
//
//  Created by AsnailNeo on 4/7/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIImageView+SNTheme.h"
#import "SNTheme+Private.h"

@interface UIImageView ()

@property (nonatomic, copy) NSString * sn_themePath;

@end

@implementation UIImageView (SNTheme)

- (void)sn_applyTheme:(NSString *)themePath {

    if ([self.sn_themePath isEqualToString:themePath]) return;
    
    self.sn_themePath = themePath;
    
    NSDictionary *themeDict = [[SNThemeManager defaultManager] themeDictionaryWithThemePath:themePath];
    
    //  Set BackgroundColor
    self.backgroundColor = [UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathBackgroundColor]];
    
    //  Set Image
    self.image = [UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathImageNormal]];
    
    //  Set Highlighted Image
    self.highlightedImage = [UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathImageHighlighted]];
    
    //  Set ContentMode
    self.contentMode = [[themeDict sn_themeObjectForKey:SNThemeKeywordAttributeContentModel] sn_viewContentMode];
    
    if ([[themeDict sn_themeObjectForKey:SNThemeKeywordAttributeSizeToFit] boolValue]) {
        [self sizeToFit];
    }
}

@end
