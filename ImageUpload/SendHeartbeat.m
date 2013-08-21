//
//  SendHeartbeat.m
//  ImageUpload
//
//  Created by Curry on 13-7-18.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "SendHeartbeat.h"
#import "ASIHTTPRequest.h"

@implementation SendHeartbeat
@synthesize timer = _timer;
- (void)sendheartbeatblock:(BlockToRoot)block;
{
    _blockToRoot = [block copy];
   self.timer = [NSTimer scheduledTimerWithTimeInterval:SEND_HEART_TIME target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
}

- (void)progressChange
{
    ASIHTTPRequest *asiHttpRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URLSTRING]];
    [ASIHTTPRequest setSessionCookies:nil];
    [ASIHTTPRequest clearSession];
    [asiHttpRequest setDelegate:self];
    asiHttpRequest.shouldAttemptPersistentConnection = NO;
    asiHttpRequest.useCookiePersistence = YES;
    [asiHttpRequest setRequestMethod:@"POST"];
    [asiHttpRequest buildRequestHeaders];
    [asiHttpRequest setTimeOutSeconds:TIME_OUT_SECONDS];
    [asiHttpRequest startAsynchronous];
}

//异步请求回调完成
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"cookie====%@}}}}}}", cookie);
    }
    NSString *responseData = [[request responseString]retain];
    //    NSLog(@"network = %@",responseData);
    if ( [responseData length] == 0 || responseData == nil)
    {
        NSLog(@"与后台连接成功");
    }
    else
    {
        //将数据返回给逻辑层
//        [self.delegate resultDataToUI:responseData];
    }
    [responseData release];
}

//网络请求失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [[[[UIAlertView alloc] initWithTitle:@"提示信息:"
                                 message:@"与服务器断开链接，请重新登陆"
                                delegate:self
                       cancelButtonTitle:@"确定"
                       otherButtonTitles:nil] autorelease] show];
    [request cancelAuthentication];
    NSError *error = [request error];
    [request cancel];
    NSLog(@"error=%@",error);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.timer.isValid) {
        [self.timer invalidate];
        [_timer release];
        _timer = nil;
    }
    if (buttonIndex == 0) {
        _blockToRoot(self);
    }
}
- (void)dealloc
{
    [_blockToRoot release];
    [super dealloc];
}

@end
