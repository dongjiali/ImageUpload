//
//  AppDelegate.h
//  ImageUpload
//
//  Created by Curry on 13-7-16.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ASIDownloadCache.h"
#import "MyNavigationController.h"
#import "MyNavigationController.h"
#import "WXApi.h"
#import "RespForWeChatViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,
UIAlertViewDelegate, WXApiDelegate, RespForWeChatViewDelegate>
{
    enum WXScene _scene;
    MyNavigationController *navigationController;
}
- (void)changeScene:(NSInteger)scene;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) ASIDownloadCache *myCache;
@end
