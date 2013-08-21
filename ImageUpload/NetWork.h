//
//  NetWork.h
//  ImageUpload
//
//  Created by Curry on 13-7-16.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@protocol NetWorkDelegate <NSObject>
@optional
- (void)resultDataToUI:(NSString *)resultData;
- (void)resultFailed;
@end

@interface NetWork : NSObject<ASIHTTPRequestDelegate>

@property (nonatomic,retain) ASIFormDataRequest *asiFormDataRequest;
@property (nonatomic,assign) id <NetWorkDelegate> delegate;
- (void)stopHttpRequest;
- (void)startHttpRequest:(NSMutableArray *)userInfoArray;
- (void)upLoadSalesBigImage:(NSString *)imagepath imageinfo:(NSMutableArray *)imageinfoarray;
@end
