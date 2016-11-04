//
//  ZTHttpHint.m
//  ZTLife
//
//  Created by ZThink on 16/4/8.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import "ZTHttpHint.h"
#import "ZTHub.h"

// 默认返回描述字符串，当找不到对应结果时候使用
#define errorDefault @"出错啦"

// 网络不给力
#define errorNetWork @"网络不给力!"

@implementation ZTHttpHint

#pragma maark - 调用区

/**
 *  弹出描述：状态码、接口编号
 *
 *  @param stateNumber 状态码
 *  @param code        接口编号
 */
+ (void)SVShowWithState:(int)stateNumber APICode:(NSString *)code
{
    [self SVShowWithState:stateNumber APICode:code showSuccess:YES showError:YES];
}


/**
 *  是否弹出成功/失败 描述：状态码、接口编号
 *
 *  @param stateNumber 状态码
 *  @param code        接口编号
 *  @param isShowS     是否成功情况下显示
 *  @param isShowE     是否失败情况下显示
 */
+ (void)SVShowWithState:(int)stateNumber APICode:(NSString *)code showSuccess:(BOOL)isShowS showError:(BOOL)isShowE
{
    NSString *string = [self hintStringWithState:stateNumber APICode:code];
    
    // 显示成功提示框
    if(stateNumber == 200 && isShowS)
    {
        //[SVProgressHUD showSuccessWithStatus:string];
        [ZTHub HubWithSuccessString:string];
        return;
    }
    
    // 显示失败提示框
//    if(isShowE)
//        [SVProgressHUD showErrorWithStatus:string];
    if(isShowE)
        [ZTHub HubWithErrorString:string];
}

/**
 *  仅弹出错误描述：状态码、接口编号
 *
 *  @param stateNumber 状态码
 *  @param code        接口编号
 */
+ (void)SVShowErrorWithState:(int)stateNumber APICode:(NSString *)code
{
    if(stateNumber == 200)
        return;
    
    [self SVShowWithState:stateNumber APICode:code showSuccess:NO showError:YES];
}

/**
 *  弹出错误描述：string
 */
+ (void)SVShowErrorString:(NSString *)string
{
     //[SVProgressHUD showErrorWithStatus:string];
    [ZTHub HubWithErrorString:string];
}

/**
 *  弹出成功描述：string
 */
+ (void)SVShowSuccessString:(NSString *)string
{
    //[SVProgressHUD showSuccessWithStatus:string];
    [ZTHub HubWithSuccessString:string];
}

/**
 *  网络不给力!
 */
+ (void)SVShowNetWorkError
{
   // [SVProgressHUD showErrorWithStatus:errorNetWork];
    [ZTHub HubWithErrorString:errorNetWork];
}

/**
 *  显示加载
 */
+ (void)SVShow
{
    //[SVProgressHUD show];
    [ZTHub HubWithGif];
}

/**
 *  关闭加载
 */
+ (void)SVDismiss
{
  //  [SVProgressHUD dismiss];
    [ZTHub DismissLoading];
}

#pragma - 工具区

/**  通过服务器返回状态码、接口编号，返回状态描述*/
+ (NSString *)hintStringWithState:(int)stateNumber APICode:(NSString *)code
{
    NSString *state = [NSString stringWithFormat:@"%i",stateNumber];
    
    NSArray *arrEncodeAPI = [self encodeAPICode:code];
    
    if([arrEncodeAPI count] < 1 || [arrEncodeAPI count] > 2)
        return errorDefault;
    
    int firstValue = [arrEncodeAPI[0] intValue];
    int secondValue = [arrEncodeAPI[1]intValue];
    
    if(firstValue < 1 || secondValue < 1)
        return errorDefault;
    
    switch (firstValue) {
        case 2:
        {
           return [self hintStringSeries_2_WithSecondCode:secondValue state:state];
        }
            break;
        case 3:
        {
            return [self hintStringSeries_3_WithSecondCode:secondValue state:state];
        }
            break;
        case 4:
        {
            return [self hintStringSeries_4_WithSecondCode:secondValue state:state];
        }
            break;
        case 5:
        {
            return [self hintStringSeries_5_WithSecondCode:secondValue state:state];
        }
            break;
        case 6:
        {
            return [self hintStringSeries_6_WithSecondCode:secondValue state:state];
        }
            break;
        case 7:
        {
            return [self hintStringSeries_7_WithSecondCode:secondValue state:state];
        }
            break;
        case 8:
        {
            return [self hintStringSeries_8_WithSecondCode:secondValue state:state];
        }
            break;
        case 11:
        {
            return [self hintStringSeries_11_WithSecondCode:secondValue state:state];
        }
            break;
        case 12:
        {
            return [self hintStringSeries_12_WithSecondCode:secondValue state:state];
        }
            break;
        default:
            break;
    }
    return errorDefault;
}

