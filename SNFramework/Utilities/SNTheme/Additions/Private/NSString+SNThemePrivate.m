//
//  NSString+SNThemePrivate.m
//  QDaily
//
//  Created by AsnailNeo on 4/7/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "NSString+SNThemePrivate.h"
#import "SNThemeManager+Private.h"

@implementation NSString (SNThemePrivate)

- (NSTextAlignment)sn_textAlignment {
    
    NSDictionary *lookupTable =
  @{
    @"Left":@(NSTextAlignmentLeft),
    @"Right":@(NSTextAlignmentRight),
    @"Center":@(NSTextAlignmentCenter),
    };
    
    NSNumber *number = [lookupTable objectForKey:self];
    
    if (number) return [number integerValue];

    return NSTextAlignmentLeft;
}

- (UIViewContentMode)sn_viewContentMode {
    
    NSDictionary *lookupTable =
    @{
      @"ScaleToFill":@(UIViewContentModeScaleToFill),
      @"ScaleAspectFit":@(UIViewContentModeScaleAspectFit),
      @"ScaleAspectFill":@(UIViewContentModeScaleAspectFill),
      @"Redraw":@(UIViewContentModeRedraw),
      @"Center":@(UIViewContentModeCenter),
      @"Top":@(UIViewContentModeTop),
      @"Bottom":@(UIViewContentModeBottom),
      @"Left":@(UIViewContentModeLeft),
      @"Right":@(UIViewContentModeRight),
      @"TopLeft":@(UIViewContentModeTopLeft),
      @"TopRight":@(UIViewContentModeTopRight),
      @"BottomLeft":@(UIViewContentModeBottomLeft),
      @"BottomRight":@(UIRectCornerBottomRight),
      };
    
    NSNumber *number = [lookupTable objectForKey:self];
    
    if (number) return [number integerValue];
    
    return UIViewContentModeScaleToFill;
}

@end
