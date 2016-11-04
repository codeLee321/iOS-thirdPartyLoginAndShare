//
//  ViewController.m
//  ZTThirdPartyLoginAndShare
//
//  Created by tony on 16/9/23.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import "ViewController.h"
#import "ZTThirdPartyLogin.h"
#import "ZTTmpDataStorage.h"
@interface ViewController ()<ZTThirdPartyLoginDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**<QQ登录演示*/
-(void)forQQLogin{
    
    ZTThirdPartyLogin *thirdLogin = [ZTThirdPartyLogin thirdPartyLogin];
    thirdLogin.delegate = self;
    [thirdLogin qqLogin];

}
/**<Wechat登录演示*/
-(void)foeWechatLogin{
 
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo,snsapi_base";
    req.state = @"123" ;
    [WXApi sendReq:req];
    ZTThirdPartyLogin *thirdLogin = [ZTThirdPartyLogin thirdPartyLogin]; // 这个是测试的版本
    [ZTTmpDataStorage shareInstance].thirdPartyType = WeiXinLogin;
    thirdLogin.delegate = self;



}


/**<分享到各平台直接调取接口即可*  详细见ZTThirdPartyLogin.h*/



#pragma mark - 三方登录自定义代理方法
//- (void)getUserInfoModel:(ZTThirdLoginModel *)thirdLoginModel andOpenId:(NSString *)openId {
//    
//    int genderId;
//    if ([thirdLoginModel.gender isEqualToString:@"女"]) {
//        genderId = 0;
//    } else if ([thirdLoginModel.gender isEqualToString:@"男"]) {
//        genderId = 1;
//    } else {
//        genderId = 2;
//    }
//    
//    NSString *headImageUrl;
//    if ([NSString stringWithFormat:@"%d",self.fromId] == nil) {
//        return;
//    }
//    
//    if (self.fromId == 2) {
//        headImageUrl = thirdLoginModel.headimgurl;
//    } else if (self.fromId == 3) {
//        headImageUrl = thirdLoginModel.figureurl_qq_2;
//    }
//    
//    NSString *strNickName = [thirdLoginModel.nickname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    
//    NSDictionary *params = @{
//                             @"openId" : openId,
//                             @"nickName" :strNickName,
//                             @"gender" : @(genderId),
//                             @"headImg" : headImageUrl,
//                             @"source" : @(self.fromId)
//                             };
//    
//    __weak typeof(self)safeSelf = self;
//    [ZTHttpTool nonJSONPOST:kLogin4OtherUrl parameters:params hud:YES success:^(id responseObject) {
//        int state = [responseObject[@"state"] intValue];
//        if (state == 200) {
//            [ZTTmpDataStorage shareInstance].userLoginType = LoginByThirdParty;
//            [[ZTOperation shareInstance] defaultObjectSetWithKey:kToken object:responseObject[@"data"][@"token"]];
//            [[ZTOperation shareInstance]defaultObjectSetWithKey:kUserId object:responseObject[@"data"][@"userId"]];
//            
//            //第三方登录成功发送至友盟
//            [MobClick profileSignInWithPUID:kUserId provider:@"第三方登录"];
//            
//            // 注册完成设置极光alias
//            NSString *stringAlias = [NSString stringWithFormat:@"%@",kGetUserId];
//            
//            [[ZTOperation shareInstance] JPushAliasWithBlock:stringAlias block:^(int iResCode, NSString *alias) {
//                
//            }];
//            
//            [safeSelf jumpToViewController];
//        }
//        
//        [ZTHttpHint SVShowErrorWithState:state APICode:@"2.20"];
//        
//    } failure:^(NSError *error) {
//        [ZTHttpHint SVShowNetWorkError];
//    }];
//}

@end
