//
//  NSMutableDictionary+SNAdditions.h
//  QDaily
//
//  Created by AsnailNeo on 3/30/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SNSafety)

- (void)sn_setSafeObject:(id)anObject forKey:(id)aKey;
- (void)sn_SafeRemoveObjectForKey:(id)aKey;

@end
