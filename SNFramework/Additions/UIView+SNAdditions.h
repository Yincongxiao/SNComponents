//
//  UIViewExtend.h
//  QDaily
//
//  Created by AsnailNeo on 15/10/24.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

#define rm(x, y, w, h) SNRoundRectMake(x, y, w, h)
#define pm(x, y) SNRoundPointMake(x, y)
#define sm(w, h) SNRoundSizeMake(w, h)

CG_INLINE CGPoint SNRoundPoint(CGPoint point) {
    return CGPointMake(roundf(point.x), roundf(point.y));
}

CG_INLINE CGSize SNRoundSize(CGSize size) {
    return CGSizeMake((size.width), roundf(size.height));
}

CG_INLINE CGRect SNRoundRect(CGRect rect) {
    return CGRectMake(roundf(rect.origin.x), roundf(rect.origin.y), rect.size.width, rect.size.height);
}

CG_INLINE CGRect SNRoundRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    return CGRectMake(roundf(x), roundf(y), width, height);
}

CG_INLINE CGPoint SNRoundPointMake(CGFloat x, CGFloat y) {
    return CGPointMake(roundf(x), roundf(y));
}

CG_INLINE CGSize SNRoundSizeMake(CGFloat width, CGFloat height) {
    return CGSizeMake(roundf(width), roundf(height));
}


@interface UIView(ViewFrameGeometry)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint leftTop;
@property (nonatomic, assign) CGPoint rightTop;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

-(void)frameIntegral;

- (void)moveBy:(CGPoint)delta;
- (void)scaleBy:(CGFloat)scaleFactor;
- (void)fitInSize:(CGSize)aSize;

- (void)fitTheSubviews;
- (void)ceilAllSubviews;


- (id)addSubviewWithClass:(Class)viewClass frame:(CGRect)frame;
- (id)addSubviewWithClass:(Class)viewClass;

-(void)removeAllSubViews;
-(void)removeSubViewWithTag:(UInt32)uiTag;
-(void)removeSubViewWithClass:(Class)oClass;

-(BOOL)isDisplayedInScreen;

@end


@interface UIView (SNTapAction)

- (void)sn_addTapAction:(SEL)action target:(id)target;

-(void)removeAllGestureRecognizer;

@end


@interface UIView(ViewAutoresizingMask)

-(void)setAutoresizingMaskCenter;
-(void)setAutoresizingMaskCenterVertical;
-(void)setAutoresizingMaskCenterHorizontal;

@end
