//
//  OrderRequestViewController.m
//  ImageUpload
//
//  Created by Curry on 13-10-14.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "OrderRequestViewController.h"

@interface OrderRequestViewController ()
{
    UITextField *train_dateText_;
    UITextField *from_station_telecodeText_;
    UITextField *to_station_telecodeText_;
    UITextField *train_noText_;
    UITextField *trainPassTypeText_;
    UITextField *trainClassText_;
    UIButton *codeButton_;
    NSString *tempnumber_;
    NSMutableArray *loginParaArray_;
    TrainNetWork *trainNetwork_;
    NSMutableDictionary *loginInfoDic_;
    NSMutableDictionary *orderInfo_;
}
@end

@implementation OrderRequestViewController

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
    loginInfoDic_ = [[NSMutableDictionary alloc]init];
    orderInfo_ = [[NSMutableDictionary alloc]init];
    trainNetwork_ = [[TrainNetWork alloc]init];
    trainNetwork_.delegate = self;
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor redColor];
    //登录
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, DeviceScreenHeight)];
    backImageView.userInteractionEnabled = YES;
    [backImageView setImage:ImageWithName(@"iphone_bac@2x")];
    [self.view addSubview:backImageView];
    [backImageView release];
    
    //tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, 300, 400) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = NO;
    tableView.scrollEnabled = NO;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    [backImageView addSubview:tableView];
    [tableView release];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setFrame:CGRectMake(20, 370, 280,46)];
    [loginButton setTitle:@"订 票" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [loginButton setBackgroundImage:ImageWithName(@"login_button_bac@2x") forState:UIControlStateNormal];
    [loginButton setTitleColor:ColorWithRGBA(1, 1, 1, 1) forState:UIControlStateNormal];
    loginButton.titleLabel.shadowColor = ColorWithRGBA(0, 0, 0, 0.5);
    loginButton.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:loginButton];
    
    [self trainstation:@"哈尔滨"];
}

- (void)resultDataOrdeinfo:(NSString *)string
{
    NSLog(@"%@string =",string);
    NSArray *array = [string componentsSeparatedByString:@"#"];
    if (array.count >0) {
        [orderInfo_ setObject:[array objectAtIndex:0] forKey:@"station_train_code"];
        [orderInfo_ setObject:@"2013-10-15" forKey:@"train_date"];
        [orderInfo_ setObject:@"K#" forKey:@"train_class_arr"];
        [orderInfo_ setObject:[array objectAtIndex:1] forKey:@"lishi"];
        [orderInfo_ setObject:[array objectAtIndex:2] forKey:@"train_start_time"];
        [orderInfo_ setObject:[array objectAtIndex:3] forKey:@"trainno4"];
        [orderInfo_ setObject:[array objectAtIndex:4] forKey:@"from_station_telecode"];
        [orderInfo_ setObject:[array objectAtIndex:5] forKey:@"to_station_telecode"];
        [orderInfo_ setObject:[array objectAtIndex:6] forKey:@"arrive_time"];
        [orderInfo_ setObject:[array objectAtIndex:7] forKey:@"from_station_name"];
        [orderInfo_ setObject:[array objectAtIndex:8] forKey:@"to_station_name"];
        [orderInfo_ setObject:[array objectAtIndex:9] forKey:@"from_station_no"];
        [orderInfo_ setObject:[array objectAtIndex:10] forKey:@"to_station_no"];
        [orderInfo_ setObject:[array objectAtIndex:11] forKey:@"ypInfoDetail"];
        [orderInfo_ setObject:[array objectAtIndex:12] forKey:@"mmStr"];
        [orderInfo_ setObject:[array objectAtIndex:13] forKey:@"locationCode"];
    }
    [trainNetwork_ orderrequestpost:orderInfo_];
}

