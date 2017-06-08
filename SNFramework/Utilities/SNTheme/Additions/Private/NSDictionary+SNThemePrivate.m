//
//  NSDictionary+SNThemePrivate.m
//  QDaily
//
//  Created by AsnailNeo on 5/22/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "NSDictionary+SNThemePrivate.h"
#import "UIScreen+SNAdditions.h"
#import "SNFrameworkGlobal.h"

@implementation NSDictionary (SNThemePrivate)

- (id)sn_themeObjectForKey:(id)aKey {
    
    if (![aKey isKindOfClass:[NSString class]]) {
        LogE(@"Invalid SNTheme Key!");
        return nil;
    }
    
    NSString *adaptiveKeyString = [(NSString *)aKey copy];
    
    id object = [self sn_safeObjectForKey:adaptiveKeyString];
    
    if (object) {
        return object;
    }
    
    if ([UIScreen sn_screenSizeType] == SNScreenSizeTypeRegular || [UIScreen sn_screenSizeType] == SNScreenSizeTypeiPhone6) {
        adaptiveKeyString = [adaptiveKeyString stringByAppendingString:@"@2x"];
    } else if ([UIScreen sn_screenSizeType] == SNScreenSizeTypeiPhone6PlusOrLarger) {
        adaptiveKeyString = [adaptiveKeyString stringByAppendingString:@"@3x"];
    }
    
    return [self sn_safeObjectForKey:adaptiveKeyString];
}

@end
