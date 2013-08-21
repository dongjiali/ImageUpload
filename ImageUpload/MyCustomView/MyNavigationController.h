//
//  MyNavigationController.h
//  InsureOnline
//
//  Created by Curry on 13-6-24.
//  Copyright (c) 2013年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavigationController : UINavigationController
{
    NSMutableArray *screenShotsList;
    UIPanGestureRecognizer *recognizer_;
}
@property (nonatomic,assign) BOOL canDragBack;
@property (nonatomic,assign) BOOL isMoving;
@property (nonatomic,retain) UIPanGestureRecognizer *recognizer_;
@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;
@end
