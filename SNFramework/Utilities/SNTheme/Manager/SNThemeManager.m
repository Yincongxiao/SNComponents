//
//  SNTheme.m
//  QDaily
//
//  Created by AsnailNeo on 4/3/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNThemeManager.h"
#import "SNThemeManager+Private.h"
#import "SNFrameworkGlobal.h"

NSString * const SNThemeKeywordAttributeSuper = @"Super";
NSString * const SNThemeKeywordAttributeSelector = @"Selector";

// UIEdgeInset
NSString * const SNThemeKeywordAttributeTop = @"Top";
NSString * const SNThemeKeywordAttributeLeft = @"Left";
NSString * const SNThemeKeywordAttributeBottom = @"Bottom";
NSString * const SNThemeKeywordAttributeRight = @"Right";

// UIColor
NSString * const SNThemeKeywordAttributeColorRed = @"R";
NSString * const SNThemeKeywordAttributeColorGreen = @"G";
NSString * const SNThemeKeywordAttributeColorBlue = @"B";
NSString * const SNThemeKeywordAttributeColorAlpha = @"A";
NSString * const SNThemeKeywordPathBackgroundColor = @"BackgroundColor";
NSString * const SNThemeKeywrodPathTextColorNormal = @"NormalTextColor";
NSString * const SNThemeKeywordPathTextColorShadow = @"TextShadowColor";
NSString * const SNThemeKeywordPathTextColorSelected = @"SelectedTextColor";
NSString * const SNThemeKeywordPathTextColorHighlighted = @"HighlightedTextColor";
NSString * const SNThemeKeywordPathTextColorDisabled = @"DisabledTextColor";
NSString * const SNThemeKeywordPathTextColorDisabledShadow = @"DisabledTextShadowColor";

// UIFont
NSString * const SNThemeKeywordAttributeFontBold = @"Bold";
NSString * const SNThemeKeywordAttributeSize = @"Size";
NSString * const SNThemeKeywordPathTextFont = @"TextFont";

// UIButton
NSString * const SNThemeKeywordPathButton = @"Button";
NSString * const SNThemeKeywordPathTitleEdgeInsets = @"TitleEdgeInsets";
NSString * const SNThemeKeywordPathImageEdgeInsets = @"ImageEdgeInsets";
NSString * const SNThemeKeywordAttributeUseImage = @"UseImage";

// Frame
NSString * const SNThemeKeywordAttributeWidth = @"Width";
NSString * const SNThemeKeywordAttributeHeight = @"Height";
NSString * const SNThemeKeywordPathTextShadowOffset = @"TextShadowOffset";

// Image
NSString * const SNThemeKeywordAttributeImageName = @"ImageName";
NSString * const SNThemeKeywordAttributeLeftCapWidth = @"LeftCapWidth";
NSString * const SNThemeKeywordAttributeTopCapWidth = @"TopCapWidth";
NSString * const SNThemeKeywordPathCapEdgeInsets = @"CapEdgeInsets";
NSString * const SNThemeKeywordPathImageNormal = @"NormalImage";
NSString * const SNThemeKeywordPathImageDisabled = @"DisabledImage";
NSString * const SNThemeKeywordPathImageHighlighted = @"HighlightedImage";
NSString * const SNThemeKeywordPathImageSelected = @"SelectedImage";
NSString * const SNThemeKeywordPathIconNormal = @"NormalIcon";
NSString * const SNThemeKeywordPathIconHighlighted = @"HighlightedIcon";

// Text
NSString * const SNThemeKeywordAttributeTextLineNumber = @"TextLineNumber";
NSString * const SNThemeKeywordAttributeTextLineBreakMode = @"LineBreakMode";
NSString * const SNThemeKeywordAttributeTextAlignment = @"TextAlignment";

// View
NSString * const SNThemeKeywordAttributeContentModel = @"ContentMode";
NSString * const SNThemeKeywordAttributeSizeToFit = @"SizeToFit";

@interface SNThemeManager ()

@property (nonatomic, copy) NSString *themeName;
@property (nonatomic, strong, readonly) NSDictionary *themeDict;
@property (nonatomic, strong, readonly) NSDictionary *nightThemeDict;
@end

@implementation SNThemeManager

