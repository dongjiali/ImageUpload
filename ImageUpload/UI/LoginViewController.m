//
//  LoginViewController.m
//  ImageUpload
//
//  Created by Curry on 13-7-16.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "KeyinputAccessoryView.h"
#import "NSString+NSstringChange.h"
#import "NetWork.h"
#import "MyProgressView.h"
#import "CenterViewController.h"
#import "SaveScaledImage.h"
#import "SendHeartbeat.h"
@interface LoginViewController ()
{
    UITextField *usernameText_;
    UITextField *passwordText_;
    UITextField *codeText_;
    UIButton *codeButton_;
    NSString *tempnumber_;
    NSMutableArray *loginParaArray_;
    NetWork *netWork_;
    KeyinputAccessoryView *toolbarkey_;
    MyProgressView *progressview_;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    [self.navigationItem setTitle:@"登  录"];
    toolbarkey_ = [[KeyinputAccessoryView alloc]init];
    netWork_ = [[NetWork alloc]init];
    loginParaArray_ = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航条
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //隐藏导航条
    self.navigationController.navigationBar.hidden = YES;
    //登录
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, DeviceScreenHeight)];
    backImageView.userInteractionEnabled = YES;
    [backImageView setImage:ImageWithName(@"iphone_bac@2x")];
    [self.view addSubview:backImageView];
    [backImageView release];
        
    //tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, 300, 145) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = NO;
    tableView.scrollEnabled = NO;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    [backImageView addSubview:tableView];
    [tableView release];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setFrame:CGRectMake(20,190, 280,46)];
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [loginButton setBackgroundImage:ImageWithName(@"login_button_bac@2x") forState:UIControlStateNormal];
    [loginButton setTitleColor:ColorWithRGBA(1, 1, 1, 1) forState:UIControlStateNormal];
    loginButton.titleLabel.shadowColor = ColorWithRGBA(0, 0, 0, 0.5);
    loginButton.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:loginButton];
    
    //添加找回密码和找回用户名功能
    [self adduserandfindButton:backImageView];
}

