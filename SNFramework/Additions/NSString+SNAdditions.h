//
//  NSString+SNAdditions.h
//  QDaily
//
//  Created by AsnailNeo on 3/30/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SNPathUtilites)

+ (NSString *)sn_documentsFolder;

+ (NSString *)sn_cachesFolder;

+ (NSString *)sn_libraryFolder;

+ (NSString *)sn_filePathOfDocumentFolderWithName:(NSString *)fileName;

+ (NSString *)sn_filePathOfCachesFolderWithName:(NSString *)fileName;

@end

@interface NSString (SNEncryption)

/**
 * Calculate the md5 hash of this string using CC_MD5.
 *
 * @return md5 hash of this string
 */
@property (nonatomic, copy, readonly) NSString *sn_md5Hash;
@property (nonatomic, copy, readonly) NSString *sn_md5Hash16;

/**
 * Simple encryption of the string using XOR operation. Reversible.
 *
 * @return the string after XOR operation.
 */
- (NSString *)sn_xorEncryptDecrypt;

/**
 * Simple encryption by shifting the ASCII value of the char.
 * This method only procceds with number and letter, leaves all other character as is.
 *
 * @return the encrypted string.
 */
- (NSString *)sn_shiftEncrypt;

/**
 * Simple decryption by shifting back the ASCII value of the char.
 *
 * @return the decrypted string.
 */
- (NSString *)sn_shiftDecrypt;

@end

@interface NSString (SNAdditions)

/**
 * Compare ignoring case and avoid the nil == NSOrderedSame pitfall.
 */
- (BOOL)sn_isEqualIgnoringCase:(NSString *)string;

/**
 * Returns a trimed String
 */
- (NSString *)sn_trim;

/**
 * Returns a string get rid of all the space
 */
- (NSString *)sn_trimAllSpace;

- (BOOL)sn_containsSubString:(NSString *)subString;

- (BOOL)sn_isNumberic;

@end

@interface NSString (SNURLUtilities)

- (NSString *)sn_URLEncode:(NSStringEncoding)stringEncoding;

- (NSString *)sn_URLDecodedString;

@end

@interface NSString (SNVersionUtilities)

/**
 * Compares two strings expressing software versions.
 *
 * The comparison is (except for the development version provisions noted below) lexicographic
 * string comparison. So as long as the strings being compared use consistent version formats,
 * a variety of schemes are supported. For example "3.02" < "3.03" and "3.0.2" < "3.0.3". If you
 * mix such schemes, like trying to compare "3.02" and "3.0.3", the result may not be what you
 * expect.
 *
 * Development versions are also supported by adding an "a" character and more version info after
 * it. For example "3.0a1" or "3.01a4". The way these are handled is as follows: if the parts
 * before the "a" are different, the parts after the "a" are ignored. If the parts before the "a"
 * are identical, the result of the comparison is the result of NUMERICALLY comparing the parts
 * after the "a". If the part after the "a" is empty, it is treated as if it were "0". If one
 * string has an "a" and the other does not (e.g. "3.0" and "3.0a1") the one without the "a"
 * is newer.
 *
 * Examples (?? means undefined):
 *   "3.0" = "3.0"
 *   "3.0a2" = "3.0a2"
 *   "3.0" > "2.5"
 *   "3.1" > "3.0"
 *   "3.0a1" < "3.0"
 *   "3.0a1" < "3.0a4"
 *   "3.0a2" < "3.0a19"  <-- numeric, not lexicographic
 *   "3.0a" < "3.0a1"
 *   "3.02" < "3.03"
 *   "3.0.2" < "3.0.3"
 *   "3.00" ?? "3.0"
 *   "3.02" ?? "3.0.3"
 *   "3.02" ?? "3.0.2"
 */
- (NSComparisonResult)sn_versionStringCompare:(NSString *)other;

@end