/** 解析接口编码*/
+ (NSArray *)encodeAPICode:(NSString *)code
{
    if(code.length < 1)
        return nil;
    
    NSArray *arr = [code componentsSeparatedByString:@"."];
    
    if([arr count] != 2)
        return nil;
    
    return arr;
}

#pragma mark - 各个系列模块接口 - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// 系列2  用户模块
+ (NSString *)hintStringSeries_2_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //2.1. 获取手机验证码
            dic = @{@"200":@"发送成功",
                    @"301":@"手机号码无效",
                    @"302":@"该手机号码已被注册",
                    @"303":@"手机号码不存在",
                    @"300":@"发送验证码失败"};
        }
            break;
        case 2:
        {
            //2.2. 用户注册
            dic = @{@"200":@"注册成功",
                    @"301":@"手机号码无效",
                    @"302":@"该手机号码已被注册",
                    @"303":@"验证码错误",
                    @"304":@"密码格式不正确，长度为6-18位，且必须包含数字、字母、符号两种以上",
                    @"305":@"推荐码不存在",
                    @"300":@"注册失败"};
        }
            break;
        case 3:
        {
            //2.3. 用户登录
            dic = @{@"200":@"登录成功",
                    @"301":@"手机号码不存在",
                    @"302":@"用户被屏蔽",
                    @"303":@"密码错误",
                    @"300":@"登录出错"};
        }
            break;
        case 4:
        {
            //2.4. 忘记密码/修改密码
            dic = @{@"200":@"修改密码成功",
                    @"301":@"手机号码不存在",
                    @"302":@"验证码错误",
                    @"304":@"密码格式不正确，长度为6-18位，且必须包含数字、字母、符号两种以上",
                    @"300":@"操作失败"};
        }
            break;
        case 5:
        {
            //2.5. 获取用户资料（需要权限）
            dic = @{@"200":@"获取成功，成功才有用户信息返回",
                    @"300":@"获取失败"};
        }
            break;
        case 6:
        {
            //2.6. 修改昵称（需要权限）
            dic = @{@"200":@"修改成功",
                    @"300":@"修改失败"};
        }
            break;
        case 7:
        {
            //2.7. 修改性别（需要权限）
            dic = @{@"200":@"修改成功",
                    @"300":@"修改失败"};
        }
            break;
        case 8:
        {
            //2.8. 修改手机号码（需要权限）
            dic = @{@"200":@"修改成功",
                    @"301":@"手机号码无效",
                    @"302":@"手机号尚未修改",
                    @"303":@"该手机号码已使用",
                    @"304":@"验证码错误",
                    @"305":@"确认密码错误",
                    @"300":@"修改失败"};
        }
            break;
        case 9:
        {
            //2.9. 修改个人头像（需要权限）
            dic = @{@"200":@"修改成功",
                    @"300":@"修改失败"};
        }
            break;
        case 10:
        {
            //2.10. 查看收货地址列表（需要权限）
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 11:
        {
            //2.11. 查询具体收货地址信息（需要权限）
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 12:
        {
            //2.12. 新增/修改收货地址（需要权限）
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 13:
        {
            //2.13. 删除收货地址（需要权限）
            dic = @{@"200":@"删除成功",
                    @"300":@"删除失败"};
        }
            break;
        case 14:
        {
            //2.14. 设置默认收货地址（需要权限）
            dic = @{@"200":@"设置成功",
                    @"300":@"设置失败"};
        }
            break;
        case 15:
        {
            //2.15. 查看通知列表
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 16:
        {
            //2.16. 查看通知详情
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 17:
        {
            //2.17. 查看他人个人信息-简版
            dic = @{@"200":@"获取成功，成功才有用户信息返回",
                    @"300":@"获取失败"};
        }
            break;
        case 18:
        {
            //2.18. 修改出生日期（需要权限）
            dic = @{@"200":@"修改成功",
                    @"300":@"修改失败"};
        }
            break;
        case 20:
        {
            //2.20. 第三方登录
            dic = @{@"200":@"登录成功",
                    @"300":@"登录出错"};
        }
            break;
        case 21:
        {
            //2.21. 绑定手机号码（需要权限）
            dic = @{@"200":@"绑定成功",
                    @"301":@"手机号码无效",
                    @"303":@"该手机号码已使用",
                    @"304":@"验证码错误",
                    @"300":@"绑定失败"};
        }
            break;
        case 22:
        {
            //2.22. 提交用户经纬度
            dic = @{@"200":@"提交成功",
                    @"300":@"提交失败"};
        }
            break;
        case 23:
        {
            //2.23. 退出登录
            dic = @{@"200":@"退出成功",
                    @"300":@"退出出错"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列3  商品信息模块
+ (NSString *)hintStringSeries_3_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //3.1. 查询商品分类
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 2:
        {
            //3.2. 按商品分类查询商品列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 3:
        {
            //3.3. 按人气/最新/进度/总需人次查询商品列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 4:
        {
            //3.4. 查看商品详情
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 5:
        {
            //3.5. 获取最新一期商品详情
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 6:
        {
            //3.6. 最新揭晓
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 7:
        {
            //3.7. 获取热门搜索关键字
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 8:
        {
            //3.8. 搜索商品
            dic = @{@"200":@"获取数据成功",
                    @"300":@"获取数据失败"};
        }
            break;
        case 9:
        {
            //3.9. 查询推荐商品
            dic = @{@"200":@"获取数据成功",
                    @"300":@"获取数据失败"};
            
        }
            break;
        case 10:
        {
            //3.10. 最新揭晓TOP3
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 11:
        {
            //3.11. 查询房车列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列4  清单模块
+ (NSString *)hintStringSeries_4_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //4.1. 加入或修改清单商品数量（需要权限）
            dic = @{@"200":@"操作成功",
                    @"300":@"该商品已揭晓，不能购买，同时app客户端需要删除该商品",
                    @"300":@"操作失败"};
        }
            break;
        case 2:
        {
            //4.2. 查看清单列表（需要权限）
            dic = @{@"200":@"获取数据成功",
                    @"300":@"获取数据失败"};
        }
            break;
        case 3:
        {
            //4.3. 删除清单（需要权限）
            dic = @{@"200":@"删除成功",
                    @"300":@"删除失败"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列5  夺宝模块
+ (NSString *)hintStringSeries_5_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //5.1. 查看用户夺宝列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 2:
        {
            //5.2. 查看用户夺宝详情（暂时弃用）
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 3:
        {
            //5.3. 查看用户夺宝号码（暂时弃用）
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 4:
        {
            //5.4. 查看用户中奖记录列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 5:
        {
            //5.5. 获取最新中奖用户列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 6:
        {
            //5.6. 查看商品详情中夺宝记录列表
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 7:
        {
            //5.7. 查看往期揭晓
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 8:
        {
            //5.8. 查看夺宝中奖信息
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 9:
        {
            //5.9. 查看用户夺宝号码列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 10:
        {
            //5.10. 获取用户的余额和红包（需要权限）
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 12:
        {
            //5.12. 下单/支付（需要权限)
            dic = @{@"200":@"操作成功",
                    @"301":@"没有夺宝商品",
                    @"302":@"购买人次不能小于1",
                    @"303":@"请选择支付方式",
                    @"304":@"红包不可用",
                    @"305":@"余额不足",
                    @"306":@"不支持除微信和支付宝外的其他第三方支付",
                    @"307":@"需要微信或支付宝支付的金额不能小于等于1",
                    @"308":@"实际需要微信或支付宝支付的金额与传人的参数不一致",
                    @"309":@"十元夺宝的商品购买人次必须能被10整除",
                    @"310":@"你选择的期号已买满，不能夺宝",
                    @"311":@"不支持微信支付",
                    @"312":@"不支持支付宝支付",
                    @"313":@"请选择应用类型",
                    @"314":@"一次只能使用一个红包",
                    @"315":@"使用的红包不符合满减要求",
                    @"316":@"红包已过期",
                    @"317":@"百元商品购买人次上限为50人次",
                    @"320":@"微信或支付宝支付失败",
                    @"330":@"用户错误",
                    @"300":@"操作失败"};
        }
            break;
        case 13:
        {
            //5.13. 获取支付结果（需要权限）
            dic = @{@"200":@"获取成功",
                    @"301":@"获取失败，参数错误",
                    @"300":@"获取失败"};
        }
            break;
        case 14:
        {
            //5.14. 微信/支付宝取消支付（需要权限）
            dic = @{@"200":@"取消成功",
                    @"301":@"取消失败，参数错误",
                    @"302":@"不能取消非本人的订单",
                    @"303":@"只能取消未支付的订单",
                    @"300":@"取消失败"};
        }
            break;
        case 15:
        {
            //5.15. 支付宝支付通知后台等待支付结果(弃用)
            dic = @{@"200":@"取消成功",
                    @"301":@"取消失败，参数错误",
                    @"302":@"不能取消非本人的订单",
                    @"303":@"只能取消未支付的订单",
                    @"300":@"取消失败"};
            
        }
            break;
        case 16:
        {
            //5.16. 充值下单（需要权限）
            dic = @{@"200":@"操作成功",
                    @"301":@"仅支持微信或支付宝支付充值",
                    @"302":@"充值金额范围在1-10000000之间",
                    @"311":@"不支持微信支付",
                    @"312":@"不支持支付宝支付",
                    @"320":@"微信或支付宝支付失败",
                    @"330":@"用户错误",
                    @"300":@"操作失败"};
        }
            break;
        case 17:
        {
            //5.17. 取消充值（需要权限）
            dic = @{@"200":@"取消成功",
                    @"301":@"取消失败，参数错误",
                    @"302":@"不能取消非本人的充值",
                    @"303":@"只能取消未支付的充值",
                    @"300":@"取消失败"};
        }
            break;
        case 18:
        {
            //5.18. 查看充值记录（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
            
        }
            break;
        case 19:
        {
            //5.19. 查看充值结果
            dic = @{@"200":@"获取成功",
                    @"301":@"商户订单号错误",
                    @"300":@"获取失败"};
        }
            break;
        case 20:
        {
            //5.20. 查看开奖结果
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 21:
        {
            //5.21. 查看中奖记录明细
            dic = @{@"200":@"获取成功",
                    @"301":@"参数错误",
                    @"300":@"获取失败"};
        }
            break;
        case 22:
        {
            //5.22. 确认收货地址（需要权限）
            dic = @{@"200":@"成功",
                    @"301":@"参数错误",
                    @"302":@"状态不正确，不能确认收货地址",
                    @"303":@"不能操作非本人的数据",
                    @"304":@"请选择收货地址",
                    @"305":@"只能选择自己的收货地址",
                    @"300":@"失败"};
        }
            break;
        case 23:
        {
            //5.23. 确认收货（需要权限）
            dic = @{@"200":@"取消成功",
                    @"301":@"参数错误",
                    @"302":@"状态不正确，不能确认收货地址",
                    @"303":@"不能操作非本人的数据",
                    @"300":@"取消失败"};
        }
            break;
        case 24:
        {
            //5.24. iOS查询是否屏蔽爱贝支付
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 25:
        {
            //5.25. 上传证件信息（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败",
                    @"301":@"参数错误",
                    @"302":@"状态不正确，不能上传证件信息",
                    @"303":@"不能操作非本人的数据"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列6  晒单分享模块
+ (NSString *)hintStringSeries_6_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //6.1. 查看晒单分享列表
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 2:
        {
            //6.2. 查看晒单详情
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 3:
        {
            //6.3. 我的晒单（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 4:
        {
            //6.4. 晒单分享（需要权限）
            dic = @{@"200":@"成功",
                    @"301":@"主题不少于6个字",
                    @"302":@"主题不超过32个字",
                    @"303":@"获奖感言不少于30个字",
                    @"304":@"获奖感言不超过300个字",
                    @"305":@"请上传图片",
                    @"306":@"最多上传6张图片",
                    @"307":@"已晒单",
                    @"308":@"只能发布本人的晒单",
                    @"300":@"失败"};
        }
            break;
        case 5:
        {
            //6.5. 首页晒单/用户晒单列表
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列7  积分模块
+ (NSString *)hintStringSeries_7_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //7.1. 查看积分记录（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 2:
        {
            //7.2. 查看个人积分（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 3:
        {
            //7.3. 积分抽红包（需要权限）
            dic = @{@"200":@"成功",
                    @"301":@"积分不够100，不能抽奖",
                    @"300":@"失败",
                    @"302":@"不在积分抽红包时间范围内"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
}

// 系列8  红包模块
+ (NSString *)hintStringSeries_8_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //8.1. 看红包列表查（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 2:
        {
            //8.2. 分享抽夺宝红包（需要权限）
            dic = @{@"200":@"成功",
                    @"301":@"活动已结束",
                    @"302":@"已抽奖，不能重复抽奖",
                    @"300":@"失败"};
        }
            break;
        case 3:
        {
            //8.3. 推荐码页面（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 4:
        {
            //8.4. 推荐码抽夺宝红包（需要权限）
            dic = @{@"200":@"成功",
                    @"301":@"红包不存在",
                    @"302":@"非本人红包，不能抽奖",
                    @"303":@"已抽奖，不能重复抽奖",
                    @"300":@"失败"};
        }
            break;
            
        case 5:
        {
            //8.5. 获取生活类红包（需要权限）
            dic = @{@"200":@"成功",
                    @"301":@"抱歉，只能获取一次",
                    @"300":@"失败"};
        }
            break;
            
        case 6:
        {
            //8.6. 查看推荐记录（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
            
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列11  其他模块
+ (NSString *)hintStringSeries_11_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //11.1. 查询首页顶部图片切换
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 3:
        {
            //11.3. 获取启动页图片
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 4:
        {
            //11.4. 获取当前皮肤主题
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
            
        case 5:
        {
            //11.5. 获取广告页图片
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
            
        case 6:
        {
            //11.6. 通知服务端推送分享红包消息
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
            
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列12  发现模块
+ (NSString *)hintStringSeries_12_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //12.1. 查询发现分类
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}







/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
//
//                            预留代码，没删除 398  399 的
//
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


/*
#pragma mark - 各个系列模块接口 - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// 系列2  用户模块
+ (NSString *)hintStringSeries_2_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //2.1. 获取手机验证码
            dic = @{@"200":@"发送成功",
                    @"301":@"手机号码无效",
                    @"302":@"该手机号码已被注册",
                    @"303":@"手机号码不存在",
                    @"300":@"发送验证码失败"};
        }
            break;
        case 2:
        {
            //2.2. 用户注册
            dic = @{@"200":@"注册成功",
                    @"301":@"手机号码无效",
                    @"302":@"该手机号码已被注册",
                    @"303":@"验证码错误",
                    @"304":@"密码格式不正确，长度为6-18位，且必须包含数字、字母、符号两种以上",
                    @"305":@"推荐码不存在",
                    @"300":@"注册失败"};
        }
            break;
        case 3:
        {
            //2.3. 用户登录
            dic = @{@"200":@"登录成功",
                    @"301":@"手机号码不存在",
                    @"302":@"用户被屏蔽",
                    @"303":@"密码错误",
                    @"300":@"登录出错"};
        }
            break;
        case 4:
        {
            //2.4. 忘记密码/修改密码
            dic = @{@"200":@"修改密码成功",
                    @"301":@"手机号码不存在",
                    @"302":@"验证码错误",
                    @"304":@"密码格式不正确，长度为6-18位，且必须包含数字、字母、符号两种以上",
                    @"300":@"操作失败"};
        }
            break;
        case 5:
        {
            //2.5. 获取用户资料（需要权限）
            dic = @{@"200":@"获取成功，成功才有用户信息返回",
                    @"300":@"获取失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 6:
        {
            //2.6. 修改昵称（需要权限）
            dic = @{@"200":@"修改成功",
                    @"300":@"修改失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 7:
        {
            //2.7. 修改性别（需要权限）
            dic = @{@"200":@"修改成功",
                    @"300":@"修改失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 8:
        {
            //2.8. 修改手机号码（需要权限）
            dic = @{@"200":@"修改成功",
                    @"301":@"手机号码无效",
                    @"302":@"手机号尚未修改",
                    @"303":@"该手机号码已使用",
                    @"304":@"验证码错误",
                    @"305":@"确认密码错误",
                    @"300":@"修改失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 9:
        {
            //2.9. 修改个人头像（需要权限）
            dic = @{@"200":@"修改成功",
                    @"300":@"修改失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 10:
        {
            //2.10. 查看收货地址列表（需要权限）
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 11:
        {
            //2.11. 查询具体收货地址信息（需要权限）
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 12:
        {
            //2.12. 新增/修改收货地址（需要权限）
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 13:
        {
            //2.13. 删除收货地址（需要权限）
            dic = @{@"200":@"删除成功",
                    @"300":@"删除失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 14:
        {
            //2.14. 设置默认收货地址（需要权限）
            dic = @{@"200":@"设置成功",
                    @"300":@"设置失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 15:
        {
            //2.15. 查看通知列表
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 16:
        {
            //2.16. 查看通知详情
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 17:
        {
            //2.17. 查看他人个人信息-简版
            dic = @{@"200":@"获取成功，成功才有用户信息返回",
                    @"300":@"获取失败"};
        }
            break;
        case 18:
        {
            //2.18. 修改出生日期（需要权限）
            dic = @{@"200":@"修改成功",
                    @"300":@"修改失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 20:
        {
            //2.20. 第三方登录
            dic = @{@"200":@"登录成功",
                    @"300":@"登录出错"};
        }
            break;
        case 21:
        {
            //2.21. 绑定手机号码（需要权限）
            dic = @{@"200":@"绑定成功",
                    @"301":@"手机号码无效",
                    @"303":@"该手机号码已使用",
                    @"304":@"验证码错误",
                    @"300":@"绑定失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 22:
        {
            //2.22. 提交用户经纬度
            dic = @{@"200":@"提交成功",
                    @"300":@"提交失败"};
        }
            break;
        case 23:
        {
            //2.23. 退出登录
            dic = @{@"200":@"退出成功",
                    @"300":@"退出出错"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列3  商品信息模块
+ (NSString *)hintStringSeries_3_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //3.1. 查询商品分类
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 2:
        {
            //3.2. 按商品分类查询商品列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 3:
        {
            //3.3. 按人气/最新/进度/总需人次查询商品列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 4:
        {
            //3.4. 查看商品详情
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 5:
        {
            //3.5. 获取最新一期商品详情
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 6:
        {
            //3.6. 最新揭晓
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 7:
        {
            //3.7. 获取热门搜索关键字
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 8:
        {
            //3.8. 搜索商品
            dic = @{@"200":@"获取数据成功",
                    @"300":@"获取数据失败"};
        }
            break;
        case 9:
        {
            //3.9. 查询推荐商品
            dic = @{@"200":@"获取数据成功",
                    @"300":@"获取数据失败"};
            
        }
            break;
        case 10:
        {
            //3.10. 最新揭晓TOP3
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列4  清单模块
+ (NSString *)hintStringSeries_4_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //4.1. 加入或修改清单商品数量（需要权限）
            dic = @{@"200":@"操作成功",
                    @"300":@"该商品已揭晓，不能购买，同时app客户端需要删除该商品",
                    @"300":@"操作失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 2:
        {
            //4.2. 查看清单列表（需要权限）
            dic = @{@"200":@"获取数据成功",
                    @"300":@"获取数据失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 3:
        {
            //4.3. 删除清单（需要权限）
            dic = @{@"200":@"删除成功",
                    @"300":@"删除失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列5  夺宝模块
+ (NSString *)hintStringSeries_5_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //5.1. 查看用户夺宝列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 2:
        {
            //5.2. 查看用户夺宝详情（暂时弃用）
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 3:
        {
            //5.3. 查看用户夺宝号码（暂时弃用）
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 4:
        {
            //5.4. 查看用户中奖记录列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 5:
        {
            //5.5. 获取最新中奖用户列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 6:
        {
            //5.6. 查看商品详情中夺宝记录列表
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 7:
        {
            //5.7. 查看往期揭晓
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 8:
        {
            //5.8. 查看夺宝中奖信息
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 9:
        {
            //5.9. 查看用户夺宝号码列表
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 10:
        {
            //5.10. 获取用户的余额和红包（需要权限）
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 12:
        {
            //5.12. 下单/支付（需要权限)
            dic = @{@"200":@"操作成功",
                    @"301":@"没有夺宝商品",
                    @"302":@"购买人次不能小于1",
                    @"303":@"请选择支付方式",
                    @"304":@"红包不可用",
                    @"305":@"余额不足",
                    @"306":@"不支持除微信和支付宝外的其他第三方支付",
                    @"307":@"需要微信或支付宝支付的金额不能小于等于1",
                    @"308":@"实际需要微信或支付宝支付的金额与传人的参数不一致",
                    @"309":@"十元夺宝的商品购买人次必须能被10整除",
                    @"310":@"你选择的期号已买满，不能夺宝",
                    @"311":@"不支持微信支付",
                    @"312":@"不支持支付宝支付",
                    @"313":@"请选择应用类型",
                    @"314":@"一次只能使用一个红包",
                    @"315":@"使用的红包不符合满减要求",
                    @"316":@"红包已过期",
                    @"320":@"微信或支付宝支付失败",
                    @"330":@"用户错误",
                    @"300":@"操作失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 13:
        {
            //5.13. 获取支付结果（需要权限）
            dic = @{@"200":@"获取成功",
                    @"301":@"获取失败，参数错误",
                    @"300":@"获取失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 14:
        {
            //5.14. 微信/支付宝取消支付（需要权限）
            dic = @{@"200":@"取消成功",
                    @"301":@"取消失败，参数错误",
                    @"302":@"不能取消非本人的订单",
                    @"303":@"只能取消未支付的订单",
                    @"300":@"取消失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 15:
        {
            //5.15. 支付宝支付通知后台等待支付结果(弃用)
            dic = @{@"200":@"取消成功",
                    @"301":@"取消失败，参数错误",
                    @"302":@"不能取消非本人的订单",
                    @"303":@"只能取消未支付的订单",
                    @"300":@"取消失败"};
            
        }
            break;
        case 16:
        {
            //5.16. 充值下单（需要权限）
            dic = @{@"200":@"操作成功",
                    @"301":@"仅支持微信或支付宝支付充值",
                    @"302":@"充值金额范围在1-10000000之间",
                    @"311":@"不支持微信支付",
                    @"312":@"不支持支付宝支付",
                    @"320":@"微信或支付宝支付失败",
                    @"330":@"用户错误",
                    @"300":@"操作失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 17:
        {
            //5.17. 取消充值（需要权限）
            dic = @{@"200":@"取消成功",
                    @"301":@"取消失败，参数错误",
                    @"302":@"不能取消非本人的充值",
                    @"303":@"只能取消未支付的充值",
                    @"300":@"取消失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 18:
        {
            //5.18. 查看充值记录（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
            
        }
            break;
        case 19:
        {
            //5.19. 查看充值结果
            dic = @{@"200":@"获取成功",
                    @"301":@"商户订单号错误",
                    @"300":@"获取失败",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 20:
        {
            //5.20. 查看开奖结果
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 21:
        {
            //5.21. 查看中奖记录明细
            dic = @{@"200":@"获取成功",
                    @"301":@"参数错误",
                    @"300":@"获取失败"};
        }
            break;
        case 22:
        {
            //5.22. 确认收货地址（需要权限）
            dic = @{@"200":@"成功",
                    @"301":@"参数错误",
                    @"302":@"状态不正确，不能确认收货地址",
                    @"303":@"不能操作非本人的数据",
                    @"304":@"请选择收货地址",
                    @"305":@"只能选择自己的收货地址",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 23:
        {
            //5.23. 确认收货（需要权限）
            dic = @{@"200":@"取消成功",
                    @"301":@"参数错误",
                    @"302":@"状态不正确，不能确认收货地址",
                    @"303":@"不能操作非本人的数据",
                    @"300":@"取消失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 24:
        {
            //5.24. iOS查询是否屏蔽爱贝支付
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列6  晒单分享模块
+ (NSString *)hintStringSeries_6_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //6.1. 查看晒单分享列表
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 2:
        {
            //6.2. 查看晒单详情
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        case 3:
        {
            //6.3. 我的晒单（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 4:
        {
            //6.4. 晒单分享（需要权限）
            dic = @{@"200":@"成功",
                    @"301":@"主题不少于6个字",
                    @"302":@"主题不超过32个字",
                    @"303":@"获奖感言不少于30个字",
                    @"304":@"获奖感言不超过300个字",
                    @"305":@"请上传图片",
                    @"306":@"最多上传6张图片",
                    @"307":@"已晒单",
                    @"308":@"只能发布本人的晒单",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 5:
        {
            //6.5. 首页晒单/用户晒单列表
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列7  积分模块
+ (NSString *)hintStringSeries_7_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //7.1. 查看积分记录（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 2:
        {
            //7.2. 查看个人积分（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 3:
        {
            //7.3. 积分抽红包（需要权限）
            dic = @{@"200":@"成功",
                    @"301":@"积分不够100，不能抽奖",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
}

// 系列8  红包模块
+ (NSString *)hintStringSeries_8_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //8.1. 看红包列表查（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 2:
        {
            //8.2. 分享抽夺宝红包（需要权限）
            dic = @{@"200":@"成功",
                    @"301":@"活动已结束",
                    @"302":@"已抽奖，不能重复抽奖",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 3:
        {
            //8.3. 推荐码页面（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
        case 4:
        {
            //8.4. 推荐码抽夺宝红包（需要权限）
            dic = @{@"200":@"成功",
                    @"301":@"红包不存在",
                    @"302":@"非本人红包，不能抽奖",
                    @"303":@"已抽奖，不能重复抽奖",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
            
        case 5:
        {
            //8.5. 获取生活类红包（需要权限）
            dic = @{@"200":@"成功",
                    @"301":@"抱歉，只能获取一次",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
            
        case 6:
        {
            //8.6. 查看推荐记录（需要权限）
            dic = @{@"200":@"成功",
                    @"300":@"失败",
                    @"398":@"签名无效",
                    @"399":@"未登录或登录失效"};
        }
            break;
            
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列11  其他模块
+ (NSString *)hintStringSeries_11_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //11.1. 查询首页顶部图片切换
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 3:
        {
            //11.3. 获取启动页图片
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        case 4:
        {
            //11.4. 获取当前皮肤主题
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
            
        case 5:
        {
            //11.5. 获取广告页图片
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
            
        case 6:
        {
            //11.6. 通知服务端推送分享红包消息
            dic = @{@"200":@"成功",
                    @"300":@"失败"};
        }
            break;
            
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}

// 系列12  发现模块
+ (NSString *)hintStringSeries_12_WithSecondCode:(int)secondCode state:(NSString *)state
{
    NSString *hintString = errorDefault;
    
    NSDictionary *dic = nil;
    
    switch (secondCode) {
        case 1:
        {
            //12.1. 查询发现分类
            dic = @{@"200":@"获取成功",
                    @"300":@"获取失败"};
        }
            break;
        default:
            break;
    }
    
    if(!dic)
        return errorDefault;
    
    hintString = [dic objectForKey:state];
    
    if (hintString.length < 1) return errorDefault;
    
    return hintString;
    
}
*/


@end



