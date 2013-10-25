//
//  TrainViewController.m
//  ImageUpload
//
//  Created by Curry on 13-10-11.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "TrainViewController.h"
#import "OrderRequestViewController.h"
@interface TrainViewController ()
{
    UITextField *usernameText_;
    UITextField *passwordText_;
    UITextField *codeText_;
    UIButton *codeButton_;
    NSString *tempnumber_;
    NSMutableArray *loginParaArray_;
    TrainNetWork *trainNetwork_;
    NSMutableDictionary *loginInfoDic_;
}
@end

@implementation TrainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        loginInfoDic_= [[NSMutableDictionary alloc]init];
        trainNetwork_ = [[TrainNetWork alloc]init];
        trainNetwork_.delegate = self;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //登录
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, DeviceScreenHeight)];
    backImageView.userInteractionEnabled = YES;
    [backImageView setImage:ImageWithName(@"iphone_bac@2x")];
    [self.view addSubview:backImageView];
    [backImageView release];
    
    //tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, 300, 300) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = NO;
    tableView.scrollEnabled = NO;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    [backImageView addSubview:tableView];
    [tableView release];

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setFrame:CGRectMake(20, 270, 280,46)];
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [loginButton setBackgroundImage:ImageWithName(@"login_button_bac@2x") forState:UIControlStateNormal];
    [loginButton setTitleColor:ColorWithRGBA(1, 1, 1, 1) forState:UIControlStateNormal];
    loginButton.titleLabel.shadowColor = ColorWithRGBA(0, 0, 0, 0.5);
    loginButton.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:loginButton];
}

- (void)loginAction
{
    [loginInfoDic_ setObject:@"djl330767040" forKey:@"loginUser.user_name"];
    [loginInfoDic_ setObject:@"Djl330767040" forKey:@"user.password"];
    [loginInfoDic_ setObject:codeText_.text forKey:@"randCode"];
    [trainNetwork_ getlogin:loginInfoDic_];
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
//    int temInt = (int)(arc4random()%9000) + 1000;
//    tempnumber_ = [NSString stringWithFormat:@"%d",temInt];
//    [codeButton_ setTitle:tempnumber_ forState:UIControlStateNormal];
    [trainNetwork_ getlogininit];
}

- (void)resultFailed
{
    OrderRequestViewController *order = [[OrderRequestViewController alloc]init];
    [self.navigationController pushViewController:order animated:YES];
}

- (void)resultDataToUI:(NSData *)resultData
{
    [codeButton_ setBackgroundImage:[UIImage imageWithData:resultData] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
