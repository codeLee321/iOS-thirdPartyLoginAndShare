//
//  ZTHub.m
//  ZTHub
//
//  Created by raven on 16/5/7.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#define ZTkeyWindow     [UIApplication sharedApplication].keyWindow
#define kHubScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kHubScreenWidth    [UIScreen mainScreen].bounds.size.width


#define textFont [UIFont systemFontOfSize:12.0f]

#define kBgColor [UIColor colorWithRed:233/255.0f green:233/255.0f blue:233/255.0f alpha:1] //背景颜色
#define kIconSuccess    @"iconSuccess"  //成功图标
#define kIconError      @"iconError"    //失败图标
#define kIconHeight     40.0f           //图片高度
#define kIconWidth      40.0f           //图片宽度

#define levelSpace 65                   //水平间距

#define HubShowTime 1.5                 //停留时间

#import "ZTHub.h"

@interface ZTHub ()

@property (nonatomic,strong) UIView *hubView;
@property (nonatomic,strong) UIView *loadingView;
@property (nonatomic,strong) NSString *stringShow;  //显示string

@property (nonatomic,assign) float defaultWidth;    //HubView宽度
@property (nonatomic,assign) float defaultHeight;   //HubView高度
@property (nonatomic,assign) int   timerHubShow;    //HubView显示时长

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZTHub

/**
 *  单例
 *
 *  @return ZTTmpDataStorage
 */
+ (ZTHub *)shareInstance
{
    static ZTHub *_shareInstance = nil;
    
    static dispatch_once_t onePredicate;
    
    dispatch_once(&onePredicate, ^{
        _shareInstance = [[ZTHub alloc] init];
    });
    
    return _shareInstance;
}

#pragma publish method - - - - - - - - - - - - - - - - - - - - - - - - -
// 纯文字
+ (void)HubWithString:(NSString *)string
{
    [[self shareInstance]HubWithString:string];
}

// 显示gif动态图片
+ (void)HubWithGif
{
    [[self shareInstance]HubWithGif];
}

// 自定义显示gif动态图片
+ (void)HubWithGif:(NSString *)imgName andType:(NSString *)type
{
    [[self shareInstance]HubWithGif:imgName andType:type];
}

// 自定义图片+文字
+ (void)HubImageWithString:(NSString *)imgName message:(NSString *)string
{
    [[self shareInstance]HubImageWithString:imgName message:string];
}

// 显示错误提示
+ (void)HubWithErrorString:(NSString *)string
{
    [[self shareInstance]HubWithErrorString:string];
}

// 显示成功提示
+ (void)HubWithSuccessString:(NSString *)string
{
    [[self shareInstance]HubWithSuccessString:string];
}

// 关闭提示框
+ (void)Dismiss
{
    [[self shareInstance]Dismiss];
}

// 关闭加载提示框
+ (void)DismissLoading
{
    [[self shareInstance]DismissLoading];
}

#pragma private method - - - - - - - - - - - - - - - - - - - - - - - - -

- (void)HubImageWithString:(NSString *)imgName message:(NSString *)string
{
    self.stringShow = string;
    
    [self createHubViewWithStyle:ImageStringStyle];
    
    float imgWidth = kIconWidth;
    float imgHeight = kIconHeight;
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((self.defaultWidth - imgWidth)/2, 15, imgWidth, imgHeight)];
    img.image = [UIImage imageNamed:imgName];
    
    
    float lblY = img.frame.origin.y + img.frame.size.height - 5;
    float lblHeight = self.defaultHeight - lblY;
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, lblY, self.defaultWidth - 15, lblHeight)];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.numberOfLines = 0;
    lbl.text = string;
    lbl.font = textFont;
    lbl.adjustsFontSizeToFitWidth = YES;
    [self.hubView addSubview:img];
    [self.hubView addSubview:lbl];
}

- (void)HubWithErrorString:(NSString *)string
{
    [self HubImageWithString:kIconError message:string];
}

- (void)HubWithSuccessString:(NSString *)string
{
    [self HubImageWithString:kIconSuccess message:string];
}


- (void)HubWithString:(NSString *)string
{
    self.stringShow = string;
    
    [self createHubViewWithStyle:StringStyle];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.defaultWidth - 30, self.defaultHeight)];
    
    lbl.text = string;
    
    lbl.textAlignment = NSTextAlignmentCenter;
    
    lbl.font = textFont;
    
    lbl.numberOfLines = 0;
    
    lbl.adjustsFontSizeToFitWidth = YES;
    
    [self.hubView addSubview:lbl];
}


- (void)HubWithGif
{
    [self HubWithGif:@"fresh_" andType:@"png"];
}


- (void)HubWithGif:(NSString *)imgName andType:(NSString *)type
{
    [self createLoadingView];
    
    self.loadingView.backgroundColor = [UIColor clearColor];
    
    NSMutableArray * imageArray = [NSMutableArray array];
    for(int i = 1 ;i < 26 ; i++)
    {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.%@",imgName,i,type]];
        [imageArray addObject:image];
    }
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.defaultWidth, self.defaultHeight)];
    img.animationImages = imageArray;
    img.contentMode = UIViewContentModeScaleAspectFit;
