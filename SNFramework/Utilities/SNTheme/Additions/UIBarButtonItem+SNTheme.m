//
//  UIBarButtonItem+SNTheme.m
//  QDaily
//
//  Created by AsnailNeo on 5/2/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIBarButtonItem+SNTheme.h"
#import "UIButton+SNTheme.h"

@interface SNNavigationBackgroundView : UIView

@end

@implementation SNNavigationBackgroundView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    /* Prevent other buttons do not respond. */
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    } else {
        return hitView;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}

/**
 *  Leak检查使用 , 其本身会同时被navigationcontroller和当前viewcontroller引用。
 *
 *  @return NO
 */
- (BOOL) willDealloc {
    return NO;
}

@end

@implementation UIBarButtonItem (SNTheme)

+ (UIBarButtonItem *)sn_barbuttonItemWithTheme:(NSString *)theme target:(id)target action:(SEL)selector {
    return [UIBarButtonItem sn_barbuttonItemWithTheme:theme target:target action:selector alignmentLeft:NO];
}

+ (UIBarButtonItem *)sn_barbuttonItemWithTheme:(NSString *)theme target:(id)target action:(SEL)selector alignmentLeft:(BOOL)left {
    return [UIBarButtonItem sn_barbuttonItemWithTheme:theme title:nil target:target action:selector alignmentLeft:left];
}

+ (UIBarButtonItem *)sn_barbuttonItemWithTheme:(NSString *)theme title:(NSString *)title target:(id)target action:(SEL)selector alignmentLeft:(BOOL)left {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 32)];
    [button sn_applyTheme:theme];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if (title.length) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateDisabled];
        [button setTitle:title forState:UIControlStateHighlighted];
    }
    
    SNNavigationBackgroundView *backgroundView = [[SNNavigationBackgroundView alloc] initWithFrame:button.frame];
    backgroundView.bounds = CGRectOffset(backgroundView.bounds, left ? 0 : 0 , 0);
    [backgroundView addSubview:button];
        
    return [[UIBarButtonItem alloc] initWithCustomView:backgroundView];
}

+ (UIBarButtonItem *)sn_modalBarbuttonItemWithTheme:(NSString *)theme title:(NSString *)title target:(id)target action:(SEL)selector alignmentLeft:(BOOL)left {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 32)];
    [button sn_applyTheme:theme];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if (title.length) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateDisabled];
        [button setTitle:title forState:UIControlStateHighlighted];
    }
    
    SNNavigationBackgroundView *backgroundView = [[SNNavigationBackgroundView alloc] initWithFrame:button.frame];
    backgroundView.bounds = CGRectOffset(backgroundView.bounds, left ? -10 : 10 , 2);
    [backgroundView addSubview:button];
    
    return [[UIBarButtonItem alloc] initWithCustomView:backgroundView];
}

@end
