//
//  ZTHttpHint.h
//  ZTLife
//
//  Created by ZThink on 16/4/8.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTHttpHint : NSObject

/**
 *  弹出描述：状态码、接口编号
 *
 *  @param stateNumber 状态码
 *  @param code        接口编号
 */
+ (void)SVShowWithState:(int)stateNumber APICode:(NSString *)code;


/**
 *  是否弹出成功/失败 描述：状态码、接口编号
 *
 *  @param stateNumber 状态码
 *  @param code        接口编号
 *  @param isShowS     是否成功情况下显示
 *  @param isShowE     是否失败情况下显示
 */
+ (void)SVShowWithState:(int)stateNumber APICode:(NSString *)code showSuccess:(BOOL)isShowS showError:(BOOL)isShowE;

/**
 *  仅弹出错误描述：状态码、接口编号
 *
 *  @param stateNumber 状态码
 *  @param code        接口编号
 */
+ (void)SVShowErrorWithState:(int)stateNumber APICode:(NSString *)code;

/**
 *  弹出错误描述：string
 */
+ (void)SVShowErrorString:(NSString *)string;

/**
 *  弹出成功描述：string
 */
+ (void)SVShowSuccessString:(NSString *)string;


/**
 *  网络不给力!
 */
+ (void)SVShowNetWorkError;

/**
 *  显示加载
 */
+ (void)SVShow;

/**
 *  关闭加载
 */
+ (void)SVDismiss;

/**
 *  通过服务器返回状态码、接口编号，返回状态描述
 *
 *  @param state 请求服务器返回状态码
 *  @param code  接口编号
 *
 *  @return NSString
 */
+ (NSString *)hintStringWithState:(int)stateNumber APICode:(NSString *)code;

@end
