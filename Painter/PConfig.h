//
//  PConfig.h
//  Painter
//
//  Created by Chen Yaoqiang on 13-12-10.
//  Copyright (c) 2013年 Yaoqiang Chen. All rights reserved.
//
#define isRetina ([[UIScreen mainScreen] scale] > 1.0f)

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define IOS7_STATUS_BAR_HEGHT (IS_IOS7 ? 20.0f : 0.0f)

#define PWhiteColor [UIColor whiteColor]
#define PBlackColor [UIColor blackColor]
#define PClearColor [UIColor clearColor]