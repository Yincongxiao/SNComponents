//
//  CGAdditions.h
//  QDaily
//
//  Created by AsnailNeo on 4/5/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNThemeHelper : NSObject

+ (CGSize)sn_sizeWithDict:(NSDictionary *)sizeDict;
+ (UIEdgeInsets)sn_edgeInsetsWithDict:(NSDictionary *)edgeDict;
+ (NSUInteger)sn_lineNumberWithDict:(NSDictionary *)dict;

@end
