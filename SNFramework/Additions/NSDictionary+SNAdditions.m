//
//  NSDictionary+SNAdditions.m
//  QDaily
//
//  Created by AsnailNeo on 4/10/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "NSDictionary+SNAdditions.h"

@implementation NSDictionary (SNSafeRequest)

- (id)sn_safeObjectForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return object;
}

@end
