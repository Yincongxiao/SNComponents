//
//  UIScreen+SNAdditions.h
//  QDaily
//
//  Created by AsnailNeo on 3/31/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SNScreenSizeType){
    SNScreenSizeTypeUnknow,
    SNScreenSizeTypeRegular, // Screen size of all models previous to iPhone 6 (i.e iPhone4/4S/5/5S/5C)
                             // which have a 320 pt width
    SNScreenSizeTypeiPhone6, // 375 to 414 pt width
    SNScreenSizeTypeiPhone6PlusOrLarger, // 414 pt width or more
};

@interface UIScreen (SNAdditions)

+ (SNScreenSizeType)sn_screenSizeType;
+ (CGFloat)sn_screenScale;
+ (CGFloat)sn_screenWidth;
+ (CGFloat)sn_screenHeight;
+ (UIView *)sn_screenSnapshot;

@end
