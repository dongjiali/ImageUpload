//
//  ;
//  chinalife
//
//  Created by Dong JiaLi on 12-11-28.
//  Copyright (c) 2012年 chinalife. All rights reserved.
//

#import "KeyinputAccessoryView.h"

@implementation KeyinputAccessoryView
@synthesize textField_,itemDone_;
@synthesize textArray_ = textArray_;

- (id)init
{
    if (self = [super init]) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"KeyinputAccessoryView" owner:self options:nil];
        self = [nib objectAtIndex:0];
        count = 0;
        textArray_ = [[NSMutableArray alloc]init];
    }
    return self;
}

- (IBAction)DoneClickEvent:(id)sender
{
    [textField_ resignFirstResponder];
}

- (IBAction)PreviousClick:(id)sender
{
    if (textArray_.count >0) {
        count = [textArray_ indexOfObject:textField_];
        if (count <=0) {
            count = 0;
            [itemPrevious_ setEnabled:YES];
        }else
        {
            count --;
        }
        [((UITextField *)[textArray_ objectAtIndex:count]) becomeFirstResponder];
    }
}

- (IBAction)NextClick:(id)sender
{
    if (textArray_.count >0) {
        count = [textArray_ indexOfObjectIdenticalTo:textField_];
        if (count >= [textArray_ count]-1) {
            count = [textArray_ count]-1;
        }else
        {
            count ++;
        }
        [((UITextField *)[textArray_ objectAtIndex:count]) becomeFirstResponder];
    }
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
    [textField_ release];
    [itemDone_ release];
    [textArray_ release];
    [super dealloc];
}
@end
