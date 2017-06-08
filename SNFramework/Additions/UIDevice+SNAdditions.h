//
//  UIDevice+SNAdditions.h
//  QDaily
//
//  Created by AsnailNeo on 3/30/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SNDEVEICE_TYPE_ENUM_TABLE \
SN_X(SNDeviceTypeUnknown, "") \
SN_X(SNDeviceTypeSimulator, "Simulator") \
SN_X(SNDeviceTypeiPhone1G, "iPhone 1") \
SN_X(SNDeviceTypeiPhone3G, "iPhone 3G") \
SN_X(SNDeviceTypeiPhone3GS, "iPhone 3GS") \
SN_X(SNDeviceTypeiPhone4, "iPhone 4") \
SN_X(SNDeviceTypeiPhone4S, "iPhone 4S") \
SN_X(SNDeviceTypeiPhone5, "iPhone 5") \
SN_X(SNDeviceTypeiPhone5C, "iPhone 5C") \
SN_X(SNDeviceTypeiPhone5S, "iPhone 5S") \
SN_X(SNDeviceTypeiPhone6, "iPhone 6") \
SN_X(SNDeviceTypeiPhone6Plus, "iPhone 6 Plus") \
SN_X(SNDeviceTypeiPhone6S, "iPhone 6S") \
SN_X(SNDeviceTypeiPhone6SPlus, "iPhone 6S Plus") \
SN_X(SNDeviceTypeiPodTouch1G, "iPod Touch 1") \
SN_X(SNDeviceTypeiPodTouch2G, "iPod Touch 2") \
SN_X(SNDeviceTypeiPodTouch3G, "iPod Touch 3") \
SN_X(SNDeviceTypeiPodTouch4G, "iPod Touch 4") \
SN_X(SNDeviceTypeiPodTouch5G, "iPod Touch 5") \
SN_X(SNDeviceTypeiPad1, "iPad 1") \
SN_X(SNDeviceTypeiPad2, "iPad 2") \
SN_X(SNDeviceTypeiPad3, "iPad 3") \
SN_X(SNDeviceTypeiPad4, "iPad 4") \
SN_X(SNDeviceTypeiPadAir, "iPad Air") \
SN_X(SNDeviceTypeiPadAir2, "iPad Air 2") \
SN_X(SNDeviceTypeiPadMini, "iPad Mini") \
SN_X(SNDeviceTypeiPadMini2, "iPad Mini 2") \
SN_X(SNDeviceTypeiPadMini3, "iPad Mini 3") \

/**
*   use e.g if (SYSTEM_VERSION_EQUAL_TO(@"9.2.1")) { code... }
*/
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SN_X(a, b) a,
typedef NS_ENUM(NSUInteger, SNDeviceType) {
    SNDEVEICE_TYPE_ENUM_TABLE
};
#undef SN_X

#define SN_X(a, b) @b,
static NSString * const sn_deviceTypeEnumString[] = {
    SNDEVEICE_TYPE_ENUM_TABLE
};
#undef SN_X

@interface UIDevice (SNDeviceModels)

+ (NSString *)sn_machineName;

+ (SNDeviceType)sn_deviceType;

+ (NSDictionary *)sn_deviceTypeLooktupTable;

@end

@interface UIDevice (SNJailBreak)

+ (BOOL)sn_isJailBroken;

@end

@interface UIDevice (SNScreen)

+ (NSUInteger)sn_devicePixelPerInch;

@end

//unit: MB
@interface UIDevice (SNMemory)

+ (long long)sn_deviceAvailableMemory;
+ (long long)sn_deviceUsedMemory;

+ (long long)sn_deviceTotleDeviceDiskSize;
+ (long long)sn_deviceAvailableDeviceDiskSize;
+ (NSString *)fileSizeToString:(unsigned long long)fileSize;

@end
