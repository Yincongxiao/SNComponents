//
//  SNGifRefreshHeader.h
//  QDaily
//
//  Created by AsnailNeo on 5/13/15.
//  Modified from https://github.com/CoderMJLee/MJRefresh to fit SNFramework.
//  MJRefresh created by MJ Lee on 15/3/4.
//
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNDragDownRefreshHeader.h"

@interface SNGifRefreshHeader : SNDragDownRefreshHeader

@property (nonatomic, assign) BOOL adjustFrameWithImage;
@property (nonatomic, assign) CGSize imageSize;

- (instancetype)initWithFrame:(CGRect)frame imageSize:(CGSize)size;

- (void)setImages:(NSArray *)images forState:(SNRefreshHeaderState)state;


@end
