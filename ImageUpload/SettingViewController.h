//
//  SettingViewController.h
//  ImageUpload
//
//  Created by Curry on 13-7-24.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@interface SettingViewController : UIViewController
@property (nonatomic,retain)id delegate;

- (id)init:(id)delegate;
@end
