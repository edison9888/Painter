//
//  UIView+BM.h
//  telecom_mmq
//
//  Created by Chen Yaoqiang on 13-9-3.
//  Copyright (c) 2013年 盛成文化. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BM)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;
typedef void (^AfterAnimationBlock)(void);

-(void) resetWidth:(CGFloat)width;
-(void) resetHeight:(CGFloat)height;
-(void) resetY:(CGFloat)y;
- (void) resetX:(CGFloat)x;

+(CGSize)getScaleRect:(CGSize)originSize targetSize:(CGSize)maxSize;

@end
