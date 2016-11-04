//
//  ZTThirdLoginModel.h
//  ZTLife
//
//  Created by Leo on 16/2/15.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTThirdLoginModel : NSObject

@property (nonatomic,strong) NSString *nickname;            /**<用户昵称 */
@property (nonatomic,strong) NSString *figureurl_qq_2;      /**<用户头像 */
@property (nonatomic,strong) NSString *gender;              /**<用户性别 */

// 微信里面的
@property (nonatomic,strong) NSString *access_token;
@property (nonatomic,strong) NSString *openid;
@property (nonatomic,strong) NSString *headimgurl;         /**<用户头像 */
@property (nonatomic,assign) int sex;                      /**<用户性别 */

@end
