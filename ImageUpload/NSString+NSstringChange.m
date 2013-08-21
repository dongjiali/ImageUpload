//
//  NSString+NSstringChange.m
//  ImageUpload
//
//  Created by Curry on 13-7-16.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "NSString+NSstringChange.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (NSstringChange)
+ (NSString *)encode:(NSString *)value{
    
    [value retain];
    const char *cStr = [value UTF8String];
    [value release];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (BOOL)isNullOrEmpty:(NSString *)string;
{
    if (nil == string)
    {
        return YES;
    }
    else if ([@"" isEqualToString:string])
    {
        return YES;
    }
    return NO;
}
@end
