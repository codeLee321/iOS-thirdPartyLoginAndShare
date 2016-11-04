//
//  ZTThirdPartyLogin.m
//  ZTLife
//
//  Created by Leo on 16/2/15.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import "ZTThirdPartyLogin.h"
#import "ZTThirdLoginModel.h"
#import "ZTTmpDataStorage.h"

@interface ZTThirdPartyLogin ()<TencentSessionDelegate>
{
    TencentOAuth *tecentOAuth;
    SendAuthResp *authResp;
}
@end
@implementation ZTThirdPartyLogin

+ (instancetype)thirdPartyLogin {
    
    static ZTThirdPartyLogin *thirdLogin;
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken ,^{
        thirdLogin = [[ZTThirdPartyLogin alloc] init];
    });
    return thirdLogin;
}

// 分享给QQ好友
- (void)sendWebMessageToQQ:(NSDictionary *)shareParam
{
    tecentOAuth = [[TencentOAuth alloc] initWithAppId:@"QQAPPId" andDelegate:self];
    
    QQApiNewsObject* img = [QQApiNewsObject objectWithURL:[NSURL URLWithString:shareParam[@"share_link"]]
                                                    title:shareParam[@"share_title"]
                                              description:shareParam[@"share_description"]
                                         previewImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:shareParam[@"share_image"]]]];
    [img setCflag:kQQAPICtrlFlagQQShare];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    
    [self handleSendResult:sent];
}

// QQ空间
- (void)QQZoneShare:(NSDictionary *)shareParam
{
    tecentOAuth=[[TencentOAuth alloc]initWithAppId:@"QQAPPId" andDelegate:self];
    
    NSURL *previewURL = [NSURL URLWithString:shareParam[@"share_image"]];
    NSURL* url = [NSURL URLWithString:shareParam[@"share_link"]];
    
    QQApiNewsObject* imgObj = [QQApiNewsObject objectWithURL:url
                                                       title:shareParam[@"share_title"]
                                                 description:shareParam[@"share_description"]
                                             previewImageURL:previewURL];
    [imgObj setTitle:shareParam[@"share_title"]];
    [imgObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    
    [self handleSendResult:sent];
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];            [msgbox show];
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void)qqLogin {
    
    tecentOAuth=[[TencentOAuth alloc]initWithAppId:@"QQAPPId" andDelegate:self];
    NSArray *permissions= [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
    [tecentOAuth authorize:permissions inSafari:NO];
}

// qq登录 代理
- (void)tencentDidNotLogin:(BOOL)cancelled {
    [ZTHttpHint SVShowErrorString:@"登录失败"];
}
- (void)tencentDidLogin {
    
    [tecentOAuth getUserInfo];
    
}
- (void)tencentDidNotNetWork {
    [ZTHttpHint SVShowNetWorkError];
}
// 在代理方法里面获取QQ中你所需的信息
- (void)getUserInfoResponse:(APIResponse*)response {
//    ZTThirdLoginModel *thirdModel = [ZTThirdLoginModel yy_modelWithJSON:response.jsonResponse];
    
    // 这里做代理传值
    if (self.delegate && [self.delegate respondsToSelector:@selector(getUserInfoModel:andOpenId:)]) {
//        [self.delegate getUserInfoModel:thirdModel andOpenId:tecentOAuth.openId];
    }
}

#pragma mark - weixin delegate
- (void)onResp:(BaseResp *)resp
{
    authResp = (SendAuthResp *)resp;
    
    __weak typeof(self)safeSelf = self;
    if (authResp.errCode == 0)
    {
//        switch ([ZTTmpDataStorage shareInstance].thirdPartyType) {
//            case WeiXinLogin:
//            {
//                NSString *weixinStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WXLoginId, WXLoginSecret, authResp.code];
//                
//                [ZTHttpTool nonJSONPOST:weixinStr parameters:nil success:^(id responseObject) {
//                  
//                    ZTThirdLoginModel *weixinModel = [ZTThirdLoginModel yy_modelWithJSON:responseObject];
//                   
//                    [safeSelf getUserMessageWithOpenid:weixinModel.openid andAccess_Token:weixinModel.access_token];
//                    
//                } failure:^(NSError *error) {
//                    [ZTHttpHint SVShowNetWorkError];
//                }];
//
//            }
//                break;
//            case CricleShare:
//            {
//                ZTFriendCircleView *shareFriendCircle = [ZTFriendCircleView show];
//                [shareFriendCircle dismiss];
//                [ZTHttpHint SVShowSuccessString:@"分享成功"];
//                
//                [ZTTmpDataStorage shareInstance].thirdPartyType = Other;
//            }
//                break;
//            case ShareGetRedPacket:
//            {                
//                [[ZTOperation shareInstance]shareGetRedPacket];
//            }
//                break;
//            case Other:
//            {
//            }
//                break;
//
//            default:
//                break;
//        }
    }
}

- (void)getUserMessageWithOpenid:(NSString *)openid andAccess_Token:(NSString *)access_token
{
    __weak typeof(self)safeSelf = self;
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", access_token, openid];
//    [ZTHttpTool nonJSONPOST:url parameters:nil success:^(id responseObject) {
//        
//        ZTThirdLoginModel *weixinModel = [ZTThirdLoginModel yy_modelWithJSON:responseObject];
//        if (weixinModel.sex == 1) {
//            weixinModel.gender = @"男";
//        } else if (weixinModel.sex == 2) {
//            weixinModel.gender = @"女";
//        }
//        
//        if (safeSelf.delegate && [safeSelf.delegate respondsToSelector:@selector(getUserInfoModel:andOpenId:)]) {
//            [safeSelf.delegate getUserInfoModel:weixinModel andOpenId:weixinModel.openid];
//        }
//        
//    } failure:^(NSError *error) {
//        [ZTHttpHint SVShowNetWorkError];
//    }];
}

- (void)shareToWechat:(NSDictionary *)shareParam shareType:(ZTWechatShareType)shareType
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = shareParam[@"share_title"];                                     /**< 分享标题 */
    message.description = shareParam[@"share_description"];                         /**< 分享描述 */
    
    NSURL *url = [NSURL URLWithString:shareParam[@"share_image"]];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    [message setThumbImage:img];                                                    /**< 分享图片 */
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = shareParam[@"share_link"];                           /**< 分享链接 */
    
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    
    int scene;
    switch (shareType) {
        case ZTWechatShareTypeGoodFriend:
            scene =  WXSceneSession;
            break;
        case ZTWechatShareTypeFriendCircle:
            scene =  WXSceneTimeline;
            break;
        default:
            break;
    }
    req.scene = scene;
    
    [WXApi sendReq:req];
}

@end
