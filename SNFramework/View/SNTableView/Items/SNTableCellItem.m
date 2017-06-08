//
//  SNTableCellItem.m
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTableCellItem.h"
#import "SNTableViewCell.h"
#import "NSString+SNAdditions.h"
#import "UIView+SNAdditions.h"
#import "UIScreen+SNAdditions.h"

@implementation SNTableCellItem

#pragma mark -
#pragma mark Accessors

//  Generate the identifier based on the cell's class
- (NSString *)identifier {
    if (_identifier == nil) {
        _identifier = [[NSString alloc] initWithFormat:@"TableCell%@Identifier", [[self.nibName sn_trim] length] ? self.nibName : self.cellClass];
    }
    return _identifier;
}

#pragma mark -
#pragma mark Life Cycle

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        self.cellStyle = UITableViewCellStyleDefault;
        self.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.cellSelectionStyle = UITableViewCellSelectionStyleBlue;
        self.cellClass = [SNTableViewCell class];
        self.selectable = YES;
        self.deselectAfterSelecting = YES;
        self.cellWidth = [UIScreen sn_screenWidth];
    }
    
    return self;
}

@end
