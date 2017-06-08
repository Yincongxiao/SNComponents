//
//  SNGifRefreshControl.h
//  QDaily
//
//  Created by AsnailNeo on 5/13/15.
//  Modified from https://github.com/CoderMJLee/MJRefresh to fit SNFramework.
//  MJRefresh created by MJ Lee on 15/3/4.
//
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SNRefreshHeaderState) {
    SNRefreshHeaderStateIdle = 1,
    SNRefreshHeaderStatePulling,
    SNRefreshHeaderStateRefreshing,
    SNRefreshHeaderStateWillRefresh,
    SNRefreshHeaderStateSkyRefreshing,//二楼
};

@interface SNRefreshHeader : UIView

@property (nonatomic, assign) BOOL animating;
@property (nonatomic, assign, getter=isRefreshing) BOOL refresing;
@property (nonatomic, assign) BOOL nightMode;

@property (nonatomic, copy) void (^refreshingBlock)();

- (instancetype) initWithNightMode:(BOOL) nightMode;
- (instancetype) initWithFrame:(CGRect)frame nightMode:(BOOL) nightMode;

- (void)beginRefreshing;
- (void)endRefreshing;

@end
