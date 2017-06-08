//
//  SNTableCellItem.h
//  QDaily
//
//  Created by AsnailNeo on 4/13/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNTableViewCell;

@interface SNTableCellItem : NSObject

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, copy) NSString *nibName;

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) id rawObject;
@property (nonatomic, weak) SNTableViewCell *cell;

@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, assign) UITableViewCellAccessoryType cellAccessoryType;
@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;

@property (nonatomic, assign) BOOL selectable;
@property (nonatomic, assign) BOOL deselectAfterSelecting;
@property (nonatomic, assign) BOOL selected;


@end
