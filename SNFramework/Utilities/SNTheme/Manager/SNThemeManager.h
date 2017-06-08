//
//  SNTheme.h
//  QDaily
//
//  Created by AsnailNeo on 4/3/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#ifndef _
#define _(s,...) ([SNThemeManager adaptiveValueMappingToSNScreenSizeTypes:s, ##__VA_ARGS__, nil])
#endif

#import <UIKit/UIKit.h>

@interface SNThemeManager : NSObject

/*!
 @method defaultManager
 @abstract Returns the default SNThemeManager instance.
 @discussion Unless set explicitly through a call to
 <tt>+setDefaultManager:</tt>, this method returns an SNThemeManager
 instance created with the default theme name of "Theme". That is to
 say, a resource file named "Theme.plist" in the application bundle
 will be loaded.
 @result the shared SNThemeManager instance.
 */
+ (instancetype)defaultManager;

/*!
 @method setDefaultManager:
 @abstract Sets the SNThemeManager instance shared by all clients of
 the current process. This will be the new object returned when
 calls to the <tt>defaultManager</tt> method are made.
 @discussion Callers should take care to ensure that this method is called
 at a time when no other caller has a reference to the previously-set default
 theme manager. 
 @param manager the new SNThemeManager instance.
 */
+ (void)setDefaultManager:(SNThemeManager *)manager;

+ (CGFloat)adaptiveValueMappingToSNScreenSizeTypes:(NSNumber *)value1, ...;

- (instancetype)initWithThemeName:(NSString *)themeName;

@end
