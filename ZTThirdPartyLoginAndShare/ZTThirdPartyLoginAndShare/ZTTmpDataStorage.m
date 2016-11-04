//
//  ZTTmpDataStorage.m
//  ZTLife
//
//  Created by raven on 16/4/5.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import "ZTTmpDataStorage.h"

@implementation ZTTmpDataStorage

/**
 *  单例
 *
 *  @return ZTTmpDataStorage
 */
+ (ZTTmpDataStorage *)shareInstance
{
    static ZTTmpDataStorage *_shareInstance = nil;
    
    static dispatch_once_t onePredicate;
    
    dispatch_once(&onePredicate, ^{
        _shareInstance = [[ZTTmpDataStorage alloc] init];
    });
    
    return _shareInstance;
}

///** 第三方登录功能 类型*/
//+ (ZTTHIRDPARTYTYPE)thirdPartyType
//{
//    return [self shareInstance].thirdPartyType;
//}
//
///** 底部栏tab选中 index*/
//+ (TABBARSELECTINDEX)tabbarSelectIndex
//{
//    return [self shareInstance].tabbarSelectIndex;
//}
//
///** 用户登录类型*/
//+ (USERLOGINTYPE)userLoginType
//{
//    return [self shareInstance].userLoginType;
//}

@end
