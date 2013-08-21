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
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) ASIDownloadCache *myCache;
@end
