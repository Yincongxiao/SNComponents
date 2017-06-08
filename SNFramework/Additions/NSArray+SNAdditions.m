//
//  NSArray+SNAdditions.m
//  QDaily
//
//  Created by AsnailNeo on 3/30/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "NSArray+SNAdditions.h"
#import "SNFrameworkGlobal.h"

@implementation NSArray (SNAdditions)

- (id)sn_objectAtSafeIndex:(NSUInteger)index {
    if ([self count] > index) {
        return [self objectAtIndex:index];
    } else {
        if (self.count) LogW(@"Invalid array index!");
        return nil;
    }
}

@end


@implementation NSMutableArray (SNAdditions)

- (id)sn_objectAtSafeIndex:(NSUInteger)index {
    if ([self count] > index) {
        return [self objectAtIndex:index];
    } else {
        if (self.count) LogW(@"Invalid array index!");
        return nil;
    }
}

- (void)sn_addNonnilObject:(id)object {
    if (object) {
        [self addObject:object];
    } else {
        LogW(@"Empty object");
    }
}


@end
