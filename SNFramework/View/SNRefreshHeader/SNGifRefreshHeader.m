//
//  SNGifRefreshHeader.m
//  QDaily
//
//  Created by AsnailNeo on 5/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNGifRefreshHeader.h"
#import "SNRefreshHeader+Private.h"
#import "SNFrameworkGlobal.h"

@interface SNGifRefreshHeader ()

@property (nonatomic, strong) NSMutableDictionary *stateImageDictionary;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SNGifRefreshHeader

#pragma mark -
#pragma mark Accessors

- (NSMutableDictionary *)stateImageDictionary {
    if (!_stateImageDictionary) {
        _stateImageDictionary = [NSMutableDictionary dictionary];
    }
    return _stateImageDictionary;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    
    NSArray *images = self.stateImageDictionary[@(self.state)];
    switch (self.state) {
        case SNRefreshHeaderStateIdle: {
            [self.imageView stopAnimating];
            NSUInteger index =  images.count * self.pullingPercent;
            if (index >= images.count) index = images.count - 1;
            self.imageView.image = images[index];
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark Initialization

- (instancetype)initWithFrame:(CGRect)frame imageSize:(CGSize)size {
    
    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }
    
    self.imageSize = size;
    
    return self;
}

#pragma mark -
#pragma mark UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    if (CGSizeEqualToSize(self.imageSize, CGSizeZero)) {
        self.imageView.frame = self.bounds;
        self.imageView.contentMode = UIViewContentModeCenter;
    } else {
        self.imageView.frame = rm((self.width - self.imageSize.width)/2, (self.height - self.imageSize.height)/2, self.imageSize.width, self.imageSize.height);
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }

}

- (void)setState:(SNRefreshHeaderState)state {
    
    if (self.state == state) return;
    
    SNRefreshHeaderState previousState = self.state;
    
    NSArray *images = self.stateImageDictionary[@(state)];
    if (images.count != 0) {
        switch (state) {
            case SNRefreshHeaderStateIdle: {
                if (previousState == SNRefreshHeaderStateRefreshing) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.pullingPercent = 0.0;
                    });
                } else {
                    self.pullingPercent = self.pullingPercent;
                }
                break;
            }
                
            case SNRefreshHeaderStatePulling:
            case SNRefreshHeaderStateRefreshing: {
                [self.imageView stopAnimating];
                if (images.count == 1) {
                    self.imageView.image = [images lastObject];
                } else {
                    self.imageView.animationImages = images;
                    self.imageView.animationDuration = images.count / 20;
                    [self.imageView startAnimating];
                }
                break;
            }
                
            default:
                break;
        }
    }
    
    [super setState:state];
}


- (void)setImages:(NSArray *)images forState:(SNRefreshHeaderState)state {
    if (images == nil) return;
    
    self.stateImageDictionary[@(state)] = images;
    
    if (!self.adjustFrameWithImage) {
        return;
    }
    
    UIImage *image = [images firstObject];
    if (image.size.height > self.height) {
        self.height = image.size.height;
    }
}

@end
