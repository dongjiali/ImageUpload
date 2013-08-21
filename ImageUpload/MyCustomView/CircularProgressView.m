//
//  CircularProgressView.m
//  ImageUpload
//
//  Created by Curry on 13-7-17.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "CircularProgressView.h"

@implementation CircularProgressView

@synthesize trackTintColor = _trackTintColor;
@synthesize progressTintColor =_progressTintColor;
@synthesize progress = _progress;
@synthesize flag = _flag;
@synthesize timer = _timer;
- (id)init
{
    self = [super initWithFrame:CGRectMake(35.0f, 24.0f, 60.0f, 60.0f)];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.flag = YES;
        self.trackTintColor = [UIColor grayColor];
        self.progressTintColor = [UIColor whiteColor];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)start
{
    if (self.timer.isValid) {
    [self.timer fire];
    }
}

-(void)ShowTimer:(NSTimer *)timer
{
    [self performSelectorOnMainThread:@selector(progressChange) withObject:self waitUntilDone:NO];
}

- (void)stop
{
    if (self.timer.isValid) {
        [self.timer invalidate];
    }
}

- (void)progressChange
{
    self.progress += 0.012;
    if (self.flag) {
        self.trackTintColor = [UIColor grayColor];
        self.progressTintColor = [UIColor whiteColor];
    }
    if (!self.flag) {
        self.trackTintColor = [UIColor whiteColor];
        self.progressTintColor =  [UIColor grayColor];
        if (self.progress > 1.0f)
        {
            self.progress = 0.0f;
            self.flag = YES;
        }
    }
    if (self.progress > 1.0f)
    {
        self.progress = 0.0f;
        self.flag = NO;
    }
}

- (void)drawRect:(CGRect)rect
{
    CGPoint centerPoint = CGPointMake(rect.size.height / 2, rect.size.width / 2);
    CGFloat radius = MIN(rect.size.height, rect.size.width) / 2;
    
    CGFloat pathWidth = radius * 0.3f;
    
    CGFloat radians = DEGREES_2_RADIANS((self.progress*359.9)-90);
    CGFloat xOffset = radius*(1 + 0.85*cosf(radians));
    CGFloat yOffset = radius*(1 + 0.85*sinf(radians));
    CGPoint endPoint = CGPointMake(xOffset, yOffset);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.trackTintColor setFill];
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius-0.5, DEGREES_2_RADIANS(270), DEGREES_2_RADIANS(-90), NO);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(context, trackPath);
    CGContextFillPath(context);
    CGPathRelease(trackPath);
    
    [self.progressTintColor setFill];
    CGMutablePathRef progressPath = CGPathCreateMutable();
    CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), radians, NO);
    CGPathCloseSubpath(progressPath);
    CGContextAddPath(context, progressPath);
    CGContextFillPath(context);
    CGPathRelease(progressPath);
    
    CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x - pathWidth/2, 0, pathWidth, pathWidth));
    CGContextFillPath(context);
    
    CGContextAddEllipseInRect(context, CGRectMake(endPoint.x - pathWidth/2, endPoint.y - pathWidth/2, pathWidth, pathWidth));
    CGContextFillPath(context);
    
    CGContextSetBlendMode(context, kCGBlendModeClear);;
    CGFloat innerRadius = radius * 0.7;
	CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius, centerPoint.y - innerRadius);
	CGContextAddEllipseInRect(context, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius*2, innerRadius*2));
	CGContextFillPath(context);
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [_trackTintColor release];
    [_progressTintColor release];
    [_timer release];
    [super dealloc];
}

@end