@synthesize themeDict = _themeDict;
@synthesize nightThemeDict = _nightThemeDict;

static SNThemeManager *_sharedInstance = nil;

#pragma mark -
#pragma mark Getters & Setters
- (NSDictionary *)nightThemeDict{
    if (nil == _nightThemeDict) {
        _nightThemeDict = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[self.themeName stringByAppendingString:@"_night"]
                                                                                                                                          ofType:@"plist"]
                                                                                              isDirectory:NO]];
    }
    return _nightThemeDict;
}
- (NSDictionary *)themeDict {
    if (nil == _themeDict) {
        _themeDict = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.themeName
                                                                                                                        ofType:@"plist"]
                                                                            isDirectory:NO]];
    }
    return _themeDict;
}

+ (void)setDefaultManager:(SNThemeManager *)manager {
    _sharedInstance = manager;
}

+ (instancetype)defaultManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] initWithThemeName:@"Theme"];
    });
    
    return _sharedInstance;
}

- (instancetype)initWithThemeName:(NSString *)themeName {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.themeName = themeName;
    
    return self;
}

- (NSDictionary *)themeDictionaryWithThemePath:(NSString *)themePath {
    NSDictionary *dict;
    //for night node...
//    if ([QDUserSettings currentUserSettings].nightMode) {
//        dict = [self.nightThemeDict valueForKeyPath:themePath];
//    }
    if (nil == dict) {
        dict = [self.themeDict valueForKeyPath:themePath];
    }
    if (![dict isKindOfClass:[NSDictionary class]]) {
        LogE(@"Invalid SNTheme dictionary content!");
        return nil;
    }
    
    NSString *superThemePath = [dict objectForKey:SNThemeKeywordAttributeSuper];
    if (nil != superThemePath) {
        
        NSDictionary *additionDict = [self themeDictionaryWithThemePath:superThemePath];
        NSMutableDictionary *intergratedDict = [NSMutableDictionary dictionaryWithDictionary:additionDict];
        
        if (additionDict) {
            [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if (![key isEqualToString:SNThemeKeywordAttributeSuper]) {
                    [intergratedDict setValue:obj forKey:key];
                }
            }];
        }
        
        return intergratedDict;
    }
    
    return dict;
}

#pragma mark -
#pragma mark Convenience Method

+ (id)objectByPerformSelectorWithName:(NSString *)selectorName
                            withClass:(Class)class
{    
    if (selectorName.length) {
        SEL selector = NSSelectorFromString(selectorName);
        if ([class respondsToSelector:selector]) {
            SuppressPerformSelectorLeakWarning
            (
             return [class performSelector:selector]
             );
        }
    }
    
    LogE(@"Invalid SNTheme attribute value of selector!");
    return nil;
}

+ (CGFloat)adaptiveValueMappingToSNScreenSizeTypes:(NSNumber *)value1, ... {

    NSMutableArray *valueArray = [NSMutableArray array];
    [valueArray addObject:value1];

    va_list args;
    
    va_start(args, value1);

    NSNumber *eachValue;
    CGFloat adaptiveValue = [value1 floatValue];
    SNScreenSizeType screenSizeType = [UIScreen sn_screenSizeType];
    
    while ((eachValue = va_arg(args, NSNumber *))) {
        [valueArray addObject:eachValue];
    }
    va_end(args);
    
    
    switch (valueArray.count) {
        case 2:
        {
            if (SNScreenSizeTypeiPhone6PlusOrLarger == screenSizeType) {
                adaptiveValue = [[valueArray objectAtIndex:1] floatValue];
            } else if (SNScreenSizeTypeiPhone6 == screenSizeType) {
                adaptiveValue = [valueArray[0] floatValue] * 1.17;
            }
        }
            break;
        case 3:
        {
            if (SNScreenSizeTypeiPhone6 == screenSizeType) {
                adaptiveValue = [[valueArray objectAtIndex:1] floatValue];
            } else if (SNScreenSizeTypeiPhone6PlusOrLarger == screenSizeType) {
                adaptiveValue = [[valueArray objectAtIndex:2] floatValue];
            }
        }
            break;
        default:
            break;
    }
    
    return adaptiveValue;
}

@end
