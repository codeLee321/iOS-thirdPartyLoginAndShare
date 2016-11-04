//
//  ZTHub.h
//  ZTHub
//
//  Created by raven on 16/5/7.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HubStyle) {
    
    StringStyle = 0,  // 纯文字
    
    ImageStringStyle = 1,  // 图片+文字
    
    ImageGifStyle = 2 // 动态图片
    
};

@interface ZTHub : UIView

@property (nonatomic) HubStyle type;


+ (ZTHub *)shareInstance;




/**
 *  显示纯文字
 *
 *  @param string 文字内容
 */
+ (void)HubWithString:(NSString *)string;

/**
 *  显示gif图片
 */
+ (void)HubWithGif;

/**
 *  自定义显示gif图片
 *
 *  @param imgName 图片名
 *  @param type    图片格式
 */
+ (void)HubWithGif:(NSString *)imgName andType:(NSString *)type;

/**
 *  自定义图片+文字
 *
 *  @param imgName 图片名字
 *  @param string  消息
 */
+ (void)HubImageWithString:(NSString *)imgName message:(NSString *)string;

/**
 *  显示错误提示
 *
 *  @param string 消息
 */
+ (void)HubWithErrorString:(NSString *)string;

/**
 *  显示成功提示
 *
 *  @param string 消息
 */
+ (void)HubWithSuccessString:(NSString *)string;

/**
 *  取消hub
 */
+ (void)Dismiss;

// 关闭加载提示框
+ (void)DismissLoading;

@end
