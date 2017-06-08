//
//  UIScreen+SNAdditions.m
//  QDaily
//
//  Created by AsnailNeo on 3/31/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIScreen+SNAdditions.h"

@implementation UIScreen (SNAdditions)

+ (SNScreenSizeType)sn_screenSizeType {
    
    SNScreenSizeType screenSizeType = SNScreenSizeTypeRegular;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    if (screenWidth == 320.0f) {
        screenSizeType = SNScreenSizeTypeRegular;
    } else if (screenWidth > 320.0f && screenWidth <= 375.0f ) {
        screenSizeType = SNScreenSizeTypeiPhone6;
    } else if (screenWidth >= 414.0f) {
        screenSizeType = SNScreenSizeTypeiPhone6PlusOrLarger;
    }
    
    return screenSizeType;
}

+ (CGFloat)sn_screenScale {
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        return [[UIScreen mainScreen] scale];
    }
    return 1.0f;
}

+ (CGFloat)sn_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)sn_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (UIView *)sn_screenSnapshot {
    return [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
}

@end
