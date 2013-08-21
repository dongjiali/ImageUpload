//
//  MyProgressView.h
//  ImageUpload
//
//  Created by Curry on 13-7-17.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularProgressView.h"

@protocol ProgressDelegate <NSObject>
@optional
- (void)CancelHttpRequest;
@end

@interface MyProgressView : UIView
{
    CircularProgressView *ProgressView_;
    UILabel *labeltext;
}
@property (nonatomic,assign) id <ProgressDelegate> delegate;
- (void)startLoading:(NSString *)promptText;
- (void)stopLoading;
@end
