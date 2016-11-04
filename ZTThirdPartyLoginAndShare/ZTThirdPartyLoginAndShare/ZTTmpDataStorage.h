//
//  ZTTmpDataStorage.h
//  ZTLife
//
//  Created by raven on 16/4/5.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import <Foundation/Foundation.h>

// 第三方登录用处
typedef NS_ENUM(NSInteger, ZTTHIRDPARTYTYPE) {
    
    Other                   = 0,    //其他
    WeiXinLogin             = 1,    //微信登录
    CricleShare             = 2,    //微信朋友圈分享
    ShareGetRedPacket       = 3,    //分享得红包
    WeiXinGoodFriendShare   = 4,    //微信好友分享
    QQGoodFriendShare       = 5,    //QQ好友分享
    QQFriendCircle          = 6     //QQ空间分享
};

// TabBarController 点击Index
typedef NS_ENUM(NSInteger, TABBARSELECTINDEX) {
    
    HomeSelectIndex     = 0,    //主页
    QuickBuySelectIndex = 1,    //快购
    DiscoverSelectIndex = 2,    //发现
    ListSelectIndex     = 3,    //清单
    MineSelectIndex     = 4     //我的
};

// 用户登录方式
typedef NS_ENUM(NSInteger,USERLOGINTYPE)
{
    UNLogin           = 0,  //未登录
    LoginByPhoneNum   = 1,  //手机号码登录
    LoginByThirdParty = 2,  //第三方平台登录，暂时包括微信、QQ登录
    LoginByQQ         = 3,  //QQ登录
    LoginByWeiXin     = 4   //微信登录
    
};

@interface ZTTmpDataStorage : NSObject







/** 第三方登录 0:其他 1:微信登录 2:微信朋友圈 3:分享得红包 4:微信好友 5:QQ好友分享 6:QQ空间*/
@property (nonatomic, assign) ZTTHIRDPARTYTYPE thirdPartyType;

/** TabBarController SelectIndex 0:主页 1:快购 2:发现 3:清单 4:我的 */
@property (nonatomic, assign) TABBARSELECTINDEX tabbarSelectIndex;

/** 用户登录类型 0:未登录 1:手机号码登录 2:第三方平台登录，暂时包括微信、QQ登录 3:QQ登录 4:微信登录 */
@property (nonatomic, assign) USERLOGINTYPE userLoginType;

/**
 *  单例
 *
 *  @return ZTTmpDataStorage
 */
+ (ZTTmpDataStorage *)shareInstance;



///** 第三方登录 0:其他 1:微信登录 2:微信朋友圈 3:分享得红包 4:微信好友 5:QQ好友分享 6:QQ空间*/
//+ (ZTTHIRDPARTYTYPE)thirdPartyType;
//
///** TabBarController SelectIndex 0:主页 1:快购 2:发现 3:清单 4:我的 */
//+ (TABBARSELECTINDEX)tabbarSelectIndex;
//
//
///** 用户登录类型 0:未登录 1:手机号码登录 2:第三方平台登录，暂时包括微信、QQ登录 3:QQ登录 4:微信登录 */
//+ (USERLOGINTYPE)userLoginType;


@end
