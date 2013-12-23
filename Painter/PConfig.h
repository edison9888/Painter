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

#define PFontSize(x) [UIFont systemFontOfSize:x]

//user default
#define kShadeClean @"shadeClean"

#define kAppVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

#define kAppStore @"AppStore"
#define kNineOne @"91"
#define kTongBuTui @"tongbutui"

#define kAdBanner [NSString stringWithFormat:@"banner_%@_%@",kNineOne,kAppVersion]
#define kAppRecommend [NSString stringWithFormat:@"app_%@_%@",kNineOne,kAppVersion]

//第三方key
#define kUMAppKey @"52a8342456240b9032041ee5"

#define kYoumiAppID @"25ae9de162414438"
#define kYoumiAppSecret @"e660fc42c6f80d5c"