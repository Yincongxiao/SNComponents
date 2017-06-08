//
//  UIScrollView+SNHeaderView.h
//  QDaily
//
//  Created by AsnailNeo on 5/7/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNRefreshHeader.h"

@interface UIScrollView (SNAdditions)

@property (assign, nonatomic) CGFloat sn_insetTop;
@property (assign, nonatomic) CGFloat sn_insetBottom;
@property (assign, nonatomic) CGFloat sn_insetLeft;
@property (assign, nonatomic) CGFloat sn_insetRight;

@property (assign, nonatomic) CGFloat sn_offsetX;
@property (assign, nonatomic) CGFloat sn_offsetY;

@property (assign, nonatomic) CGFloat sn_contentSizeWidth;
@property (assign, nonatomic) CGFloat sn_contentSizeHeight;

@end

@interface UIScrollView (SNHeaderView)

@property (nonatomic, strong) UIView *sn_headerView;
@property (nonatomic, strong) SNRefreshHeader *sn_refreshHeader;

- (void)sn_addRefreshHeaderWithRefreshingBlock:(void (^)())block withRefreshHeaderClass:(Class)refreshHeaderClass;
- (void)sn_removeRefreshHeader;

@end
