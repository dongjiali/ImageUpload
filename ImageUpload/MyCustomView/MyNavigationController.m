//
//  MyNavigationController.m
//  InsureOnline
//
//  Created by Curry on 13-6-24.
//  Copyright (c) 2013年 sinosoft. All rights reserved.
//


#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

#import "MyNavigationController.h"
#import <QuartzCore/QuartzCore.h>

@interface MyNavigationController ()
{
    CGPoint startTouch;
    
    UIImageView *lastScreenShotView;
    UIImageView *backScreenShotView;
    UIImageView *pushScreenShotView;
    UIView *blackMask;
}

@end

@implementation MyNavigationController
@synthesize recognizer_ = recognizer_;
@synthesize backgroundView = _backgroundView;
@synthesize screenShotsList =  screenShotsList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
        self.canDragBack = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    recognizer_ = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
    [recognizer_ delaysTouchesBegan];
    [self.view addGestureRecognizer:recognizer_];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [screenShotsList addObject:[self capture]];
        
    [super pushViewController:viewController animated:animated];
}




- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
//    [self.screenShotsList removeLastObject];
    [self creatbackview];
    if (!_isMoving) {
        [self addpopbackview];
        [UIView animateWithDuration:0.4 animations:^{
            [self popViewWithX:320];
        } completion:^(BOOL finished) {
            CGRect frame = self.view.frame;
            frame.origin.x = 0;
            self.view.frame = frame;
            self.view.hidden = NO;
            _isMoving = NO;
            [backScreenShotView removeFromSuperview];
            backScreenShotView = nil;
        }];
        [screenShotsList removeLastObject];
    }
    [screenShotsList removeLastObject];
    return [super popViewControllerAnimated:animated];
}

- (void)addpopbackview
{
    [screenShotsList addObject:[self capture]];
    self.backgroundView.hidden = NO;
    if (backScreenShotView == nil) {
        [backScreenShotView removeFromSuperview];
        backScreenShotView = nil;
    }
    UIImage *backScreenShot = [screenShotsList lastObject];
    backScreenShotView = [[UIImageView alloc]initWithImage:backScreenShot];
    [self.backgroundView insertSubview:backScreenShotView aboveSubview:blackMask];
    [backScreenShotView release];
}

- (void)pushViewWithX:(float)x
{
    CGRect frame = pushScreenShotView.frame;
    frame.origin.x = x;
    pushScreenShotView.frame = frame;
    self.view.hidden = YES;
    ((UIView *)[screenShotsList lastObject]).transform = CGAffineTransformMakeScale(0, 0);
    ((UIView *)[screenShotsList lastObject]).alpha = 1;
}

- (void)popViewWithX:(float)x
{
    CGRect frame = backScreenShotView.frame;
    frame.origin.x = x;
    backScreenShotView.frame = frame;
    self.view.hidden = YES;
    lastScreenShotView.transform = CGAffineTransformMakeScale(1, 1);
    blackMask.alpha = 0;
}

- (void)creatbackview
{
    if (!self.backgroundView)
    {
        CGRect frame = self.view.frame;
        
        self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
        
        blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        blackMask.backgroundColor = [UIColor blackColor];
        [self.backgroundView addSubview:blackMask];
        [blackMask release];
    }
    
    self.backgroundView.hidden = NO;
    
    if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
    
    UIImage *lastScreenShot = [screenShotsList lastObject];
    lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
    [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
    lastScreenShotView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    blackMask.alpha = 1;
}

#pragma mark - Utility Methods -

// get the current view screen shot
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


- (void)moveViewWithX:(float)x
{
    x = x>320?320:x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float scale = (x/6400)+0.95;
    float alpha = 0.4 - (x/800);
    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
    
}

#pragma mark - Gesture Recognizer -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        startTouch = touchPoint;
        [self creatbackview];
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:320];
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
//                recognizer_.enabled = NO;
                _isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}

- (void)dealloc
{
    [screenShotsList release];
    [recognizer_ release];
    [_backgroundView release];
    [lastScreenShotView release];
    [super dealloc];
}

@end
