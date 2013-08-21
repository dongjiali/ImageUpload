//
//  CircularProgressView.h
//  ImageUpload
//
//  Created by Curry on 13-7-17.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularProgressView : UIView
@property(nonatomic,assign)BOOL flag;
@property(nonatomic, strong) UIColor *trackTintColor;
@property(nonatomic, strong) UIColor *progressTintColor;
@property(nonatomic) float progress;
@property(nonatomic,retain)NSTimer *timer;
- (void)stop;
- (void)start;
@end
