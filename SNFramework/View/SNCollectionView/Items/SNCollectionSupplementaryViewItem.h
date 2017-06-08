//
//  SNCollectionSupplementaryViewItem.h
//  QDaily
//
//  Created by AsnailNeo on 5/23/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewCellItem.h"

UIKIT_EXTERN NSString *const SNCollectionSupplementaryViewItemHeaderKind;

@interface SNCollectionSupplementaryViewItem : SNCollectionViewCellItem

@property (nonatomic, copy) NSString *supplementaryElementKind;

@end
