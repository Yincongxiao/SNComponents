//
//  SNTableViewCell.m
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNTableViewCell.h"
#import "SNFrameworkGlobal.h"

@implementation SNTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                     cellItem:(SNTableCellItem *)cellItem
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}

- (void)setCellItem:(SNTableCellItem *)cellItem {
    
    if (![cellItem isKindOfClass:[SNTableCellItem class]]) {
        LogW(@"Invalid SNTableCellItem Class!");
        return;
    }
    
    if (!cellItem.selectable) self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self prepareForSettingCellItem:cellItem];
    
    _cellItem = cellItem;
    cellItem.cell = self;
    
    [self finalizeSettingCellItem:cellItem];
}

- (void)prepareForSettingCellItem:(SNTableCellItem *)cellItem {
    if (![cellItem isKindOfClass:[SNTableCellItem class]]) {
        LogW(@"Invalid Cell Item!");
        return;
    }
}

- (void)finalizeSettingCellItem:(SNTableCellItem *)cellItem {
    
}

@end
