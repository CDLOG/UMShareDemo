//
//  ViewController.m
//  shareDemo
//
//  Created by 陈乐杰 on 2018/8/3.
//  Copyright © 2018年 nst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UMSocialPlatformProvider,UMSocialShareMenuViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)shareClick:(id)sender {
    //显示分享面板
    __weak typeof(self) weakSelf = self;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [weakSelf shareToPlatformType:platformType];
    }];
}

- (IBAction)qqLogin:(id)sender {
    /**
     设置QQ授权登录
     
     @param platformType 平台
     @param result 授权成功
     @param error 授权失败
     */
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.gender);
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
}
- (IBAction)weChatLogin:(id)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.gender);
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}


//分享到指定平台
- (void)shareToPlatformType:(UMSocialPlatformType)platformType {
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    
    //创建分享的网页
    /**
     * @param title 标题
     * @param descr 描述
     * @param thumImage 缩略图（UIImage或者NSData类型，或者image_url）
     *
     */
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享到标题" descr:@"分享的描述" thumImage:[UIImage imageNamed:@"3.png"]];
    shareObject.webpageUrl = @"https://www.baidu.com/";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //判断是否安装所分享到的平台， 没安装则不分享，给出提示。
    if (![self isInstall:platformType]) {
        return ;
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        ;
        
        //分享失败
        if (error) {
            
        }else{
            if (platformType == UMSocialPlatformType_WechatTimeLine) {
                //分享到朋友圈成功
            } else {
                //分享到其他平台成功
            }
        }
    }];
}
#pragma mark 判断是否安装分享平台
- (BOOL)isInstall:(UMSocialPlatformType)platformType {
    if (![[UMSocialManager defaultManager] isInstall:platformType]) {
        if (platformType == UMSocialPlatformType_QQ) {
            //qq
            NSLog(@"未安装QQ");
        } else {
            //weixin
        }
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
