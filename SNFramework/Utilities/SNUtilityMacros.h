//
//  SNUtilityMacros.h
//  QDaily
//
//  Created by AsnailNeo on 4/3/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#pragma mark -
#pragma mark Clang

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#pragma mark -
#pragma mark Logs

#ifdef DEBUG
#define LogV(format, ...) NSLog((@"✍💜[V]:%d %s " format), __LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__);

#define LogD(format, ...) NSLog((@"✍💚[D]:%d %s " format), __LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__);

#define LogI(format, ...) NSLog((@"✍💙[I]:%d %s " format), __LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__);

#define LogW(format, ...)NSLog((@"✍💛[W]:%d %s " format), __LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__);

#define LogE(format, ...) NSLog((@"✍❤️[E]:%d %s " format), __LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#define LogV(format, ...)
#define LogD(format, ...)
#define LogI(format, ...)
#define LogE(format, ...)
#endif


#pragma mark -
#pragma mark SystemVersion

#define sn_APP_VERSION ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])

#define sn_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define sn_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define sn_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define sn_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define sn_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark -
#pragma mark UIColor

#define sn_RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define sn_RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define sn_ColorRGB(r,a) [UIColor colorWithRed:(r>>16&0xff)/255. green:(r>>8&0xff)/255. blue:(r&0xff)/255. alpha:a]

#define sn_randomIntegerBetween(min, max) (min + arc4random_uniform(max - min + 1))

#pragma mark -
#pragma mark Abstrct Class

#define SNMethodNotImplemented() \
        @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                        reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
                                        userInfo:nil]
