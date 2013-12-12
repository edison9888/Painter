//
//  PMainViewController.m
//  Painter
//
//  Created by Chen Yaoqiang on 13-12-10.
//  Copyright (c) 2013年 Yaoqiang Chen. All rights reserved.
//

#import "PMainViewController.h"
#import "UIImageCategory.h"

@interface PMainViewController ()

@property(nonatomic,strong)YouMiView *adView;

@end

@implementation PMainViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        [self.navigationItem setNavigationItemTitle:@"随心涂鸦"];
        [self.navigationItem addLeftButton:self withAction:@selector(moreEvent)];
        [self.navigationItem addRightButton:self withAction:@selector(showSetting)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, IOS7_STATUS_BAR_HEGHT, 320, self.view.bounds.size.height - IOS7_STATUS_BAR_HEGHT);
	// Do any additional setup after loading the view.
    self.view.backgroundColor = PClearColor;

    _mainView = [[MainView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-44)];
    _mainView.backgroundColor = PWhiteColor;
    [self.view addSubview:_mainView];
    
    BOOL youmi = [[NSUserDefaults standardUserDefaults] boolForKey:kAdBanner];

    if (youmi) {
        _adView = [[YouMiView alloc] initWithContentSizeIdentifier:YouMiBannerContentSizeIdentifier320x50 delegate:nil];
        [_adView resetY:_mainView.height - 50];
        _adView.delegate = self;
        [_adView start];
        [self.view addSubview:_adView];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
}

- (void)onlineConfigCallBack:(NSNotification *)notification {
    BOOL youmi=[[notification.userInfo objectForKey:kAdBanner] boolValue];
    
    [[NSUserDefaults standardUserDefaults] setBool:youmi forKey:kAdBanner];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (youmi && !_adView) {
        _adView = [[YouMiView alloc] initWithContentSizeIdentifier:YouMiBannerContentSizeIdentifier320x50 delegate:nil];
        [_adView resetY:_mainView.height - 50];
        _adView.delegate = self;
        [_adView start];
        [self.view addSubview:_adView];
    }
}

- (void)didPresentScreen:(YouMiView *)adView
{
    _adView.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!_imagePC) {
        _imagePC=[[UIImagePickerController alloc] init];
        _imagePC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        _imagePC.delegate=self;
    }
}

- (void)setColor:(UIColor *)color
{
	NSLog(@"color");
	/*
     MainView *view = (MainView *)self.view; // get main view as a MainView
     view.color = color; // update the color in the main view*/
	_mainView.color=color;
} // end method setColor:

// set the line width of view
- (void)setLineWidth:(float)width
{
	NSLog(@"width");
	/*
     // set the line width of the main view
     MainView *view = (MainView *)self.view; // get main view as a MainView
     view.lineWidth = width; // update the line width in the main view*/
	_mainView.lineWidth=width;
} // end method setLineWidth:

// clear the paintings in the main view
- (void)resetView
{
    //MainView *view = (MainView *)self.view; // get main view as a MainView
    [_mainView resetView]; // reset the main view
} // end method resetView

-(void)moreEvent
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate: self
                                  cancelButtonTitle: @"取消"
                                  destructiveButtonTitle: nil
                                  otherButtonTitles:@"从相册选择图片",@"保存图画到相册",@"分享图画",@"分享账号设置",nil];
    [actionSheet showInView: self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self presentModalViewController:_imagePC animated:YES];
        }
            break;
        case 1:
        {
            [_mainView saveView];
        }
            break;
        case 2:
        {
            [self shareImage];
        }
            break;
        case 3:
        {
            UINavigationController *accountViewController =[[UMSocialControllerService defaultControllerService] getSnsAccountController];
            [self presentModalViewController:accountViewController animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)shareImage
{
    UIGraphicsBeginImageContext(_mainView.bounds.size);
	
    [_mainView.layer renderInContext:UIGraphicsGetCurrentContext()];
	
    UIImage *shareImage = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();

    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    [UMSocialData defaultData].extConfig.title = [NSString stringWithFormat:@"随心涂鸦"];
    
    NSString *shareText = [NSString stringWithFormat:@"我在随心涂鸦上画了一幅画，大家都来画出你的心情吧！"];            //分享内嵌文字
    
    //如果得到分享完成回调，需要传递delegate参数
    [UMSocialSnsService presentSnsIconSheetView:self appKey:kUMAppKey shareText:shareText shareImage:shareImage shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ] delegate:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	image = [image transformWidth:_mainView.bounds.size.width height:_mainView.bounds.size.height ];
	
	[_mainView setBackgroundColor:[UIColor colorWithPatternImage:image]];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[_imagePC dismissModalViewControllerAnimated:YES];
}

-(void)showSetting
{
    PSettingViewController *settingVC = [[PSettingViewController alloc] init];
    settingVC.delegate = self;
    [settingVC setColor:_mainView.color lineWidth:_mainView.lineWidth];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
