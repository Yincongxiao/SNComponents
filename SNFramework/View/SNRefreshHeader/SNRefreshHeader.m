//
//  SNGifRefreshControl.m
//  QDaily
//
//  Created by AsnailNeo on 5/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNRefreshHeader.h"
#import "SNRefreshHeader+Private.h"
#import "UIView+SNAdditions.h"

NSString *const SNRefershHeaderContentOffsetKeyPath = @"contentOffset";
NSString *const SNRefershHeaderContentSizeKeyPath = @"contentSize";
NSString *const SNRefershHeaderPanStateKeyPath = @"pan.state";

@interface SNRefreshHeader ()

- (BOOL)isRefreshing;

- (void)adjustStateWithContentOffset;

@end

@implementation SNRefreshHeader

- (instancetype) initWithNightMode:(BOOL) nightMode
{
    _nightMode = nightMode;
    self = [self initWithFrame:CGRectZero nightMode: nightMode];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame nightMode:(BOOL) nightMode{
    _nightMode = nightMode;
    self = [self initWithFrame:frame];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        self.state = SNRefreshHeaderStateIdle;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:SNRefershHeaderContentOffsetKeyPath context:nil];
    
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:SNRefershHeaderContentOffsetKeyPath options:NSKeyValueObservingOptionNew context:nil];
        
        self.width = newSuperview.width;
        self.top = 0;
        
        self.scrollView = (UIScrollView *)newSuperview;
        self.scrollView.alwaysBounceVertical = YES;
        self.scrollViewOriginalInset = self.scrollView.contentInset;
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.state == SNRefreshHeaderStateWillRefresh) {
        self.state = SNRefreshHeaderStateRefreshing;
    }
}

#pragma mark -
#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden || self.state == SNRefreshHeaderStateRefreshing) return;
    
    if ([keyPath isEqualToString:SNRefershHeaderContentOffsetKeyPath]) {
        [self adjustStateWithContentOffset];
    }
}

- (void)adjustStateWithContentOffset {
    // Template Methods
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
}

#pragma mark -
#pragma mark Logic

- (void)beginRefreshing {
    if (!self.animating) {
        self.state = SNRefreshHeaderStateRefreshing;
    }
}

- (void)endRefreshing {
    self.state = SNRefreshHeaderStateIdle;
}

- (BOOL)isRefreshing {
    return self.state == SNRefreshHeaderStateRefreshing;
}



@end
