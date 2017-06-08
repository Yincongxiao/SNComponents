//
//  SNNavigationTransition.h
//  QDaily
//
//  Created by AsnailNeo on 6/9/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNNavigationTransition : NSObject

@property (nonatomic, assign) Class animatorClass;
@property (nonatomic, assign) NSTimeInterval transitionDuration;

- (instancetype)initWithViewNavigationController:(UINavigationController *)navigationController;

@end
