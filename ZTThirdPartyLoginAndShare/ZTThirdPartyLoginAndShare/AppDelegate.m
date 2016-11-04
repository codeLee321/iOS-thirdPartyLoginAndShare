//
//  AppDelegate.m
//  ZTThirdPartyLoginAndShare
//
//  Created by tony on 16/9/23.
//  Copyright © 2016年 ZThink. All rights reserved.
//
#import "WXApi.h"
#import "WXApiObject.h"
#import "AppDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "ZTThirdPartyLogin.h"
@interface AppDelegate ()<WXApiDelegate,QQApiInterfaceDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /**"l_OBJC_PROTOCOL_$_TencentApiInterfaceDelegate", referenced from:  报错 解决方案 ---》到TencentOAuthObject.h 导入#import "TencentApiInterface.h"
     */
    // 注册微信   ztLifePayDes demo 2.0 应用附加信息，长度不超过1024字节
    [WXApi registerApp:@"WXAppId" withDescription:@"ZTLifePayDes v1.0.0"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    // 微信支付跳转处理
    if ([[url host] isEqualToString:@"pay"])
        return [WXApi handleOpenURL:url delegate:self];
    
    // qq登录
    if ([TencentOAuth CanHandleOpenURL:url])
        return [TencentOAuth HandleOpenURL:url];
    
    // 由手Q唤起的跳转
    if([url.absoluteString hasPrefix:@"tencent"])
        return [QQApiInterface handleOpenURL:url delegate:self];
    
    // 由微信唤起的跳转请求
    if([url.absoluteString hasPrefix:@"wx"])
        return [WXApi handleOpenURL:url delegate:[ZTThirdPartyLogin thirdPartyLogin]];
    
    return YES;


}
@end
