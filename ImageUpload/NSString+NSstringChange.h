//
//  NSString+NSstringChange.h
//  ImageUpload
//
//  Created by Curry on 13-7-16.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSstringChange)
+ (NSString *)encode:(NSString *)value;
+ (BOOL)isNullOrEmpty:(NSString *)string;
@end