//    annimationImageView.animationDuration = 1.0f;
//    annimationImageView.animationRepeatCount = 3;
    [img startAnimating];
   // img.center = self.hubView.center;
    [self.loadingView addSubview:img];
    
    [self LoadingViewConfign];
}

- (void)Dismiss
{
    CGAffineTransform  transform;
    
    transform = CGAffineTransformScale(self.hubView.transform,0.1,0.1);
    
    CGAffineTransform newTransform = CGAffineTransformMakeScale(1.2, 1.2);
    
    [UIView animateWithDuration:0.1 animations:^{
        
        [self.hubView setTransform:newTransform];
    }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.2 animations:^{
                             [self.hubView setAlpha:0];
                             [self.hubView setTransform:transform];
                         } completion:^(BOOL finished){
                             [self.hubView removeFromSuperview];
                             self.hubView = nil;
                         }];
                     }];
    
}


- (void)DismissLoading
{
    if(self.loadingView)
    {
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }
}


- (void)createLoadingView
{
    if(self.loadingView)
    {
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }
    
   // [self Dismiss];
    
    self.loadingView = [[UIView alloc] init];
    
    self.defaultWidth = 50;
    self.defaultHeight = 70;
    
    self.loadingView.frame = CGRectMake((kHubScreenWidth - self.defaultWidth)/2,kHubScreenHeight * 0.3, self.defaultWidth, self.defaultHeight);
}

- (void)createHubViewWithStyle:(HubStyle)style
{   
    if(self.hubView)
    {
        // 重置时间
        [self.hubView removeFromSuperview];
         self.hubView = nil;
    }
    
    self.hubView = [[UIView alloc]init];
    
    [self DismissLoading];
    
    switch (style) {
        case StringStyle:
        {
            // 纯文字样式
            self.defaultWidth = kHubScreenWidth - levelSpace*2;
            self.defaultHeight = [self labelHeight:self.stringShow font:textFont width:self.defaultWidth] + 20;
           
        }
        break;
        case ImageStringStyle:
        {
            // 图片+文字
            self.defaultWidth = 160;
            self.defaultHeight = [self labelHeight:self.stringShow font:textFont width:self.defaultWidth] + kIconHeight + 15;
        }
            break;
        case ImageGifStyle:
        {
            // 动态图片样式
            self.defaultWidth = 70;
            self.defaultHeight = 90;
        }
            break;
        default:
        {
            
        }
            break;
    }

    self.hubView.frame = CGRectMake((kHubScreenWidth - self.defaultWidth)/2,kHubScreenHeight * 0.3, self.defaultWidth, self.defaultHeight);
    
    [self HubViewConfign];
    
    // 设置时间 - 移除hubview
    if(self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:HubShowTime target:self selector:@selector(reciprocalDismissWithTime) userInfo:nil repeats:YES];
}

// 定时关闭提示框
- (void)reciprocalDismissWithTime
{
    self.timerHubShow = HubShowTime;
//    
//    self.timerHubShow --;
//    
//    if(self.timerHubShow < 1)
//    {
         NSLog(@"%d",self.timerHubShow);
        
        [self.timer invalidate];
        self.timer = nil;
        [self Dismiss];
//    }

}


#pragma confign UI - - - - - - - - - - - - - - - - - - - - - - - - -

//  提示框的样式配置、弹出动画
- (void)HubViewConfign
{
    self.hubView.backgroundColor = kBgColor;
    
    self.hubView.layer.cornerRadius = 8.0f;
    
    self.hubView.layer.masksToBounds = YES;
    
    [ZTkeyWindow addSubview:self.hubView];
    
    CGAffineTransform  transform;
    
    transform = CGAffineTransformScale(self.hubView.transform,1.2,1.2);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.hubView.alpha = 1;
        
        [self.hubView setTransform:transform];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

//  提示框的样式配置、弹出动画
- (void)LoadingViewConfign
{
    self.loadingView.backgroundColor = [UIColor clearColor];
    
    self.loadingView.layer.cornerRadius = 8.0f;
    
    self.loadingView.layer.masksToBounds = YES;
    
    [ZTkeyWindow addSubview:self.loadingView];
    
    CGAffineTransform  transform;
    
    transform = CGAffineTransformScale(self.loadingView.transform,1.2,1.2);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.loadingView.alpha = 1;
        
        [self.loadingView setTransform:transform];
        
    } completion:^(BOOL finished) {
        
    }];

}

#pragma logic method - - - - - - - - - - - - - - - - - - - - - - - - -
- (float)labelHeight:(NSString*)aString font:(UIFont *)font width:(float)width
{
    float defaultHeight = 20.0f;
    
    float returnHeight = 0;
    
    returnHeight = [self contentSize:aString font:font width:width].height;
    
    if(returnHeight < defaultHeight)
        return defaultHeight;
    
    return returnHeight + 20;
}

- (CGSize)contentSize:(NSString*)aString font:(UIFont *)font width:(float)width
{
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    NSDictionary * attributes = @{NSFontAttributeName : font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [aString boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                            attributes:attributes
                                               context:nil].size;
    return contentSize;
}

@end
