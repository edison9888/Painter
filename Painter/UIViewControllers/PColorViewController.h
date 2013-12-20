//
//  PColorViewController.h
//  Painter
//
//  Created by Chen Yaoqiang on 13-12-19.
//  Copyright (c) 2013年 Yaoqiang Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol colorViewControllerDelegate <NSObject>

-(void)updateSelectedColor:(UIColor *)color;

@end

@interface PColorViewController : UIViewController

@property(nonatomic,assign)id<colorViewControllerDelegate> delegate;
@property (nonatomic,strong) UIView *simpleColorGrid;

@property(nonatomic,strong)NSMutableArray *colorArray;
@property(nonatomic,strong)UIColor *selectedColor;
@property (nonatomic, weak) CALayer *selectedColorLayer;

@end
