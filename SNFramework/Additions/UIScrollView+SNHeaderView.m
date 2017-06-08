//
//  UIScrollView+SNHeaderView.m
//  QDaily
//
//  Created by AsnailNeo on 5/7/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "UIScrollView+SNHeaderView.h"
#import <objc/runtime.h>
#import "SNUtilityMacros.h"

@implementation UIScrollView (SNAdditions)

- (void)setLf_insetTop:(CGFloat)sn_insetTop {
    UIEdgeInsets inset = self.contentInset;
    inset.top = sn_insetTop;
    self.contentInset = inset;
}

- (CGFloat)sn_insetTop {
    return self.contentInset.top;
}

- (void)setLf_insetBottom:(CGFloat)sn_insetBottom {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = sn_insetBottom;
    self.contentInset = inset;
}

- (CGFloat)sn_insetBottom {
    return self.contentInset.bottom;
}

- (void)setLf_insetLeft:(CGFloat)sn_insetLeft {
    UIEdgeInsets inset = self.contentInset;
    inset.left = sn_insetLeft;
    self.contentInset = inset;
}

- (CGFloat)sn_insetLeft {
    return self.contentInset.left;
}

- (void)setLf_insetRight:(CGFloat)sn_insetRight {
    UIEdgeInsets inset = self.contentInset;
    inset.right = sn_insetRight;
    self.contentInset = inset;
}

- (CGFloat)sn_insetRight {
    return self.contentInset.right;
}

- (void)setLf_offsetX:(CGFloat)sn_offsetX {
    CGPoint offset = self.contentOffset;
    offset.x = sn_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)sn_offsetX {
    return self.contentOffset.x;
}

- (void)setLf_offsetY:(CGFloat)sn_offsetY {
    CGPoint offset = self.contentOffset;
    offset.y = sn_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)sn_offsetY {
    return self.contentOffset.y;
}

- (void)setLf_contentSizeWidth:(CGFloat)sn_contentSizeWidth {
    CGSize size = self.contentSize;
    size.width = sn_contentSizeWidth;
    self.contentSize = size;
}

- (CGFloat)sn_contentSizeWidth {
    return self.contentSize.width;
}

- (void)setLf_contentSizeHeight:(CGFloat)sn_contentSizeHeight {
    CGSize size = self.contentSize;
    size.height = sn_contentSizeHeight;
    self.contentSize = size;
}

- (CGFloat)sn_contentSizeHeight {
    return self.contentSize.height;
}


@end

@implementation UIScrollView (SNHeaderView)

#pragma mark -
#pragma mark Accessors

- (void)setSn_headerView:(UIView *)sn_headerView {
    
    [self willChangeValueForKey:@"sn_headerView"];
    
    objc_setAssociatedObject(self, @selector(sn_headerView), sn_headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (sn_headerView.superview != self) {
        [sn_headerView removeFromSuperview];
        [self addSubview:sn_headerView];
    }
    
    [self didChangeValueForKey:@"sn_headerView"];
}

- (UIView *)sn_headerView {
    return (UIView *)objc_getAssociatedObject(self, @selector(sn_headerView));
}

- (void)setLf_refreshHeader:(SNRefreshHeader *)sn_refreshHeader {
    
    [self willChangeValueForKey:@"sn_refreshHeader"];
    
    if (!sn_refreshHeader) {
        if (self.sn_refreshHeader && self.sn_refreshHeader.superview == self) {
            [self.sn_refreshHeader removeFromSuperview];
        }
    }
    
    objc_setAssociatedObject(self, @selector(sn_refreshHeader), sn_refreshHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (sn_refreshHeader.superview != self) {
        [sn_refreshHeader removeFromSuperview];
        [self addSubview:sn_refreshHeader];
    }
    
    [self didChangeValueForKey:@"sn_refreshHeader"];
}

- (SNRefreshHeader *)sn_refreshHeader {
    return (SNRefreshHeader *)objc_getAssociatedObject(self, @selector(sn_refreshHeader));
}

#pragma mark -
#pragma mark Initialization

- (void)sn_addRefreshHeaderWithRefreshingBlock:(void (^)())block withRefreshHeaderClass:(Class)refreshHeaderClass {
    if ([refreshHeaderClass isSubclassOfClass:[SNRefreshHeader class]]) {
        if (self.sn_refreshHeader) {
            self.sn_refreshHeader = nil;
        }
        SNRefreshHeader *refreshHeader = [[refreshHeaderClass alloc] initWithNightMode:NO];
        refreshHeader.refreshingBlock = block;
        self.sn_refreshHeader = refreshHeader;
    } else {
        LogE(@"Invalid SNRefreshHeader Class!");
    }
}

- (void)sn_removeRefreshHeader {
    if (!self.sn_refreshHeader) return;
    if (self.sn_refreshHeader.superview == self) {
        [self.sn_refreshHeader removeFromSuperview];
    }
}

#pragma mark -
#pragma mark Swizzle

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(method1, method2);
}

- (void)deallocSwizzle {
    self.sn_refreshHeader = nil;
    [self deallocSwizzle];
}

@end
