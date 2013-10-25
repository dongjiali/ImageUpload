//
//  SettingViewController.m
//  ImageUpload
//
//  Created by Curry on 13-7-24.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "SettingViewController.h"
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define TIPSLABEL_TAG 10086
#import "WXApi.h"
@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize delegate = _delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init:(id)delegate
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"设  置";
    
    int width = [[UIScreen mainScreen] bounds].size.width;
    int height = [[UIScreen mainScreen] bounds].size.height;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 135)];
    [headView setBackgroundColor:RGBCOLOR(0xe1, 0xe0, 0xde)];
    UIImage *image = [UIImage imageNamed:@"micro_messenger.png"];
    NSInteger tlx = (headView.frame.size.width -  image.size.width) / 2;
    NSInteger tly = 20;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(tlx, tly, image.size.width, image.size.height)];
    [imageView setImage:image];
    [headView addSubview:imageView];
    [imageView release];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, tly + image.size.height, width, 40)];
    [title setText:@"微信OpenAPI Sample Demo"];
    title.font = [UIFont systemFontOfSize:17];
    title.textColor = RGBCOLOR(0x11, 0x11, 0x11);
    title.textAlignment = UITextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    [headView addSubview:title];
    [title release];
    
    [self.view addSubview:headView];
    [headView release];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height, width, 1)];
    lineView1.backgroundColor = [UIColor blackColor];
    lineView1.alpha = 0.1f;
    [self.view addSubview:lineView1];
    [lineView1 release];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, headView.frame.size.height + 1, width, 1)];
    lineView2.backgroundColor = [UIColor whiteColor];
    lineView2.alpha = 0.25f;
    [self.view addSubview:lineView2];
    [lineView2 release];
    
    UIView *sceceView = [[UIView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height + 2, width, 100)];
    [sceceView setBackgroundColor:RGBCOLOR(0xef, 0xef, 0xef)];
    
    UILabel *tips = [[UILabel alloc]init];
    tips.tag = TIPSLABEL_TAG;
    tips.text = @"分享场景:会话";
    tips.textColor = [UIColor blackColor];
    tips.backgroundColor = [UIColor clearColor];
    tips.textAlignment = UITextAlignmentLeft;
    tips.frame = CGRectMake(10, 5, 200, 40);
    [sceceView addSubview:tips];
    [tips release];
    
    UIButton *btn_x = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_x setTitle:@"会话" forState:UIControlStateNormal];
    btn_x.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn_x setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_x setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btn_x setFrame:CGRectMake(20, 50, 80, 40)];
    [btn_x addTarget:self action:@selector(onSelectSessionScene) forControlEvents:UIControlEventTouchUpInside];
    [sceceView addSubview:btn_x];
    
    UIButton *btn_y = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_y setTitle:@"朋友圈" forState:UIControlStateNormal];
    btn_y.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn_y setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_y setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btn_y setFrame:CGRectMake(120, 50, 80, 40)];
    [btn_y addTarget:self action:@selector(onSelectTimelineScene) forControlEvents:UIControlEventTouchUpInside];
    [sceceView addSubview:btn_y];
    
    UIButton *btn_z = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_z setTitle:@"收藏" forState:UIControlStateNormal];
    btn_z.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn_z setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_z setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btn_z setFrame:CGRectMake(220, 50, 80, 40)];
    [btn_z addTarget:self action:@selector(onSelectFavoriteScene) forControlEvents:UIControlEventTouchUpInside];
    [sceceView addSubview:btn_z];
    
    [self.view addSubview:sceceView];
    [sceceView release];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height + 2 + sceceView.frame.size.height, width, 1)];
    lineView3.backgroundColor = [UIColor blackColor];
    lineView3.alpha = 0.1f;
    [self.view addSubview:lineView3];
    [lineView3 release];
    
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0, headView.frame.size.height + 2 + sceceView.frame.size.height + 1, width, 1)];
    lineView4.backgroundColor = [UIColor whiteColor];
    lineView4.alpha = 0.25f;
    [self.view addSubview:lineView4];
    [lineView4 release];
    
    UIScrollView *footView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headView.frame.size.height + 2 + sceceView.frame.size.height + 2, width, height - headView.frame.size.height - 2 - sceceView.frame.size.height - 2)];
    [footView setBackgroundColor:RGBCOLOR(0xef, 0xef, 0xef)];
    footView.contentSize = CGSizeMake(width, height);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"发送Text消息给微信" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(10, 10, 145, 40)];
    [btn addTarget:self.delegate action:@selector(sendTextContent) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setTitle:@"发送Photo消息给微信" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(165, 10, 145, 40)];
    [btn2 addTarget:self.delegate action:@selector(sendImageContent) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn3 setTitle:@"发送Link消息给微信" forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setFrame:CGRectMake(10, 65, 145, 40)];
    [btn3 addTarget:self.delegate action:@selector(sendLinkContent) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn4 setTitle:@"发送Music消息给微信" forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn4 setFrame:CGRectMake(165, 65, 145, 40)];
    [btn4 addTarget:self.delegate action:@selector(sendMusicContent) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn5 setTitle:@"发送Video消息给微信" forState:UIControlStateNormal];
    btn5.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn5 setFrame:CGRectMake(10, 120, 145, 40)];
    [btn5 addTarget:self.delegate action:@selector(sendVideoContent) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn5];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn6 setTitle:@"发送App消息给微信" forState:UIControlStateNormal];
    btn6.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn6 setFrame:CGRectMake(165, 120, 145, 40)];
    [btn6 addTarget:self.delegate action:@selector(sendAppContent) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn6];
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn7 setTitle:@"发送非gif表情给微信" forState:UIControlStateNormal];
    btn7.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn7 setFrame:CGRectMake(10, 175, 145, 40)];
    [btn7 addTarget:self.delegate action:@selector(sendNonGifContent) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn7];
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn8 setTitle:@"发送gif表情给微信" forState:UIControlStateNormal];
    btn8.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn8 setFrame:CGRectMake(165, 175, 145, 40)];
    [btn8 addTarget:self.delegate action:@selector(sendGifContent) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn8];
    
    UIButton *btn9 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn9 setTitle:@"发送文件消息给微信" forState:UIControlStateNormal];
    btn9.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn9 setFrame:CGRectMake(10, 230, 145, 40)];
    [btn9 addTarget:self.delegate action:@selector(sendFileContent) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn9];
    
    [self.view addSubview:footView];
    [footView release];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setFrame:CGRectMake(20,75, 280,46)];
    [loginButton setTitle:@"注   销" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [loginButton setBackgroundImage:ImageWithName(@"login_button_bac@2x") forState:UIControlStateNormal];
    [loginButton setTitleColor:ColorWithRGBA(1, 1, 1, 1) forState:UIControlStateNormal];
    loginButton.titleLabel.shadowColor = ColorWithRGBA(0, 0, 0, 0.5);
    loginButton.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [loginButton addTarget:self action:@selector(CancellationloginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];

}

- (void)onSelectSessionScene{
    [self.delegate changeScene:WXSceneSession];
    
    UILabel *tips = (UILabel *)[self.view viewWithTag:TIPSLABEL_TAG];
    tips.text = @"分享场景:会话";
}

- (void)onSelectTimelineScene{
    [self.delegate changeScene:WXSceneTimeline];
    
    UILabel *tips = (UILabel *)[self.view viewWithTag:TIPSLABEL_TAG];
    tips.text = @"分享场景:朋友圈";
}

- (void)onSelectFavoriteScene{
    [self.delegate changeScene:WXSceneFavorite];
    
    UILabel *tips = (UILabel *)[self.view viewWithTag:TIPSLABEL_TAG];
    tips.text = @"分享场景:收藏";
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

- (void)dealloc
{
    [_delegate release];
    [super dealloc];
}
@end
