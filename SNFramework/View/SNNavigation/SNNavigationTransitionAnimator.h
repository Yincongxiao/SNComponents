//
//  SNNavigationTransitionAnimator.h
//  QDaily
//
//  Created by AsnailNeo on 6/9/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNNavigationTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval transitionDuration;
@property (nonatomic, assign) UINavigationControllerOperation currentOperation;

+ (BOOL)supportOperation:(UINavigationControllerOperation)operation;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController fromView:(UIView *)fromView toView:(UIView *)toView;

@end
