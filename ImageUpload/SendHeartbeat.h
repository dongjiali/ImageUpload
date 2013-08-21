//
//  SendHeartbeat.h
//  ImageUpload
//
//  Created by Curry on 13-7-18.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^BlockToRoot)(id delegate);
@interface SendHeartbeat : NSObject<UIAlertViewDelegate>
{
     BlockToRoot _blockToRoot;
}
- (void)sendheartbeatblock:(BlockToRoot)block;
@property (nonatomic,strong) NSTimer *timer;
@end
