//
//  SNRefreshHeader+Private.h
//  QDaily
//
//  Created by AsnailNeo on 5/17/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const SNRefershHeaderContentOffsetKeyPath;
UIKIT_EXTERN NSString *const SNRefershHeaderContentSizeKeyPath;
UIKIT_EXTERN NSString *const SNRefershHeaderPanStateKeyPath;

@interface SNRefreshHeader ()

@property (nonatomic, assign) SNRefreshHeaderState state;
@property (nonatomic, assign) UIEdgeInsets scrollViewOriginalInset;
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, assign) CGFloat pullingPercent;

- (void)adjustStateWithContentOffset;

@end
