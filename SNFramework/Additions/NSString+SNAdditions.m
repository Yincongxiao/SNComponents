//
//  NSString+SNAdditions.m
//  QDaily
//
//  Created by AsnailNeo on 3/30/15.
//  Copyright (c) 2016 Personal. All rights reserved.
//

#import "NSString+SNAdditions.h"
#import "NSData+SNAdditions.h"

@implementation NSString (SNPathUtilites)

+ (NSString *)sn_documentsFolder {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)sn_libraryFolder {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)sn_cachesFolder {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)sn_filePathOfDocumentFolderWithName:(NSString *)fileName {
    return [[NSString sn_documentsFolder] stringByAppendingPathComponent:fileName];
}

+ (NSString *)sn_filePathOfCachesFolderWithName:(NSString *)fileName {
    return [[NSString sn_cachesFolder] stringByAppendingPathComponent:fileName];
}

@end

@implementation NSString (SNEncryption)

- (NSString *)sn_xorEncryptDecrypt {
    
    char key[] = {'L', 'F'};
    
    NSMutableString *outputString = [[NSMutableString alloc] init];
    
    for (int i = 0; i < self.length; i++) {
        char c = [self characterAtIndex:i];
        c ^= key[i % sizeof(key)/sizeof(char)];
        [outputString appendString:[NSString stringWithFormat:@"%c", c]];
    }
    
    return outputString;
}

- (NSString *)sn_shiftEncrypt {
    
    const char * ptr = [self cStringUsingEncoding:NSASCIIStringEncoding];
    char *cString = malloc(sizeof(char) * self.length);
    strcpy(cString, ptr);
    
    for (int i = 0; i < self.length; i++) {
        if ((cString[i] >= '0' && cString[i] <= '9') ||
            (cString[i] >= 'a' && cString[i] <= 'z') ||
            (cString[i] >= 'A' && cString[i] <= 'Z')) {
            int shiftValue = cString[i] + 3;
            if (shiftValue > '9' && shiftValue < 'A') {
                shiftValue = 'a' + (shiftValue - '9') - 1;
            } else if (shiftValue > 'Z' && shiftValue < 'a') {
                shiftValue = 'A' + (shiftValue - 'Z') - 1;
            } else if (shiftValue > 'z' && shiftValue < ('z'+3)) {
                shiftValue = '0' + (shiftValue - 'z') - 1;
            }
            cString[i] = shiftValue;
        }
    }
    
    char *rotatedString = malloc(sizeof(char) * self.length);
    for (int i = 0; i < self.length; i++) {
        rotatedString[i] = cString[(i + 3)%self.length];
    }
    
    NSString *encryptedString = [NSString stringWithCString:rotatedString encoding:NSASCIIStringEncoding];
    
    free(cString);
    free(rotatedString);
    
    return encryptedString;
}

- (NSString *)sn_shiftDecrypt {
    
    const char * ptr = [self cStringUsingEncoding:NSASCIIStringEncoding];
    char *cString = malloc(sizeof(char) * self.length);
    strcpy(cString, ptr);
    
    for (int i = 0; i < self.length; i++) {
        if ((cString[i] >= '0' && cString[i] <= '9') ||
            (cString[i] >= 'a' && cString[i] <= 'z') ||
            (cString[i] >= 'A' && cString[i] <= 'Z')) {
            int shiftValue = cString[i] - 3;
            if (shiftValue > 'Z' && shiftValue < 'a') {
                shiftValue = '9' - ('a' - shiftValue) + 1;
            } else if (shiftValue > '9' && shiftValue < 'A') {
                shiftValue = 'Z' - ('A' - shiftValue) + 1;
            } else if (shiftValue > ('0' - 3) && shiftValue < '0') {
                shiftValue = 'z' - ('0' - shiftValue) + 1;
            }
            cString[i] = shiftValue;
        }
    }
    
    char *rotatedString = malloc(sizeof(char) * self.length);
    for (int i = 0; i < self.length; i++) {
        rotatedString[i] = cString[(i - 3 + self.length)%self.length];
    }
    
    NSString *decryptedString = [NSString stringWithCString:rotatedString encoding:NSASCIIStringEncoding];
    
    free(cString);
    free(rotatedString);
    
    return decryptedString;
}


