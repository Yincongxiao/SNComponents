//
//  UIColor+SNAdditions.m
//  QDaily
//
//  Created by AsnailNeo on 4/14/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIColor+SNAdditions.h"

@implementation UIColor (SNAdditions)

+ (UIColor *)sn_randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

@end
