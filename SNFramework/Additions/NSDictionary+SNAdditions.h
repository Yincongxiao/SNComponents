//
//  NSDictionary+SNAdditions.h
//  QDaily
//
//  Created by AsnailNeo on 4/10/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SNSafeRequest)

- (id)sn_safeObjectForKey:(id)aKey;

@end
