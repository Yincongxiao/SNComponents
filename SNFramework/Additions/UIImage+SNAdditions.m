//
//  UIImage+SNAdditions.m
//  QDaily
//
//  Created by AsnailNeo on 4/7/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIImage+SNAdditions.h"
#import "SNFrameworkGlobal.h"

@implementation UIImage (SNAdditions)

+ (UIImage *)sn_imageWithColor:(UIColor *)color {
    
    CGRect rect = rm(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)sn_roundCorneredImageWithSize:(CGSize)drawSize {
    
    UIGraphicsBeginImageContextWithOptions(drawSize, NO, [UIScreen sn_screenScale]);
    
    CGRect box = CGRectMake(0, 0, drawSize.width,  drawSize.height);
    
    [[UIBezierPath bezierPathWithRoundedRect:box
                                cornerRadius:drawSize.width/2] addClip];
    
    [self drawInRect:box];
    
    
    UIImage *roundCorneredImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return roundCorneredImage;
}

- (void)sn_roundCorneredImageWithSize:(CGSize)drawSize drawColor:(UIColor *)drawColor complete:(void(^)(UIImage *image))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIGraphicsBeginImageContextWithOptions(drawSize, YES, 0);
        CGRect rect = CGRectMake(0, 0, drawSize.width, drawSize.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        if (drawColor) {
            [drawColor setFill];
        }
        UIRectFill(rect);
        [path addClip];
        [self drawInRect:rect];
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(result);
            }
        });
    });

}

@end

@implementation UIImage (SNEditing)

+ (UIImage *)sn_imageFromView:(UIView *)theView atFrame:(CGRect)clipRect {
    
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(clipRect);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;
}

- (UIImage *)sn_croppedImageInRect:(CGRect)rect {
    
    rect = CGRectMake(rect.origin.x*self.scale, rect.origin.y*self.scale, rect.size.width*self.scale, rect.size.height*self.scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage* subImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    return subImage;
}

- (CGAffineTransform)sn_orientationAffineTransform {
    
    CGAffineTransform rectTransform;
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationLeft:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(sn_rad(90)), 0, - self.size.height);
            break;
        case UIImageOrientationRight:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(sn_rad(-90)), - self.size.width, 0);
            break;
        case UIImageOrientationDown:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(sn_rad(-180)), - self.size.width, - self.size.height);
            break;
        default:
            rectTransform = CGAffineTransformIdentity;
    };
    
    return CGAffineTransformScale(rectTransform, self.scale, self.scale);
    
}

- (UIImage*)sn_scaleToSize:(CGSize)size force:(BOOL)force {
    
    CGFloat tolerence = 2.0f;
    
    if (size.width >= self.size.width - tolerence && size.width <= self.size.width + tolerence &&
        size.height >= self.size.height - tolerence && size.height <= self.size.height + tolerence) {
        return self;
    }
    
    if (size.width >= self.size.width - tolerence && size.height >= self.size.height - tolerence) {
        if (!force) {
            return self;
        }
    }
    
    CGSize newSize;
    
    if (size.width/size.height > self.size.width/self.size.height) {
        newSize.height = size.height;
        newSize.width = self.size.width/self.size.height*newSize.height;
    } else {
        newSize.width = size.width;
        newSize.height = self.size.height/self.size.width*newSize.width;
    }
    
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, floorf(newSize.width) + 1, floorf(newSize.height) + 1)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
