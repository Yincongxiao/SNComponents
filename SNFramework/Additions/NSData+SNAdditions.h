//
//  NSData+SNAdditions.h
//  QDaily
//
//  Created by AsnailNeo on 3/30/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SNAdditions)

/**
 * Calculate the md5 hash of this data using CC_MD5.
 *
 * @return md5 hash of this data
 */
@property (nonatomic, copy, readonly) NSString *sn_md5Hash;

@property (nonatomic, assign, readonly) float_t sn_sizeKB;

@end