-(void)adduserandfindButton:(UIView *)view
{
    UIImageView *resetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 410, 280, 46)];
    resetImageView.userInteractionEnabled = YES;
    [resetImageView setImage:ImageWithName(@"login_reset_bac@2x")];
    [view addSubview:resetImageView];
    [resetImageView release];
    
    UIColor *selectColor = ColorWithRGBA(154, 156, 158, 1);
    UIColor *unSelectColor = ColorWithRGBA(51, 51, 51, 1);
    UIImage *unselectImag = ImageWithName(@"login_click_before@2x");
    UIImage *selectImag = ImageWithName(@"login_click_after@2x");
    //找回用户名按钮
    UIButton *usernameButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 7, 132, 30)];
    usernameButton.userInteractionEnabled = YES;
    [usernameButton setTitle:@"注   册" forState:UIControlStateNormal];
    [usernameButton setBackgroundImage:unselectImag forState:UIControlStateNormal];
    [usernameButton setBackgroundImage:selectImag forState:UIControlEventTouchDown];
    [usernameButton setTitleColor:unSelectColor forState:UIControlStateNormal];
    [usernameButton setTitleColor:selectColor forState:UIControlEventTouchDown];
    [usernameButton addTarget:self action:@selector(findeUserNameAction) forControlEvents:UIControlEventTouchUpInside];
    [resetImageView addSubview:usernameButton];
    [usernameButton release];
    
    //忘记密码按钮
    UIButton *findpasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 7, 132, 30)];
    findpasswordButton.userInteractionEnabled = YES;
    [findpasswordButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [findpasswordButton setBackgroundImage:unselectImag forState:UIControlStateNormal];
    [findpasswordButton setBackgroundImage:selectImag forState:UIControlEventTouchDown];
    [findpasswordButton setTitleColor:unSelectColor forState:UIControlStateNormal];
    [findpasswordButton setTitleColor:selectColor forState:UIControlEventTouchDown];
    [findpasswordButton addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    [resetImageView addSubview:findpasswordButton];
    [findpasswordButton release];
}

- (void)findeUserNameAction
{
    UIImage *imagea = ImageWithName(@"iphone_bac");
    NSLog(@"width = %f,hetght = %f",imagea.size.width, imagea.size.height);
   UIImage *image = [SaveScaledImage imageWithImageSimple:imagea];
    [SaveScaledImage saveImage:image WithName:@"wocaonima"];
    NSString *imagepath = [DocumentsDirectory stringByAppendingPathComponent:@"wocaonima"];
    NSLog(@"%@",imagepath);
//    [netWork_  upLoadSalesBigImage:imagepath MidImage:imagepath SmallImage:imagepath];
}

- (void)forgetPasswordAction
{

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"a"]autorelease];
    int row = indexPath.row;
    NSString *celllabel = nil;
    switch (row) {
        case 0:
        {
            celllabel = @"登录名:";
            usernameText_ = [[UITextField alloc] initWithFrame:CGRectMake(77, 2, 210, 40)];
            usernameText_.placeholder = @"手机号/邮箱/用户名";
            usernameText_.font = [UIFont systemFontOfSize:16.0];
            [usernameText_ setKeyboardType:UIKeyboardTypeASCIICapable];
            usernameText_.inputAccessoryView = toolbarkey_;
            toolbarkey_.textField_ = usernameText_;
            [toolbarkey_.textArray_ addObject:usernameText_];
            usernameText_.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1];
            [usernameText_ setContentVerticalAlignment:0];
            usernameText_.userInteractionEnabled = YES;
            usernameText_.clearButtonMode = YES;
            usernameText_.delegate = self;
            NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:USERNAME];
            usernameText_.text = userName;
            usernameText_.tag = 1;
            usernameText_.backgroundColor = [UIColor clearColor];
            [cell addSubview:usernameText_];
            [usernameText_ release];
            
        }
            break;
        case 1:
        {
            celllabel = @"密   码:";            
            passwordText_ = [[UITextField alloc] initWithFrame:CGRectMake(77, 2, 210, 40)];
            passwordText_.placeholder = @"必填";
            [passwordText_ setContentVerticalAlignment:0];
            [passwordText_ setKeyboardType:UIKeyboardTypeASCIICapable];
            passwordText_.font = [UIFont systemFontOfSize:16.0];
            passwordText_.inputAccessoryView = toolbarkey_;
            toolbarkey_.textField_ = passwordText_;
            [toolbarkey_.textArray_ addObject:passwordText_];
            passwordText_.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1];
            passwordText_.userInteractionEnabled = YES;
            passwordText_.clearButtonMode = YES;
            NSString *passWord = [[NSUserDefaults standardUserDefaults] valueForKey:PASSWORD];
            passwordText_.text = passWord;
            [passwordText_ setSecureTextEntry:YES];
            passwordText_.delegate = self;
            passwordText_.tag = 2;
            passwordText_.backgroundColor = [UIColor clearColor];
            [cell addSubview:passwordText_];
            [passwordText_ release];
        }
            break;
        case 2:
        {
            celllabel = @"验证码:";
            codeText_ = [[UITextField alloc] initWithFrame:CGRectMake(77, 2, 145, 40)];
            codeText_.font = [UIFont systemFontOfSize:16.0];
            [codeText_ setContentVerticalAlignment:0];
            [codeText_ setKeyboardType:UIKeyboardTypeASCIICapable];
            codeText_.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1];
            codeText_.inputAccessoryView = toolbarkey_;
            toolbarkey_.textField_ = codeText_;
            [toolbarkey_.textArray_ addObject:codeText_];
            codeText_.placeholder = @"必填";
            codeText_.userInteractionEnabled = YES;
            codeText_.clearButtonMode = YES;
            codeText_.delegate = self;
            codeText_.tag = 3;
            
            codeText_.backgroundColor = [UIColor clearColor];
            [cell addSubview:codeText_];
            [codeText_ release];

            codeButton_ = [[UIButton alloc] initWithFrame:CGRectMake(225, 5, 60, 30)];
            [self refreshCode];
            [codeButton_ setBackgroundColor:[UIColor grayColor]];
            codeButton_.layer.cornerRadius = 6;
            codeButton_.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [codeButton_ addTarget:self action:@selector(refreshCode) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:codeButton_];
            [codeButton_ release];
        }
            break;
        default:
        {
            
        }
            break;
    }
    cell.textLabel.text = celllabel;
    cell.textLabel.textColor = ColorWithRGBA(51, 51, 51, 1);
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    
}

