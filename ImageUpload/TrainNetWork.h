//
//  TrainNetWork.h
//  ImageUpload
//
//  Created by Curry on 13-10-11.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Base64_Encode_Decode.h"
#import "GDataXMLNode.h"
#import "Xml_Perser.h"
@protocol NetWorkDelegate <NSObject>
@optional
- (void)resultDataToUI:(NSData *)resultData;
- (void)resultFailed;
- (void)resultDataOrdeinfo:(NSString *)string;
@end
@interface TrainNetWork : NSObject<ASIHTTPRequestDelegate>
@property (nonatomic,assign) id <NetWorkDelegate> delegate;
@property (nonatomic,retain) NSMutableDictionary *longinDic;
@property (nonatomic,retain) ASIFormDataRequest *asiFormDataRequest;
- (void)getlogininit;
- (void)getloginrand;
- (void)getlogin:(NSMutableDictionary *)loginDic;
- (void)selecttrain:(NSMutableDictionary *)traininfo;
- (void)gettraininfos:(NSMutableDictionary *)traininfo;
- (void)orderrequestpost:(NSMutableDictionary *)orderDic;
@end
