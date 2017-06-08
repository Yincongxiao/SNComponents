//
//  SNNavigationTransitionAnimator.m
//  QDaily
//
//  Created by AsnailNeo on 6/9/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNNavigationTransitionAnimator.h"

@implementation SNNavigationTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    
    [self animateTransition:transitionContext fromViewController:fromVC toViewController:toVC fromView:fromView toView:toView];
}

+ (BOOL)supportOperation:(UINavigationControllerOperation)operation {
    NSAssert(![self isMemberOfClass:[SNNavigationTransitionAnimator class]], @"SNNavigationTransitionAnimator is an abstract class, you should implement your own supportOperation: method.");
    return NO;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView {
    NSAssert(![self isMemberOfClass:[SNNavigationTransitionAnimator class]], @"SNNavigationTransitionAnimator is an abstract class, you should implement your own animateTransition: method.");
}

@end
