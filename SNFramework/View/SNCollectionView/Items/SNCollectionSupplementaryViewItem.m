//
//  SNCollectionSupplementaryViewItem.m
//  QDaily
//
//  Created by AsnailNeo on 5/23/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionSupplementaryViewItem.h"
#import "NSString+SNAdditions.h"

NSString * const SNCollectionSupplementaryViewItemHeaderKind = @"SNCollectionSupplementaryViewItemHeaderKind";

@implementation SNCollectionSupplementaryViewItem

@synthesize identifier = _identifier;

//  Generate the identifier based on the cell's class
- (NSString *)identifier {
    if (_identifier == nil) {
        _identifier = [[NSString alloc] initWithFormat:@"CollectionSupplementary%@Identifier", [[self.nibName sn_trim] length] ? self.nibName : self.cellClass];
    }
    return _identifier;
}

@end
