//
//  SaveScaledImage.m
//  ImageUpload
//
//  Created by Curry on 13-7-18.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "SaveScaledImage.h"

@implementation SaveScaledImage
//对图片的处理
+ (UIImage*)imageWithImageSimple:(UIImage*)image
{
    CGSize newSize = CGSizeMake(image.size.width / ImageScaledSize , image.size.height / ImageScaledSize);
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
//保存文件
+ (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImageJPEGRepresentation(tempImage , ImageCompressionQuality);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}
//删除文件
+ (void)deletefile:(NSString *)stringname
{
    NSString *stringpath = stringname;
    NSFileManager *defaultManager;
    defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:stringpath error:nil];
}
@end
