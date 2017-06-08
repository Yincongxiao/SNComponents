//
//  UIImage+SNAdditions.h
//  QDaily
//
//  Created by AsnailNeo on 4/7/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

#define sn_rad(angle) ((angle) / 180.0 * M_PI)

@interface UIImage (SNAdditions)

+ (UIImage *)sn_imageWithColor:(UIColor *)color;
- (UIImage *)sn_roundCorneredImageWithSize:(CGSize)drawSize;

/**
 *  异步绘制圆角,性能高
 *
 *  @param drawSize  原型图片的尺寸
 *  @param drawColor 底色
 *  @param complete  完成的回调 unnull
 */
- (void)sn_roundCorneredImageWithSize:(CGSize)drawSize
                            drawColor:(UIColor *)drawColor
                             complete:(void(^)(UIImage *image))complete;

@end

@interface UIImage (SNEditing)

+ (UIImage *)sn_imageFromView:(UIView *) theView atFrame:(CGRect)r;

- (UIImage *)sn_croppedImageInRect:(CGRect)rect;

- (CGAffineTransform)sn_orientationAffineTransform;

- (UIImage*)sn_scaleToSize:(CGSize)size force:(BOOL)force;

@end
