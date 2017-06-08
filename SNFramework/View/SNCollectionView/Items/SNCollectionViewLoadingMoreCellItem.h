//
//  SNCollectionViewLoadingMoreCellItem.h
//  QDaily
//
//  Created by AsnailNeo on 2/27/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "SNCollectionViewCellItem.h"

@interface SNCollectionViewLoadingMoreCellItem : SNCollectionViewCellItem

@property (nonatomic, assign) BOOL showSpinner;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL shouldNotLoadMore;

- (void)reset;
+ (instancetype)defaultCellItem;
+ (instancetype)fakeLoadMoreCellItem;
+ (instancetype)cellItemWithTitle:(NSString *)title;

@end