- (NSString *)sn_md5Hash {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sn_md5Hash];
}

- (NSString *)sn_md5Hash16 {
    NSString *md5String = [self sn_md5Hash];
    return [[md5String substringToIndex:24] substringFromIndex:8];
}

@end

@implementation NSString (SNAdditions)

- (BOOL)sn_isEqualIgnoringCase:(NSString *)string {
    return [self caseInsensitiveCompare:string] == NSOrderedSame;
}

- (NSString *)sn_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)sn_trimAllSpace {
    return  [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
}

- (BOOL)sn_containsSubString:(NSString *)subString
{
    return [self rangeOfString:subString options:NSCaseInsensitiveSearch].location != NSNotFound;
}

- (BOOL)sn_isNumberic {
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    return [alphaNums isSupersetOfSet:inStringSet];
}

@end

@implementation NSString (SNURLUtilities)

- (NSString *)sn_URLEncode:(NSStringEncoding)stringEncoding {
    
    NSArray *escapeChars = [NSArray arrayWithObjects:@";", @"/", @"?", @":",
                            @"@", @"&", @"=", @"+", @"$", @",", @"!",
                            @"'", @"(", @")", @"*", @"-", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B", @"%2F", @"%3F", @"%3A",
                             @"%40", @"%26", @"%3D", @"%2B", @"%24", @"%2C", @"%21",
                             @"%27", @"%28", @"%29", @"%2A", @"%2D", nil];
    
    NSInteger len = [escapeChars count];
    NSString *tempStr = [self stringByAddingPercentEscapesUsingEncoding:stringEncoding];
    if (tempStr == nil) {
        return nil;
    }
    
    NSMutableString *temp = [tempStr mutableCopy];
    for (int i = 0; i < len; i++) {
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString: temp];
    
    return outStr;
}

- (NSString*)sn_URLDecodedString {
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (__bridge CFStringRef)self,
                                                                                                             CFSTR(""),                                                                             kCFStringEncodingUTF8);
    return result;
}

@end

@implementation NSString (SNVersionUtilities)

- (NSComparisonResult)sn_versionStringCompare:(NSString *)other {
    NSArray *oneComponents = [self componentsSeparatedByString:@"a"];
    NSArray *twoComponents = [other componentsSeparatedByString:@"a"];
    
    // The parts before the "a"
    NSString *oneMain = [oneComponents objectAtIndex:0];
    NSString *twoMain = [twoComponents objectAtIndex:0];
    
    // If main parts are different, return that result, regardless of alpha part
    NSComparisonResult mainDiff;
    if ((mainDiff = [oneMain compare:twoMain]) != NSOrderedSame) {
        return mainDiff;
    }
    
    // At this point the main parts are the same; just deal with alpha stuff
    // If one has an alpha part and the other doesn't, the one without is newer
    if ([oneComponents count] < [twoComponents count]) {
        return NSOrderedDescending;
        
    } else if ([oneComponents count] > [twoComponents count]) {
        return NSOrderedAscending;
        
    } else if ([oneComponents count] == 1) {
        // Neither has an alpha part, and we know the main parts are the same
        return NSOrderedSame;
    }
    
    // At this point the main parts are the same and both have alpha parts. Compare the alpha parts
    // numerically. If it's not a valid number (including empty string) it's treated as zero.
    NSNumber *oneAlpha = [NSNumber numberWithInt:[[oneComponents objectAtIndex:1] intValue]];
    NSNumber *twoAlpha = [NSNumber numberWithInt:[[twoComponents objectAtIndex:1] intValue]];
    return [oneAlpha compare:twoAlpha];
}

@end
