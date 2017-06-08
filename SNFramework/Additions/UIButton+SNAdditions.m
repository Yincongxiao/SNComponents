//
//  UIButton+SNAdditions.m
//  QDaily
//
//  Created by AsnailNeo on 4/6/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIButton+SNAdditions.h"
#import <objc/runtime.h>

@implementation UIButton (SNAdditions)

@dynamic sn_hitTestEdgeInsets;

- (void)setLf_hitTestEdgeInsets:(UIEdgeInsets)sn_hitTestEdgeInsets {
    NSValue *value = [NSValue value:&sn_hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, @selector(sn_hitTestEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)sn_hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, @selector(sn_hitTestEdgeInsets));
    if(value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.sn_hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.sn_hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

@end

@implementation UIButton (SNImageTitleCentering)

- (void)sn_centerImageAndTitleWithSpacing:(CGFloat)spacing {
    CGFloat insetAmount = spacing / 2.0;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
    self.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
}

- (void)sn_swapImageAndText {
    self.transform = CGAffineTransformScale(self.transform, -1.0f, 1.0f);
    self.titleLabel.transform = CGAffineTransformScale(self.titleLabel.transform, -1.0f, 1.0f);
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, -1.0f, 1.0f);
}

@end

