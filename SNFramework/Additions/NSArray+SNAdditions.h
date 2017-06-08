//
//  NSArray+SNAdditions.h
//  QDaily
//
//  Created by AsnailNeo on 3/30/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (SNAdditions)

- (id)sn_objectAtSafeIndex:(NSUInteger)index;

@end

@interface NSMutableArray (SNAdditions)

- (id)sn_objectAtSafeIndex:(NSUInteger)index;
- (void)sn_addNonnilObject:(id)object;

@end
