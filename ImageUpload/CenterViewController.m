//
//  CenterViewController.m
//  ImageUpload
//
//  Created by Curry on 13-7-16.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "CenterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#include<AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>
#import "SaveScaledImage.h"
#import "SendHeartbeat.h"
#import "SettingViewController.h"
@interface CenterViewController ()
{
    NetWork *netWork_;
    MyProgressView *progressview_;
    UIImageView *imageview;
    SendHeartbeat *sendheart;
    UIButton *addButton;
    UIButton *deleteButton;
    NSMutableArray *imageinfo;
}
@end

@implementation CenterViewController
@synthesize imagePicker = _imagePicker;
@synthesize imagePathString = _imagePathString;
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
     self.navigationItem.title = @"主  页";
    //添加心点功能
    sendheart = [[SendHeartbeat alloc]init];
    imageinfo = [[NSMutableArray alloc]init];
    [sendheart sendheartbeatblock:^(id delegate) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    //设置登陆成功
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LOGINFLAG];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"发 送"
                                                                               style:UIBarButtonItemStyleBordered
                                                                              target:self
                                                                              action:@selector(sendImageUpload)] autorelease];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"设 置"
                                                                               style:UIBarButtonItemStyleBordered
                                                                              target:self
                                                                              action:@selector(setting)] autorelease];
    netWork_ = [[NetWork alloc]init];
    netWork_.delegate = self;
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceScreenWidth, DeviceScreenHeight)];
    backImageView.userInteractionEnabled = YES;
    [backImageView setImage:ImageWithName(@"iphone_bac@2x")];
    [self.view addSubview:backImageView];
    [backImageView release];
    
    imageview = [[UIImageView alloc]init];
    imageview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    imageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImageViewController:)];
    [imageview addGestureRecognizer:singleTap];
    [backImageView addSubview:imageview];
    [singleTap release];
    [imageview release];
    
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(110,150,100,100)];
    [addButton setBackgroundImage:ImageWithName(@"add@2x") forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addActionSheetView:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:addButton];
    
    deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setFrame:CGRectMake(280, 5, 40, 40)];
    [deleteButton setBackgroundImage:ImageWithName(@"deleteBtn@2x") forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteActionSheetView:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:deleteButton];
    deleteButton.hidden = YES;
}

#pragma mark 从用户相册获取活动图片
- (void)pickImageFromAlbum
{
    self.imagePicker = [[[UIImagePickerController alloc] init] autorelease];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.allowsEditing = YES;
    [self presentModalViewController:_imagePicker animated:YES];
}
#pragma mark 从摄像头获取活动图片
- (void)pickImageFromCamera
{
    self.imagePicker = [[[UIImagePickerController alloc] init]autorelease];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.allowsEditing = YES;
    [self presentModalViewController:_imagePicker animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [actionSheet destructiveButtonIndex])
    {
        [self pickImageFromAlbum];
    }
    if (buttonIndex == [actionSheet firstOtherButtonIndex])
    {
        [self pickImageFromCamera];
    }
}
#pragma mark 处理图片信息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    addButton.hidden = YES;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    [imageview setImage:image];
    [self saveSelectImage:image imagename:@"wocaonima"];
    NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:assetURL resultBlock:^(ALAsset *asset){
        NSDictionary *metadata = asset.defaultRepresentation.metadata;
        NSLog(@"%@",metadata);
        [imageinfo addObject:metadata];
    }
            failureBlock:^(NSError *error){}];
    [self imagePickerControllerDidCancel:picker];
}

#pragma mark 取消选择图片
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark 保存图片
- (void)saveSelectImage:(UIImage *)selectimage imagename:(NSString *)name
{
    UIImage *image = [SaveScaledImage imageWithImageSimple:selectimage];
    [SaveScaledImage saveImage:image WithName:name];
    self.imagePathString = [DocumentsDirectory stringByAppendingPathComponent:name];
}

#pragma mark - Add a new view controller

- (void)addActionSheetView:(id)sender {
    UIActionSheet *actionSheet = [[[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"拍照", nil] autorelease];
    [actionSheet setTag:1];
    [actionSheet showInView:self.view];
}
#pragma mark - Delete a new view controller
- (void)deleteActionSheetView:(id)sender
{
    [imageview setImage:nil];
    deleteButton.hidden = YES;
}

- (void)sendImageUpload
{
    if (!imageview.image) {
        //添加进度条
        progressview_ = [[MyProgressView alloc]init];
        progressview_.delegate = self;
        [self.view addSubview:progressview_];
        [progressview_ startLoading:@"上传中,请稍等..."];
        [progressview_ release];
        //调网络发送图片
        [netWork_ setDelegate:self];
        [netWork_ upLoadSalesBigImage:_imagePathString imageinfo:imageinfo];
        //下载文件
//        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString* documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"pptname.pdf"];
//        [netWork_ downLoadFile:documentsDirectory];
    }
    else
    {
         [[[iToast makeText:NSLocalizedString(@"请您选添加发送的内容!", nil)] setGravity:iToastGravityCenter] show];
    }
}

- (void)CancelHttpRequest
{
    [netWork_.asiFormDataRequest cancel];
}

- (void)resultDataToUI:(NSString *)resultData
{
    addButton.hidden = NO;
    deleteButton.hidden = YES;
    [imageview setImage:nil];
    if (progressview_) {
        [progressview_ stopLoading];
    }
}

- (void)resultFailed
{
    addButton.hidden = YES;
    deleteButton.hidden = NO;
    [self CancelHttpRequest];
    //失败
    if (progressview_) {
        [progressview_ stopLoading];
    }
}

- (void)setting
{
    SettingViewController *setting = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
    [setting release];
}

- (void)openImageViewController:(id)sender
{
    if (imageview.image) {
        NSLog(@"a");
    }
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
    [sendheart release];
    [_imagePicker release];
    [_imagePathString release];
    [netWork_ release];
    [super dealloc];
}

@end
