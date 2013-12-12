//
//  UIView+BM.m
//  telecom_mmq
//
//  Created by Chen Yaoqiang on 13-9-3.
//  Copyright (c) 2013年 盛成文化. All rights reserved.
//

#import "UIView+BM.h"

@implementation UIView (BM)

-(void) resetWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width= width;
    self.frame = frame;
}

-(void) resetHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}

-(void) resetY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void) resetX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

+(CGSize)getScaleRect:(CGSize)originSize targetSize:(CGSize)maxSize{
    CGFloat width = originSize.width;
    CGFloat height = originSize.height;
    
    CGFloat wSize = width/maxSize.width;
    CGFloat hSize = height/maxSize.height;
    
    //    CGFloat currSize = wSize < hSize ? wSize : hSize;
    
    //Loong modified
    CGFloat currSize = wSize > hSize ? wSize : hSize;
    
    CGFloat finelWidth = width/currSize;
    CGFloat finelHeight = height/currSize;
    
    return CGSizeMake(finelWidth, finelHeight);
}

@end
