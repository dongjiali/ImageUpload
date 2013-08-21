//
//  MyProgressView.m
//  ImageUpload
//
//  Created by Curry on 13-7-17.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "MyProgressView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyProgressView
@synthesize delegate = _delegate;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, DeviceScreenWidth, DeviceScreenHeight);
        self.userInteractionEnabled = YES;
        
        UIView *progressview = [[UIView alloc]initWithFrame:CGRectMake(90, 120, 130, 130)];
        progressview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        progressview.layer.cornerRadius = 12.0;
        [self addSubview:progressview];
        [progressview release];
                
        ProgressView_ = [[CircularProgressView alloc] init];
        [progressview addSubview:ProgressView_];
        [ProgressView_ release];
        
        labeltext = [[UILabel alloc]initWithFrame:CGRectMake(0, 95, 130, 20)];
        labeltext.text = @"请稍等...";
        labeltext.textAlignment = NSTextAlignmentCenter;
        labeltext.backgroundColor = [UIColor clearColor];
        labeltext.textColor = [UIColor whiteColor];
        labeltext.font = [UIFont systemFontOfSize:16];
        [progressview addSubview:labeltext];
        [labeltext release];
        
        UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(195, 100, 50, 50)];
        [cancel setImage:ImageWithName(@"cancel_progress@2x") forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancelNetWork) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancel];
        [cancel release];
    }
    return self;
}

- (void)cancelNetWork
{
    [self.delegate CancelHttpRequest];
    [ProgressView_ stop];
    self.hidden = YES;
}

- (void)startLoading:(NSString *)promptText
{
    [labeltext setText:promptText];
    [ProgressView_ start];
    self.hidden = NO;
}
- (void)stopLoading
{
    [ProgressView_ stop];
    self.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)dealloc
{
    [super dealloc];
}

@end
