//
//  SettingViewController.m
//  ImageUpload
//
//  Created by Curry on 13-7-24.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"设  置";
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setFrame:CGRectMake(20,190, 280,46)];
    [loginButton setTitle:@"注   销" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [loginButton setBackgroundImage:ImageWithName(@"login_button_bac@2x") forState:UIControlStateNormal];
    [loginButton setTitleColor:ColorWithRGBA(1, 1, 1, 1) forState:UIControlStateNormal];
    loginButton.titleLabel.shadowColor = ColorWithRGBA(0, 0, 0, 0.5);
    loginButton.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [loginButton addTarget:self action:@selector(CancellationloginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (void)CancellationloginAction
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:LOGINFLAG];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:USERNAME];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:PASSWORD];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
