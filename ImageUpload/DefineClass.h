//
//  DefineClass.h
//  ImageUpload
//
//  Created by Curry on 13-7-16.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#ifndef InsureOnline_PubDefine_h
#define InsureOnline_PubDefine_h

//角度转弧度
#define DEGREES_2_RADIANS(x) (M_PI/180.0 * (x))
/*获取当前设置的屏幕宽和高*/
#define DeviceScreenWidth   [UIScreen mainScreen].bounds.size.width
#define DeviceScreenHeight  [UIScreen mainScreen].bounds.size.height
#define FIRSTLAUNCH @"FirstLaunch"
#define LOGINFLAG @"LoginFlag"
#define USERNAME @"UserName"
#define PASSWORD @"PassWord"
//服务器地址
#define URLSTRING @"http://192.168.51.107:8080/MyWeb/HelloServlet"
//#define URLSTRING @"http://blog.cnrainbird.com"
//网络连接失败
#define NETWORKCONNECTFAILED @"400"
//网络超时超时时间
#define TIME_OUT_SECONDS 20
//获取沙盒文件夹
#define DocumentsDirectory [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
//设置图片缩放大小(倍数)
#define ImageScaledSize 2
//压缩图片的质量大小
#define ImageCompressionQuality 0.5
//设置心跳间隔（秒）
#define SEND_HEART_TIME 30.0

#define ColorWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a + 0.0f]
#define ColorClear [UIColor clearColor]

#define ImageWithName(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource: name ofType:@"png"]]

#define STRINGNULL(string) string==nil?@"":string
#endif