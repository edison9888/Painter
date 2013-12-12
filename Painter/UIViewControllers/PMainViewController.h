//
//  PMainViewController.h
//  Painter
//
//  Created by Chen Yaoqiang on 13-12-10.
//  Copyright (c) 2013年 Yaoqiang Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"
#import "PSettingViewController.h"

@interface PMainViewController : UIViewController<PSettingViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,YouMiDelegate>

@property(nonatomic,strong)MainView *mainView;

@property(nonatomic,strong)UIImagePickerController *imagePC;

@end
