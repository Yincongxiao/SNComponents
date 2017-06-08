//
//  UIApplication+SNAdditions.m
//  
//
//  Created by AsnailNeo on 6/30/15.
//
//

#import "UIApplication+SNAdditions.h"

@implementation UIApplication (SNAdditions)

- (void)sn_setStatusBarHiddenWithNotification:(BOOL)hidden withAnimation:(UIStatusBarAnimation)animation
{
    if (self.statusBarHidden == hidden) return;
    
    [self setStatusBarHidden:hidden withAnimation:animation];
    [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidChangeStatusBarFrameNotification
                                                      object:nil
                                                    userInfo:@{UIApplicationStatusBarFrameUserInfoKey: [NSValue valueWithCGRect:self.statusBarFrame]}];
}


@end
