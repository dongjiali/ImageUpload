//
//  KeyinputAccessoryView.h
//  chinalife
//
//  Created by Dong JiaLi on 12-11-28.
//  Copyright (c) 2012年 chinalife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyinputAccessoryView : UIToolbar
{
    IBOutlet UIBarButtonItem *itemDone_;
    IBOutlet UIBarButtonItem *itemPrevious_;
    IBOutlet UIBarButtonItem *itemNext_;
    UITextField *textField_;
    NSMutableArray *textArray_;
    int count;
}
@property (nonatomic,retain)  UITextField *textField_;
@property (nonatomic,retain)  NSMutableArray *textArray_;
@property (nonatomic,retain)  IBOutlet UIBarButtonItem *itemDone_;
@end