//获取验证码
- (void) refreshCode
{
    int temInt = (int)(arc4random()%9000) + 1000;
    tempnumber_ = [NSString stringWithFormat:@"%d",temInt];
    [codeButton_ setTitle:tempnumber_ forState:UIControlStateNormal];
}

//登陆事件
- (void) loginAction
{
    [self recoverKeyboard];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0, 0, 320, 420);
    [UIView commitAnimations];
    if (![self loginCheck])
    {
        return;
    }
    
    if ([self loginCheck] && [[codeText_.text uppercaseString] isEqualToString:tempnumber_])
    {
        //添加进度条
        progressview_ = [[MyProgressView alloc]init];
        progressview_.delegate = self;
        [self.view addSubview:progressview_];
        [progressview_ startLoading:@"登录中,请稍等..."];
        [progressview_ release];
        //调用网络
        [loginParaArray_ removeAllObjects];
        [loginParaArray_ addObject:usernameText_.text];
        [loginParaArray_ addObject:passwordText_.text];
        [netWork_ setDelegate:self];
        [netWork_ startHttpRequest:loginParaArray_];
    }
    else
    {
        [[[iToast makeText:NSLocalizedString(@"验证码错误!", nil)] setGravity:iToastGravityCenter] show];
    }
}

- (void)CancelHttpRequest
{
    [netWork_ stopHttpRequest];
}

- (void)resultFailed
{
    NSLog(@"收到");
    if (progressview_) {
        [progressview_ stopLoading];
    }
}

- (void)resultDataToUI:(NSString *)resultData
{
    NSLog(@"收到");
    if (progressview_) {
        [progressview_ stopLoading];
    }
    CenterViewController *center = [[CenterViewController alloc]init];
    [self.navigationController pushViewController:center animated:YES];
    [[NSUserDefaults standardUserDefaults] setValue:usernameText_.text forKey:USERNAME];
    [[NSUserDefaults standardUserDefaults] setValue:passwordText_.text forKey:PASSWORD];
}

- (Boolean) loginCheck
{
    if ([NSString isNullOrEmpty:usernameText_.text])
    {
        [[[iToast makeText:NSLocalizedString(@"登录名不能为空!", nil)] setGravity:iToastGravityCenter] show];
        return NO;
    }
    if ([NSString isNullOrEmpty: passwordText_.text ])
    {
        [[[iToast makeText:NSLocalizedString(@"密码不能为空!", nil)] setGravity:iToastGravityCenter] show];
        return NO;
    }
    if ([NSString isNullOrEmpty: codeText_.text ])
    {
        [[[iToast makeText:NSLocalizedString(@"验证码不能为空!", nil)] setGravity:iToastGravityCenter] show];
        return NO;
    }
    return YES;
}


//键盘返回键触发收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self recoverKeyboard];
    return YES;
}

//点击键触发收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self recoverKeyboard];
}

//收键盘
-(void)recoverKeyboard
{
    [usernameText_ resignFirstResponder];
    [passwordText_ resignFirstResponder];
    [codeText_ resignFirstResponder];
}

//赋值键盘移动
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    toolbarkey_.textField_ = textField;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (progressview_) {
        [progressview_ stopLoading];
        [progressview_ removeFromSuperview];
    }
    [netWork_ release];
    [toolbarkey_ release];
    [super dealloc];
}

@end
