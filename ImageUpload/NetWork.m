//
//  NetWork.m
//  ImageUpload
//
//  Created by Curry on 13-7-16.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "NetWork.h"
#import "SaveScaledImage.h"

@implementation NetWork
@synthesize asiFormDataRequest = _asiFormDataRequest;
- (id)init
{
    if (self = [super init]) {

    }
    return self;
}

- (void)startHttpRequest:(NSMutableArray *)userInfoArray
{
    self.asiFormDataRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URLSTRING]];
    [self.asiFormDataRequest setDelegate:self];
    self.asiFormDataRequest.shouldAttemptPersistentConnection = NO;
    self.asiFormDataRequest.useCookiePersistence = YES;
    [self.asiFormDataRequest setPostValue:[userInfoArray objectAtIndex:0] forKey:@"UserName"];
    [self.asiFormDataRequest setPostValue:[userInfoArray objectAtIndex:1] forKey:@"PassWord"];
    [self.asiFormDataRequest buildRequestHeaders];
    [self.asiFormDataRequest setTimeOutSeconds:TIME_OUT_SECONDS];
    [self.asiFormDataRequest startAsynchronous];
}

- (void)stopHttpRequest
{
    if (self.asiFormDataRequest) {
        if (!self.asiFormDataRequest.isFinished) {
            [self.asiFormDataRequest clearDelegatesAndCancel];
        }
    }
}

//异步请求回调完成
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"cookie====%@", cookie);
    }
    NSString *responseData = [[request responseString]retain];
//    NSLog(@"network = %@",responseData);
    if ( [responseData length] == 0 || responseData == nil)
    {
        [[[[UIAlertView alloc] initWithTitle:@"提示信息:"
                                     message:@"服务器返回数据为空，请重新再试"
                                    delegate:nil
                           cancelButtonTitle:@"确定"
                           otherButtonTitles:nil] autorelease] show];
    }
    else
    {
        //将数据返回给逻辑层
        [self.delegate resultDataToUI:responseData];
    }
    NSLog(@"%@",responseData);
    [responseData release];
}

//网络请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [[[[UIAlertView alloc] initWithTitle:@"提示信息:"
                                     message:@"调用网络失败，请重新再试"
                                    delegate:nil
                           cancelButtonTitle:@"确定"
                           otherButtonTitles:nil] autorelease] show];
    NSError *error = [request error];
    NSLog(@"error=%@",error);
    [self.delegate resultFailed];
}

- (void)upLoadSalesBigImage:(NSString *)imagepath imageinfo:(NSMutableArray *)imageinfoarray
{
    if (imagepath.length >0 && imagepath !=nil) {
        NSURL *url = [NSURL URLWithString:@"http://192.168.51.107:8080/MyWeb/UploadServlets"];
        self.asiFormDataRequest  = [ASIFormDataRequest requestWithURL:url];
        self.asiFormDataRequest.useCookiePersistence = YES;
        [self.asiFormDataRequest setFile : imagepath forKey : @"file" ];
//        [self.asiFormDataRequest setFile : @"/Users/meoliver/Desktop/IMG_0534.JPG" forKey : @"file" ];
        [self.asiFormDataRequest setRequestMethod:@"POST"];
        [self.asiFormDataRequest buildRequestHeaders];
        [self.asiFormDataRequest buildPostBody];
        [self.asiFormDataRequest setCompletionBlock:^{
            NSString *responseString = [ self.asiFormDataRequest responseString ];
            [_delegate resultDataToUI:@"上传成功"];
            NSLog(@"%@",responseString);
        }];
        
        [self.asiFormDataRequest setFailedBlock:^{
            NSError*error =[self.asiFormDataRequest error];
            if (error) {
                NSLog(@"error = %@",error);
            }
            [[[[UIAlertView alloc] initWithTitle:@"提示信息:"
                                         message:@"上传失败，请重新再试"
                                        delegate:nil
                               cancelButtonTitle:@"确定"
                               otherButtonTitles:nil] autorelease] show];
            [_delegate resultFailed];
        }];
        [ self.asiFormDataRequest startSynchronous ];
    }
}

- (void)downLoadFile:(NSString *)savepath
{
    if (savepath.length >0 && savepath !=nil) {
        NSURL *url = [NSURL URLWithString:@"http://192.168.51.107:8080/MyWeb/DownLoadFileServlet"];
        self.asiFormDataRequest  = [ASIFormDataRequest requestWithURL:url];
        self.asiFormDataRequest.useCookiePersistence = YES;
        [self.asiFormDataRequest setDownloadDestinationPath :savepath];
        [self.asiFormDataRequest buildRequestHeaders];
        [self.asiFormDataRequest setRequestMethod:@"POST"];
        [self.asiFormDataRequest buildPostBody];
        [self.asiFormDataRequest setCompletionBlock:^{
            NSString *responseString = [ self.asiFormDataRequest responseString ];
            [_delegate resultDataToUI:@"下载成功"];
            NSLog(@"%@",responseString);
        }];
        
        [self.asiFormDataRequest setFailedBlock:^{
            NSError*error =[self.asiFormDataRequest error];
            if (error) {
                NSLog(@"error = %@",error);
            }
            [[[[UIAlertView alloc] initWithTitle:@"提示信息:"
                                         message:@"上传失败，请重新再试"
                                        delegate:nil
                               cancelButtonTitle:@"确定"
                               otherButtonTitles:nil] autorelease] show];
            [_delegate resultFailed];
        }];
        [ self.asiFormDataRequest startSynchronous ];
    }
}

- (void)dealloc
{
    [self.asiFormDataRequest clearDelegatesAndCancel];
    [_asiFormDataRequest release];
    [super dealloc];
}

@end
