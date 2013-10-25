//
//  LoginViewController.h
//  ImageUpload
//
//  Created by Curry on 13-7-16.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWork.h"
#import "MyProgressView.h"
@interface LoginViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,NetWorkDelegate,ProgressDelegate>
@property (nonatomic,retain)id delegate;
- (id)init:(id)delegate;
@end
