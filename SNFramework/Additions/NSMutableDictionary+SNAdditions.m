//
//  NSMutableDictionary+SNAdditions.m
//  QDaily
//
//  Created by AsnailNeo on 3/30/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "NSMutableDictionary+SNAdditions.h"

@implementation NSMutableDictionary (SNSafety)

- (void)sn_setSafeObject:(id)anObject forKey:(id)aKey {
    if (anObject != nil) {
        [self setObject:anObject forKey:aKey];
    }
}

- (void)sn_SafeRemoveObjectForKey:(id)aKey {
    if (aKey != nil) {
        [self removeObjectForKey:aKey];
    }
}

@end
