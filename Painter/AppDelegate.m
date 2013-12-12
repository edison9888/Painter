//
//  AppDelegate.m
//  Painter
//
//  Created by Yaoqiang Chen on 13-11-12.
//  Copyright (c) 2013年 Yaoqiang Chen. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    if (IS_IOS7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bg2.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    //友盟社交
    [UMSocialData setAppKey:kUMAppKey];
    
    [UMSocialConfig setWXAppId:@"wxa393da37761c7f6b" url:nil];
    
    //打开Qzone的SSO开关
    [UMSocialConfig setSupportQzoneSSO:YES importClasses:@[[QQApiInterface class],[TencentOAuth class]]];
    
    //设置手机QQ的AppId，url传nil，将使用友盟的网址
    [UMSocialConfig setQQAppId:@"100575186" url:nil importClasses:@[[QQApiInterface class],[TencentOAuth class]]];
    
    [UMSocialConfig setSupportSinaSSO:YES];
    
//#warning 正式打包上线的时候把ifdef注释掉，测试和开发的时候不进行统计
//#ifdef RELEASE
    [MobClick startWithAppkey:kUMAppKey reportPolicy:SEND_ON_EXIT channelId:kAppStore];
    [MobClick updateOnlineConfig];
    [MobClick setAppVersion:kAppVersion];
//#endif
    
    BOOL banner= [[MobClick getConfigParams:kAdBanner] boolValue];
    BOOL app = [[MobClick getConfigParams:kAppRecommend] boolValue];
    
    [[NSUserDefaults standardUserDefaults] setBool:banner forKey:kAdBanner];
    [[NSUserDefaults standardUserDefaults] setBool:app forKey:kAppRecommend];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"addd %@ %@",kAdBanner,kAppRecommend);
    
    //有米
    [YouMiConfig setShouldGetLocation:NO];
    [YouMiConfig setUseInAppStore:YES];  // [可选]开启内置appStore，详细请看YouMiSDK常见问题解答
    [YouMiConfig launchWithAppID:kYoumiAppID appSecret:kYoumiAppSecret];
    [YouMiWall enable];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    PMainViewController *mainVC = [[PMainViewController alloc] init];
    
    _navVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    _navVC.navigationBar.translucent = NO;
    [self.window setRootViewController:_navVC];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
