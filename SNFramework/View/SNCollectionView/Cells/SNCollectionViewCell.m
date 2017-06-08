//
//  SNCollectionViewCell.m
//  QDaily
//
//  Created by AsnailNeo on 2/1/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewCell.h"
#import "SNFrameworkGlobal.h"

@interface SNCollectionViewCell ()

@end

@implementation SNCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellItem:(SNCollectionViewCellItem *)cellItem {
    
    [self prepareForSettingCellItem:cellItem];
    
    _cellItem = cellItem;
    cellItem.cell = self;
    
    [self finalizeSettingCellItem:cellItem];
}

- (void)prepareForSettingCellItem:(SNCollectionViewCellItem *)cellItem {
    if (![cellItem isKindOfClass:[SNCollectionViewCellItem class]]) {
        LogW(@"Invalid Cell Item!");
        return;
    }
}

- (void)willDisplay {}

- (void)didEndDisplay {}

- (void)finalizeSettingCellItem:(SNCollectionViewCellItem *)cellItem {
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%p: %@ - %@ - %@", self, [[self class] description], self.cellItem, NSStringFromCGRect(self.frame)];
}

@end
