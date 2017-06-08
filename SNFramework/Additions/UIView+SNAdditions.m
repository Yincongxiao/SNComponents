//
//  UIViewExtend.m
//  QDaily
//
//  Created by AsnailNeo on 15/10/24.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import "UIView+SNAdditions.h"

@implementation UIView(ViewFrameGeometry)

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)aPoint {
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

// Retrieve and set the size
- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)aSize {
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint)leftTop {
    return CGPointMake(self.frame.origin.x, self.frame.origin.y);
}

- (void)setLeftTop:(CGPoint)sn_leftTop {
    self.frame = CGRectMake(sn_leftTop.x, sn_leftTop.y, self.frame.size.width, self.frame.size.height);
}

- (CGPoint)rightTop {
    return CGPointMake(self.right, self.top);
}

- (void)setRightTop:(CGPoint)sn_rightTop {
    self.frame = CGRectMake(sn_rightTop.x - self.width, sn_rightTop.y, self.width, self.height);
}

// Retrieve and set height, width, top, bottom, left, right
- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect newframe = self.frame;
    newframe.origin.x = x;
    self.frame = newframe;
}

- (CGFloat)y {
    return self.frame.origin.y ;
}

- (void) setY:(CGFloat)y {
    CGRect newframe = self.frame;
    newframe.origin.y = y ;
    self.frame = newframe;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newheight {
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newwidth {
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop {
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)newleft {
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)newbottom {
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight:(CGFloat)newright {
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

// Move via offset
- (void)moveBy:(CGPoint)delta {
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void)scaleBy:(CGFloat)scaleFactor {
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void)fitInSize:(CGSize)aSize {
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height)) {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width)) {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

- (void)fitTheSubviews {
    CGFloat fWidth = 0 ;
    CGFloat fHeight = 0 ;
    for(UIView * subview in self.subviews) {
        fWidth = MAX( fWidth , subview.right ) ;
        fHeight = MAX( fHeight , subview.bottom ) ;
    }
    self.size = CGSizeMake( fWidth , fHeight ) ;
}

- (void)ceilAllSubviews {
    for (UIView *subView in self.subviews) {
        subView.frame = CGRectMake(ceilf(subView.left), ceilf(subView.top), ceilf(subView.width), ceilf(subView.height));
    }
}

-(void)frameIntegral {
    self.frame = CGRectIntegral(self.frame) ;
}

-(void)removeAllSubViews {
    for( UIView * subView in self.subviews ){
        [subView removeFromSuperview];
    }
}

- (id)addSubviewWithClass:(Class)viewClass {
    return [self addSubviewWithClass:viewClass frame:CGRectZero];
}

- (id)addSubviewWithClass:(Class)viewClass frame:(CGRect)frame {
    
    if (![viewClass isSubclassOfClass:[UIView class]]) return nil;
    
    UIView * subView = [[viewClass alloc] initWithFrame:frame];
    
    [self addSubview:subView];
    
    return subView;
}

-(void)removeSubViewWithTag:(UInt32)uiTag {
    UIView * subView = [self viewWithTag:uiTag];
    while( subView ){
        [subView removeFromSuperview];
        subView = [self viewWithTag:uiTag];
    }
}

-(void) removeSubViewWithClass : (Class) oClass {
    for( UIView * subView in self.subviews ){
        if( [subView isKindOfClass:oClass] ){
            [subView removeFromSuperview] ;
        }
    }
}

// adjust view is visible or not
-(BOOL)isDisplayedInScreen {
    
    if (self.window == nil) {
        return NO;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect rect = [self.superview convertRect:self.frame toView:[UIApplication sharedApplication].keyWindow];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return NO;
    }
    
    if (self.hidden) {
        return NO;
    }
    
    if (self.superview == nil) {
        return NO;
    }
    
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  NO;
    }
    
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return NO;
    }
    return YES;
}

@end


@implementation UIView(SNTapAction)

- (void)sn_addTapAction:(SEL)action target:(id)target {
    self.userInteractionEnabled = YES;
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:gesture];
}

- (void)removeAllGestureRecognizer {
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeGestureRecognizer:obj];
    }];
}

@end


@implementation UIView(ViewAutoresizingMask)

-(void) setAutoresizingMaskCenter {
    [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
}

-(void) setAutoresizingMaskCenterVertical {
    [self setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
}

-(void) setAutoresizingMaskCenterHorizontal {
    [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
}

@end