- (NSString *)trainstation:(NSString *)stationStr
{
    NSString *urlpath = [[NSBundle mainBundle] pathForResource:@"station" ofType:@"txt"];
    NSString *station = [NSString stringWithContentsOfFile:urlpath encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [station componentsSeparatedByString:@"@"];
    for (NSString *string in array) {
        NSRange range = [string rangeOfString:[NSString stringWithFormat:@"|%@|",stationStr]];
        if (range.location != NSNotFound)
        {
            NSLog(@"%@",string);
            return string;
        }
    }
    return nil;
}

- (void)loginAction
{
    [loginInfoDic_ setObject:@"2013-10-15" forKey:@"orderRequest.train_date"];
    [loginInfoDic_ setObject:@"BJP" forKey:@"orderRequest.from_station_telecode"];
    [loginInfoDic_ setObject:@"HBB" forKey:@"orderRequest.to_station_telecode"];
    [loginInfoDic_ setObject:@"K39" forKey:@"orderRequest.train_no"];
    [loginInfoDic_ setObject:@"K#" forKey:@"trainClass"];
    [trainNetwork_ gettraininfos:loginInfoDic_];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"a"]autorelease];
    int row = indexPath.row;
    NSString *celllabel = nil;
    switch (row) {
        case 0:
        {
            celllabel = @"日    期:";
            train_dateText_ = [[UITextField alloc] initWithFrame:CGRectMake(77, 2, 210, 40)];
            train_dateText_.placeholder = @"手机号/邮箱/用户名";
            train_dateText_.font = [UIFont systemFontOfSize:16.0];
            [train_dateText_ setKeyboardType:UIKeyboardTypeASCIICapable];
            train_dateText_.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1];
            [train_dateText_ setContentVerticalAlignment:0];
            train_dateText_.userInteractionEnabled = YES;
            train_dateText_.clearButtonMode = YES;
            train_dateText_.delegate = self;
            NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:USERNAME];
            train_dateText_.text = userName;
            train_dateText_.tag = 1;
            train_dateText_.backgroundColor = [UIColor clearColor];
            [cell addSubview:train_dateText_];
            [train_dateText_ release];
            
        }
            break;
        case 1:
        {
            celllabel = @"发    站:";
            from_station_telecodeText_ = [[UITextField alloc] initWithFrame:CGRectMake(77, 2, 210, 40)];
            from_station_telecodeText_.placeholder = @"必填";
            [from_station_telecodeText_ setContentVerticalAlignment:0];
            [from_station_telecodeText_ setKeyboardType:UIKeyboardTypeASCIICapable];
            from_station_telecodeText_.font = [UIFont systemFontOfSize:16.0];
            from_station_telecodeText_.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1];
            from_station_telecodeText_.userInteractionEnabled = YES;
            from_station_telecodeText_.clearButtonMode = YES;
            NSString *passWord = [[NSUserDefaults standardUserDefaults] valueForKey:PASSWORD];
            from_station_telecodeText_.text = passWord;
            [from_station_telecodeText_ setSecureTextEntry:YES];
            from_station_telecodeText_.delegate = self;
            from_station_telecodeText_.tag = 2;
            from_station_telecodeText_.backgroundColor = [UIColor clearColor];
            [cell addSubview:from_station_telecodeText_];
            [from_station_telecodeText_ release];
        }
            break;
        case 2:
        {
            celllabel = @"到    站:";
            to_station_telecodeText_ = [[UITextField alloc] initWithFrame:CGRectMake(77, 2, 210, 40)];
            to_station_telecodeText_.placeholder = @"必填";
            [to_station_telecodeText_ setContentVerticalAlignment:0];
            [to_station_telecodeText_ setKeyboardType:UIKeyboardTypeASCIICapable];
            to_station_telecodeText_.font = [UIFont systemFontOfSize:16.0];
            to_station_telecodeText_.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1];
            to_station_telecodeText_.userInteractionEnabled = YES;
            to_station_telecodeText_.clearButtonMode = YES;
            NSString *passWord = [[NSUserDefaults standardUserDefaults] valueForKey:PASSWORD];
            to_station_telecodeText_.text = passWord;
            [to_station_telecodeText_ setSecureTextEntry:YES];
            to_station_telecodeText_.delegate = self;
            to_station_telecodeText_.tag = 3;
            to_station_telecodeText_.backgroundColor = [UIColor clearColor];
            [cell addSubview:to_station_telecodeText_];
            [to_station_telecodeText_ release];
        }
            break;
        case 3:
        {
            celllabel = @"车    次:";
            train_noText_ = [[UITextField alloc] initWithFrame:CGRectMake(77, 2, 210, 40)];
            train_noText_.placeholder = @"必填";
            [train_noText_ setContentVerticalAlignment:0];
            [train_noText_ setKeyboardType:UIKeyboardTypeASCIICapable];
            train_noText_.font = [UIFont systemFontOfSize:16.0];
            train_noText_.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1];
            train_noText_.userInteractionEnabled = YES;
            train_noText_.clearButtonMode = YES;
            NSString *passWord = [[NSUserDefaults standardUserDefaults] valueForKey:PASSWORD];
            train_noText_.text = passWord;
            [train_noText_ setSecureTextEntry:YES];
            train_noText_.delegate = self;
            train_noText_.tag = 4;
            train_noText_.backgroundColor = [UIColor clearColor];
            [cell addSubview:train_noText_];
            [train_noText_ release];
        }
            break;
        case 4:
        {
            celllabel = @"车    类:";
            trainClassText_ = [[UITextField alloc] initWithFrame:CGRectMake(77, 2, 210, 40)];
            trainClassText_.placeholder = @"必填";
            [trainClassText_ setContentVerticalAlignment:0];
            [trainClassText_ setKeyboardType:UIKeyboardTypeASCIICapable];
            trainClassText_.font = [UIFont systemFontOfSize:16.0];
            trainClassText_.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1];
            trainClassText_.userInteractionEnabled = YES;
            trainClassText_.clearButtonMode = YES;
            NSString *passWord = [[NSUserDefaults standardUserDefaults] valueForKey:PASSWORD];
            trainClassText_.text = passWord;
            [trainClassText_ setSecureTextEntry:YES];
            trainClassText_.delegate = self;
            trainClassText_.tag = 5;
            trainClassText_.backgroundColor = [UIColor clearColor];
            [cell addSubview:trainClassText_];
            [trainClassText_ release];
        }
            break;
        case 5:
