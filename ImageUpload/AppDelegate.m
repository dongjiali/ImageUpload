//
//  AppDelegate.m
//  ImageUpload
//
//  Created by Curry on 13-7-16.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "CenterViewController.h"
#import "MyNavigationController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    [self getLocationManager];
    //初始化用户名和密码
    [self setFirstlogintag];
    //设置调用网络缓存
    ASIDownloadCache *cache = [[ASIDownloadCache alloc] init];
    self.myCache = cache;
    [cache release];
    //设置缓存路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    [self.myCache setStoragePath:[documentDirectory stringByAppendingPathComponent:@"resource"]];
    [self.myCache setDefaultCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    
    //获取登陆状态
    BOOL logintag = [[NSUserDefaults standardUserDefaults] boolForKey:LOGINFLAG];
    LoginViewController *login = [[LoginViewController alloc]init];
    MyNavigationController *navigationController = [[MyNavigationController alloc] initWithRootViewController:login];
    navigationController.recognizer_.enabled = NO;
    [login release];
    [self.window setRootViewController:navigationController];
    [navigationController release];
    
    if (logintag) {
        CenterViewController *center = [[CenterViewController alloc]init];
        [navigationController pushViewController:center animated:NO];
    }
//    else{
//        LoginViewController *login = [[LoginViewController alloc]init];
//        mainViewController = login;
//    }    
    return YES;
}

-(void)setFirstlogintag
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:FIRSTLAUNCH]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:FIRSTLAUNCH];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:LOGINFLAG];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:USERNAME];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:PASSWORD];
    }
    else{
        return;
    }
}

- (void)getLocationManager
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];//创建位置管理器
    locationManager.delegate=self;//设置代理
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;//指定需要的精度级别
    locationManager.distanceFilter=1000.0f;//设置距离筛选器
    [locationManager startUpdatingLocation];//启动位置管理器
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
