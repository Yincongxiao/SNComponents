//
//  UIDevice+SNAdditions.m
//  QDaily
//
//  Created by AsnailNeo on 3/30/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIDevice+SNAdditions.h"
#import "SNFrameworkGlobal.h"
#import <sys/utsname.h>
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <sys/mount.h>

@implementation UIDevice (SNDeviceModels)

+ (NSString *)sn_machineName {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (SNDeviceType)sn_deviceType {
    NSNumber *deviceType = [[[self class] sn_deviceTypeLooktupTable] objectForKey:[[self class] sn_machineName]];
    return [deviceType unsignedIntegerValue];
}

+ (NSDictionary *)sn_deviceTypeLooktupTable {
    return @{
             @"i386" : @(SNDeviceTypeSimulator),
             @"x86_64" : @(SNDeviceTypeSimulator),
             @"iPhone1,1" : @(SNDeviceTypeiPhone1G),
             @"iPhone1,2" : @(SNDeviceTypeiPhone3G),
             @"iPhone2" : @(SNDeviceTypeiPhone3GS),
             @"iPhone3" : @(SNDeviceTypeiPhone4),
             @"iPhone4" : @(SNDeviceTypeiPhone4S),
             @"iPhone5" : @(SNDeviceTypeiPhone5),
             @"iPhone5,2": @(SNDeviceTypeiPhone5),
             @"iPhone5,3": @(SNDeviceTypeiPhone5C),
             @"iPhone5,4": @(SNDeviceTypeiPhone5C),
             @"iPhone6,1": @(SNDeviceTypeiPhone5S),
             @"iPhone6,2": @(SNDeviceTypeiPhone5S),
             @"iPhone7,1": @(SNDeviceTypeiPhone6Plus),
             @"iPhone7,2": @(SNDeviceTypeiPhone6),
             @"iPhone8,1": @(SNDeviceTypeiPhone6S),
             @"iPhone8,2": @(SNDeviceTypeiPhone6SPlus),
             @"iPad1,1": @(SNDeviceTypeiPad1),
             @"iPad2,1" : @(SNDeviceTypeiPad2),
             @"iPad2,2" : @(SNDeviceTypeiPad2),
             @"iPad2,3" : @(SNDeviceTypeiPad2),
             @"iPad2,4" : @(SNDeviceTypeiPad2),
             @"iPad2,5": @(SNDeviceTypeiPadMini),
             @"iPad2,6": @(SNDeviceTypeiPadMini),
             @"iPad2,7": @(SNDeviceTypeiPadMini),
             @"iPad3,1": @(SNDeviceTypeiPad3),
             @"iPad3,2": @(SNDeviceTypeiPad3),
             @"iPad3,3": @(SNDeviceTypeiPad3),
             @"iPad3,4": @(SNDeviceTypeiPad4),
             @"iPad3,5": @(SNDeviceTypeiPad4),
             @"iPad3,6": @(SNDeviceTypeiPad4),
             @"iPad4,1": @(SNDeviceTypeiPadAir),
             @"iPad4,2": @(SNDeviceTypeiPadAir),
             @"iPad4,3": @(SNDeviceTypeiPadAir),
             @"iPad4,4": @(SNDeviceTypeiPadMini2),
             @"iPad4,5": @(SNDeviceTypeiPadMini2),
             @"iPad4,6": @(SNDeviceTypeiPadMini2),
             @"iPad4,7": @(SNDeviceTypeiPadMini3),
             @"iPad4,8": @(SNDeviceTypeiPadMini3),
             @"iPad5" : @(SNDeviceTypeiPadAir2),
             };
}

@end

@implementation UIDevice (SNJailBreak)

+ (BOOL)sn_isJailBroken {
    
    BOOL jailbroken = NO;
    
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }
    
    return jailbroken;
}

@end

@implementation UIDevice (SNScreen)