//        {
//            celllabel = @"验证码:";
//            to_station_telecodeText_ = [[UITextField alloc] initWithFrame:CGRectMake(77, 2, 145, 40)];
//            to_station_telecodeText_.font = [UIFont systemFontOfSize:16.0];
//            [to_station_telecodeText_ setContentVerticalAlignment:0];
//            [to_station_telecodeText_ setKeyboardType:UIKeyboardTypeASCIICapable];
//            to_station_telecodeText_.textColor = [UIColor colorWithRed:103.0/255.0 green:103.0/255.0 blue:103.0/255.0 alpha:1];
//            to_station_telecodeText_.placeholder = @"必填";
//            to_station_telecodeText_.userInteractionEnabled = YES;
//            to_station_telecodeText_.clearButtonMode = YES;
//            to_station_telecodeText_.delegate = self;
//            to_station_telecodeText_.tag = 3;
//            
//            to_station_telecodeText_.backgroundColor = [UIColor clearColor];
//            [cell addSubview:to_station_telecodeText_];
//            [to_station_telecodeText_ release];
//            
//            codeButton_ = [[UIButton alloc] initWithFrame:CGRectMake(225, 5, 60, 30)];
//            [self refreshCode];
//            [codeButton_ setBackgroundColor:[UIColor grayColor]];
//            codeButton_.layer.cornerRadius = 6;
//            codeButton_.titleLabel.font = [UIFont systemFontOfSize:14.0];
//            [codeButton_ addTarget:self action:@selector(refreshCode) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:codeButton_];
//            [codeButton_ release];
//        }
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
