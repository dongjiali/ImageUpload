//
//  CenterViewController.h
//  ImageUpload
//
//  Created by Curry on 13-7-16.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWork.h"
#import "MyProgressView.h"
@interface CenterViewController : UIViewController<ProgressDelegate,NetWorkDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, retain) UIImagePickerController *imagePicker;
@property (nonatomic, retain) NSString *imagePathString;
@end
