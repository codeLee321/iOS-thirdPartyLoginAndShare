//
//  ZTThirdPartyLogin.h
//  ZTLife
//
//  Created by Leo on 16/2/15.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "ZTHttpHint.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

typedef NS_ENUM(NSInteger, ZTWechatShareType) {
    ZTWechatShareTypeGoodFriend         = 1 << 0,             /**< 微信好友 */
    ZTWechatShareTypeFriendCircle       = 1 << 1              /**< 微信朋友圈 */
};

@class ZTThirdLoginModel;

@protocol ZTThirdPartyLoginDelegate <NSObject>

@optional

- (void)getUserInfoModel:(ZTThirdLoginModel *)thirdLoginModel andOpenId:(NSString *)openId;

@end

@interface ZTThirdPartyLogin : NSObject<WXApiDelegate>

@property (nonatomic,strong) id<ZTThirdPartyLoginDelegate>delegate;

+ (instancetype)thirdPartyLogin;

/**
 *   QQ登录
 */
- (void)qqLogin;

/**
 *  分享到微信好友或朋友圈
 *
 *  @param shareParam 分享的内容字典
 *  @param shareType  分享的类型
 */
- (void)shareToWechat:(NSDictionary *)shareParam shareType:(ZTWechatShareType)shareType;

/**
 *  QQ空间分享
 *
 *  @param shareParam 分享的内容字典
 */
- (void)QQZoneShare:(NSDictionary *)shareParam;

/**
 *  QQ好友分享
 *
 *  @param shareParam 分享的内容字典
 */
- (void)sendWebMessageToQQ:(NSDictionary *)shareParam;

//
///**
// *   QQ登录
// */
//- (void)qqLogin;
//
//- (void)shareToFriendCircle:(NSDictionary *)shareParam;

@end
