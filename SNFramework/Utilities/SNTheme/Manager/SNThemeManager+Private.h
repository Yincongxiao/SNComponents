//
//  SNTheme+Private.h
//  QDaily
//
//  Created by AsnailNeo on 4/3/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNThemeManager.h"

@interface SNThemeManager ()

- (NSDictionary *)themeDictionaryWithThemePath:(NSString *)themePath;

+ (id)objectByPerformSelectorWithName:(NSString *)selectorName
                            withClass:(Class)class;

@end

// Parent theme
extern NSString * const SNThemeKeywordAttributeSuper;

// Selector
extern NSString * const SNThemeKeywordAttributeSelector;

// UIEdgeInset
extern NSString * const SNThemeKeywordAttributeTop;
extern NSString * const SNThemeKeywordAttributeLeft;
extern NSString * const SNThemeKeywordAttributeBottom;
extern NSString * const SNThemeKeywordAttributeRight;

// UIColor
extern NSString * const SNThemeKeywordAttributeColorRed;
extern NSString * const SNThemeKeywordAttributeColorGreen;
extern NSString * const SNThemeKeywordAttributeColorBlue;
extern NSString * const SNThemeKeywordAttributeColorAlpha;
extern NSString * const SNThemeKeywordPathBackgroundColor;
extern NSString * const SNThemeKeywrodPathTextColorNormal;
extern NSString * const SNThemeKeywordPathTextColorShadow;
extern NSString * const SNThemeKeywordPathTextColorSelected;
extern NSString * const SNThemeKeywordPathTextColorHighlighted;
extern NSString * const SNThemeKeywordPathTextColorDisabled;
extern NSString * const SNThemeKeywordPathTextColorDisabledShadow;

// UIFont
extern NSString * const SNThemeKeywordAttributeFontBold;
extern NSString * const SNThemeKeywordAttributeSize;
extern NSString * const SNThemeKeywordPathTextFont;

// UIButton
extern NSString * const SNThemeKeywordPathButton;
extern NSString * const SNThemeKeywordPathTitleEdgeInsets;
extern NSString * const SNThemeKeywordPathImageEdgeInsets;
extern NSString * const SNThemeKeywordAttributeUseImage;

// Frame
extern NSString * const SNThemeKeywordAttributeWidth;
extern NSString * const SNThemeKeywordAttributeHeight;
extern NSString * const SNThemeKeywordPathTextShadowOffset;

// Image
extern NSString * const SNThemeKeywordAttributeImageName;
extern NSString * const SNThemeKeywordAttributeLeftCapWidth;
extern NSString * const SNThemeKeywordAttributeTopCapWidth;
extern NSString * const SNThemeKeywordPathCapEdgeInsets;
extern NSString * const SNThemeKeywordPathImageNormal;
extern NSString * const SNThemeKeywordPathImageDisabled;
extern NSString * const SNThemeKeywordPathImageHighlighted;
extern NSString * const SNThemeKeywordPathImageSelected;
extern NSString * const SNThemeKeywordPathIconNormal;
extern NSString * const SNThemeKeywordPathIconHighlighted;

// Text
extern NSString * const SNThemeKeywordAttributeTextLineNumber;
extern NSString * const SNThemeKeywordAttributeTextLineBreakMode;
extern NSString * const SNThemeKeywordAttributeTextAlignment;

// View
extern NSString * const SNThemeKeywordAttributeContentModel;
extern NSString * const SNThemeKeywordAttributeSizeToFit;