+ (NSUInteger)sn_devicePixelPerInch {
    SNDeviceType deviceType = [[self class] sn_deviceType];

    NSUInteger devicePixelPerInch = 326;
    
    switch (deviceType) {
        case SNDeviceTypeiPhone1G:
        case SNDeviceTypeiPhone3G:
        case SNDeviceTypeiPhone3GS:
        case SNDeviceTypeiPodTouch1G:
        case SNDeviceTypeiPodTouch2G:
        case SNDeviceTypeiPodTouch3G:
        case SNDeviceTypeiPadMini:
            devicePixelPerInch = 163;
            break;
        case SNDeviceTypeiPhone4:
        case SNDeviceTypeiPhone4S:
        case SNDeviceTypeiPhone5:
        case SNDeviceTypeiPhone5C:
        case SNDeviceTypeiPhone5S:
        case SNDeviceTypeiPhone6:
        case SNDeviceTypeiPodTouch4G:
        case SNDeviceTypeiPodTouch5G:
        case SNDeviceTypeiPadMini2:
        case SNDeviceTypeiPadMini3:
            devicePixelPerInch = 326;
            break;
        case SNDeviceTypeiPhone6Plus:
            devicePixelPerInch = 401;
            break;
        case SNDeviceTypeiPad1:
        case SNDeviceTypeiPad2:
            devicePixelPerInch = 132;
            break;
        case SNDeviceTypeiPad3:
        case SNDeviceTypeiPad4:
        case SNDeviceTypeiPadAir:
        case SNDeviceTypeiPadAir2:
            devicePixelPerInch = 264;
            break;
        case SNDeviceTypeSimulator:
            LogI(@"[%@] WARNING: you are running on the simulator; it's impossible for us to calculate centimeter/millimeter/inches units correctly", [self class]);
            devicePixelPerInch = 132;
            break;
        default:
        {
            NSString *deviceModelName = [[self class] sn_machineName];
            if ([deviceModelName hasPrefix:@"iPhone"]) {
                LogI(@"[%@] ERROR: Not supported yet: you are using an iPhone that didn't exist when this code was written, we have no idea what the pixel count per inch is!", [self class]);
                devicePixelPerInch = 401;
            } else if ([deviceModelName hasPrefix:@"iPad"]) {
                LogI(@"[%@] ERROR: Not supported yet: you are using an iPad that didn't exist when this code was written, we have no idea what the pixel count per inch is!", [self class]);
                devicePixelPerInch = 264;
            } else if ([deviceModelName hasPrefix:@"iPod"]) {
                LogI(@"[%@] ERROR: Not supported yet: you are using an iPod that didn't exist when this code was written, we have no idea what the pixel count per inch is!", [self class]);
                devicePixelPerInch = 326;
            } else {
                LogI(@"[%@] ERROR: Not supported yet: you are using an unknown device that didn't exist when this code was written, we have no idea what the pixel count per inch is!", [self class]);
                devicePixelPerInch = 264;
            }
        }
            break;
    }
    
    return devicePixelPerInch;
}

@end

@implementation UIDevice (SNMemory)

/**
 *  Memory
 */
+ (long long)sn_deviceAvailableMemory {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

+ (long long)sn_deviceUsedMemory {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

/**
 *  Disk
 */
+ (long long)sn_deviceTotleDeviceDiskSize {
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
}

+ (long long)sn_deviceAvailableDeviceDiskSize {
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}

+ (NSString *)fileSizeToString:(unsigned long long)fileSize {
    NSInteger KB = 1024;
    NSInteger MB = KB*KB;
    NSInteger GB = MB*KB;
    if (fileSize < 10) {
        return @"0 B";
    }else if (fileSize < KB) {
        return @"< 1 KB";
    }else if (fileSize < MB) {
        return [NSString stringWithFormat:@"%.1f KB",((CGFloat)fileSize)/KB];
    }else if (fileSize < GB) {
        return [NSString stringWithFormat:@"%.1f MB",((CGFloat)fileSize)/MB];
    }else {
        return [NSString stringWithFormat:@"%.1f GB",((CGFloat)fileSize)/GB];
    }
}

@end

