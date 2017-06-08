//
//  UIImageView+SNAdditions.h
//  QDaily
//
//  Created by AsnailNeo on 5/25/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SNAdditions)

- (CGRect)sn_imagePosition;
- (void) sn_addBottomMask;
- (void) sn_removeBottomMask;
@end
