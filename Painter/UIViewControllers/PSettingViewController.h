//
//  PSettingViewController.h
//  Painter
//
//  Created by Chen Yaoqiang on 13-12-11.
//  Copyright (c) 2013年 Yaoqiang Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PSettingViewControllerDelegate
- (void)setColor:(UIColor *)color; // sets the current drawing color
- (void)setLineWidth:(float)width; // sets the current drawing line width
- (void)resetView; // erases the entire painting
@end // end protocol FlipsideViewControllerDelegate

@interface PSettingViewController : UIViewController<UIAlertViewDelegate>

@property(nonatomic,assign)id<PSettingViewControllerDelegate> delegate;

@property(nonatomic,strong)UISlider *widthSlider;

@property(nonatomic, strong) UISlider *redSlider;
@property(nonatomic, strong) UISlider *greenSlider;
@property(nonatomic, strong) UISlider *blueSlider;
@property(nonatomic, strong) UIView *colorView;

- (void)setColor:(UIColor *)color lineWidth:(float)width;

@end
