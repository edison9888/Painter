//
//  UINavigationItem+FR.h
//  FigureReading
//
//  Created by Yaoqiang Chen on 13-11-13.
//  Copyright (c) 2013年 Yaoqiang Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (FR)

- (void)addRightButton:(id)viewController withAction:(SEL)action;
- (void)addBackButton:(id)viewController withAction:(SEL)action;

-(void)setNavigationItemTitle:(NSString *)title;

@end
