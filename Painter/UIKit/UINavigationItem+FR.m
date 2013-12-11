//
//  UINavigationItem+FR.m
//  FigureReading
//
//  Created by Yaoqiang Chen on 13-11-13.
//  Copyright (c) 2013年 Yaoqiang Chen. All rights reserved.
//

#import "UINavigationItem+FR.h"

@implementation UINavigationItem (FR)

- (UIButton *) createNavtgationItemButton:(CGRect)frame normalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage title:(NSString *)title viewController:(id)viewController action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

- (void)addLeftButton:(id)viewController withAction:(SEL)action
{
    UIButton *LeftButton = [self createNavtgationItemButton:CGRectMake(0, 0, 30, 32) normalImage:[UIImage imageNamed:@"setting_icon4"] highlightImage:nil title:nil viewController:viewController action:action];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:LeftButton];
    self.leftBarButtonItem= leftItem;
}

- (void)addRightButton:(id)viewController withAction:(SEL)action
{
    UIButton *rightButton = [self createNavtgationItemButton:CGRectMake(0, 0, 35, 36) normalImage:[UIImage imageNamed:@"me_setbn"] highlightImage:[UIImage imageNamed:@"me_setbnon"] title:nil viewController:viewController action:action];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.rightBarButtonItem= rightItem;
}

- (void)addBackButton:(id)viewController withAction:(SEL)action
{
    UIButton *bgButton = [self createNavtgationItemButton:CGRectMake(0, 0, 44, 44) normalImage:nil highlightImage:nil title:nil viewController:viewController action:action];
    
    UIButton *leftButton = [self createNavtgationItemButton:CGRectMake(IS_IOS7 ? 0 : 10, 0, 8, 44) normalImage:[UIImage imageNamed:@"nav_back"] highlightImage:nil title:nil viewController:viewController action:action];
    [bgButton addSubview:leftButton];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:bgButton];
    self.leftBarButtonItem= leftItem;
}

-(void)setNavigationItemTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,200, 36)];
    titleLabel.backgroundColor = PClearColor;
    titleLabel.textColor = PWhiteColor;
    titleLabel.font = PFontSize(20);
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleView = titleLabel;
}

@end
