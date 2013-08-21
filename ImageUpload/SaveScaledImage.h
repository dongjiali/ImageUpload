//
//  SaveScaledImage.h
//  ImageUpload
//
//  Created by Curry on 13-7-18.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveScaledImage : NSObject
+ (UIImage*)imageWithImageSimple:(UIImage*)image;
+ (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
+ (void)deletefile:(NSString *)stringname;
@end
