//
//  UIImageView+SNAdditions.m
//  QDaily
//
//  Created by AsnailNeo on 5/25/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIImageView+SNAdditions.h"
#import "UIView+SNAdditions.h"

#define maskViewTag 12880

@implementation UIImageView (SNAdditions)

- (CGRect)sn_imagePosition {
    
    float x = 0.0f;
    float y = 0.0f;
    float w = 0.0f;
    float h = 0.0f;
    CGFloat ratio = 0.0f;
    CGFloat horizontalRatio = self.frame.size.width / self.image.size.width;
    CGFloat verticalRatio = self.frame.size.height / self.image.size.height;
    
    switch (self.contentMode) {
        case UIViewContentModeScaleToFill:
            w = self.frame.size.width;
            h = self.frame.size.height;
            break;
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            w = self.image.size.width*ratio;
            h = self.image.size.height*ratio;
            x = (horizontalRatio == ratio ? 0 : ((self.frame.size.width - w)/2));
            y = (verticalRatio == ratio ? 0 : ((self.frame.size.height - h)/2));
            break;
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            w = self.image.size.width*ratio;
            h = self.image.size.height*ratio;
            x = (horizontalRatio == ratio ? 0 : ((self.frame.size.width - w)/2));
            y = (verticalRatio == ratio ? 0 : ((self.frame.size.height - h)/2));
            break;
        case UIViewContentModeCenter:
            w = self.image.size.width;
            h = self.image.size.height;
            x = (self.frame.size.width - w)/2;
            y = (self.frame.size.height - h)/2;
            break;
        case UIViewContentModeTop:
            w = self.image.size.width;
            h = self.image.size.height;
            x = (self.frame.size.width - w)/2;
            break;
        case UIViewContentModeBottom:
            w = self.image.size.width;
            h = self.image.size.height;
            y = (self.frame.size.height - h);
            x = (self.frame.size.width - w)/2;
            break;
        case UIViewContentModeLeft:
            w = self.image.size.width;
            h = self.image.size.height;
            y = (self.frame.size.height - h)/2;
            break;
        case UIViewContentModeRight:
            w = self.image.size.width;
            h = self.image.size.height;
            y = (self.frame.size.height - h)/2;
            x = (self.frame.size.width - w);
            break;
        case UIViewContentModeTopLeft:
            w = self.image.size.width;
            h = self.image.size.height;
            break;
        case UIViewContentModeTopRight:
            w = self.image.size.width;
            h = self.image.size.height;
            x = (self.frame.size.width - w);
            break;
        case UIViewContentModeBottomLeft:
            w = self.image.size.width;
            h = self.image.size.height;
            y = (self.frame.size.height - h);
            break;
        case UIViewContentModeBottomRight:
            w = self.image.size.width;
            h = self.image.size.height;
            y = (self.frame.size.height - h);
            x = (self.frame.size.width - w);
        default:
            break;
    }
    return CGRectMake(x, y, w, h);
}

- (void) sn_addBottomMask {
    UIImageView* maskImageView = [self viewWithTag:maskViewTag];
    if (maskImageView == nil) {
        maskImageView = [self addSubviewWithClass:[UIImageView class] frame:self.bounds];
        maskImageView.contentMode = UIViewContentModeScaleAspectFill;
        maskImageView.clipsToBounds = YES;
        maskImageView.tag = maskViewTag;
        [maskImageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        maskImageView.image = [UIImage imageNamed:@"home_feed_mask_large_normal"];
    }
}

- (void) sn_removeBottomMask {
    [self removeSubViewWithTag:maskViewTag];
}
@end
