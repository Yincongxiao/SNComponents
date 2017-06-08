//
//  SNDragDownRefreshHeader.m
//  QDaily
//
//  Created by AsnailNeo on 5/17/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNDragDownRefreshHeader.h"
#import "SNRefreshHeader+Private.h"
#import "UIView+SNAdditions.h"
#import "UIScrollView+SNHeaderView.h"

@implementation SNDragDownRefreshHeader

@synthesize state = _state;

- (void)layoutSubviews {
    [super layoutSubviews];
    self.top = - self.height;
}

- (void)adjustStateWithContentOffset {
    if (self.state != SNRefreshHeaderStateRefreshing) {
        self.scrollViewOriginalInset = self.scrollView.contentInset;
    }
    
    if (self.state == SNRefreshHeaderStateRefreshing ) {
        if(self.scrollView.contentOffset.y >= -self.scrollViewOriginalInset.top ) {
            self.scrollView.sn_insetTop = self.scrollViewOriginalInset.top;
        } else {
            self.scrollView.sn_insetTop = MIN(self.scrollViewOriginalInset.top + self.height,
                                              self.scrollViewOriginalInset.top - self.scrollView.contentOffset.y);
        }
        return;
    }
    
    CGFloat offsetY = self.scrollView.sn_offsetY;
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    if (offsetY >= happenOffsetY) return;
    
    CGFloat normalToPullingOffsetY = happenOffsetY - self.height;
    if (self.scrollView.isDragging) {
        self.pullingPercent = (happenOffsetY - offsetY) / self.height;
        
        if (self.state == SNRefreshHeaderStateIdle && offsetY < normalToPullingOffsetY) {
            self.state = SNRefreshHeaderStatePulling;
        } else if (self.state == SNRefreshHeaderStatePulling && offsetY >= normalToPullingOffsetY) {
            self.state = SNRefreshHeaderStateIdle;
        }
    } else if (self.state == SNRefreshHeaderStatePulling) {
        self.pullingPercent = 1.0;
        self.state = SNRefreshHeaderStateRefreshing;
    } else {
        self.pullingPercent = (happenOffsetY - offsetY) / self.height;
    }
}

- (void)setState:(SNRefreshHeaderState)state
{
    if (_state == state) return;
    
    SNRefreshHeaderState previousState = _state;
    
    _state = state;
    
    switch (state) {
        case SNRefreshHeaderStateIdle: {
            if (previousState == SNRefreshHeaderStateRefreshing) {
                [UIView animateWithDuration:0.4
                                      delay:0.0
                                    options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                                 animations:^{
                                     self.scrollView.sn_insetTop -= self.height;
                                 }
                                 completion:nil];
            }
            break;
        }
            
        case SNRefreshHeaderStateRefreshing: {
            [UIView animateWithDuration:0.25
                                  delay:0.0
                                options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 
                                 CGFloat top = self.scrollViewOriginalInset.top + self.height;
                                 self.scrollView.sn_insetTop = top;
                                 self.scrollView.sn_offsetY = - top;
                                 
                             }
                             completion:^(BOOL finished) {
                                 if (self.refreshingBlock) {
                                     self.refreshingBlock();
                                 }
                             }];
            break;
        }
            
        default:
            break;
    }
}
@end
