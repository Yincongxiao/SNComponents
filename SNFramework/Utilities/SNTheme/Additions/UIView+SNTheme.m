//
//  UIView+SNTheme.m
//  QDaily
//
//  Created by AsnailNeo on 4/5/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIView+SNTheme.h"
#import <objc/runtime.h>
#import "SNTheme+Private.h"
#import "UIDevice+SNAdditions.h"
#import "UIScreen+SNAdditions.h"
#import <UIKit/UIKit.h>

@interface UIView ()

@property (nonatomic, copy) NSString *sn_themePath;

@end

@implementation UIView (SNTheme)

- (void)setLf_themePath:(NSString *)sn_theme {
    objc_setAssociatedObject(self, @selector(sn_themePath), sn_theme, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)sn_themePath {
    return (NSString *)objc_getAssociatedObject(self, @selector(sn_themePath));
}

- (void)sn_applyTheme:(NSString *)themePath {
    
//    if ([themePath isEqualToString:self.sn_themePath]) return;
    
    self.sn_themePath = themePath;
    
    NSDictionary *themeDict = [[SNThemeManager defaultManager] themeDictionaryWithThemePath:themePath];
    if ([themeDict sn_themeObjectForKey:SNThemeKeywordPathImageNormal]) {
        UIImage *backgroundImage = [UIImage sn_imageWithDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathImageNormal]];
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen sn_screenScale]);
        [backgroundImage drawInRect:self.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    if ([themeDict sn_themeObjectForKey:SNThemeKeywordPathBackgroundColor]) {
        self.backgroundColor = [UIColor sn_colorWithColorDict:[themeDict sn_themeObjectForKey:SNThemeKeywordPathBackgroundColor]];
    }
}

@end
