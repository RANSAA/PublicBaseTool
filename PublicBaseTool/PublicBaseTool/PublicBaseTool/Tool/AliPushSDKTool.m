//
//  AliPushSDKTool.m
//  Evaluate
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AliPushSDKTool.h"

@implementation AliPushSDKTool

/**
 阿里云推送： 初始化CloudPushSDK
 **/
+ (void)initCloudPushSDK
{
    if ([self isSimulator]) {
        return;
    }
    [CloudPushSDK asyncInit:@"27706109" appSecret:@"0778b18551c22d16e076836326800614" callback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
        } else {
            NSLog(@"Push SDK init failed, error: %@", res.error);
        }
    }];
}

/**
 阿里云推送： 绑定设备到指定账号
 **/
+ (void)bingAccountToAliPush
{
    if ([self isSimulator]) {
        return;
    }
    if ([AppManager shared].isLogin) {
        [CloudPushSDK bindAccount:[AppManager shared].uid withCallback:^(CloudPushCallbackResult *res) {
            if (res.success) {
                TKLog(@"Push SDK 账号绑定成功 uid:%@",[AppManager shared].uid);
            }else{
                TKLog(@"Push SDK 账号绑定失败:%@",res.error);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self bingAccountToAliPush];
                });
            }
        }];
    }
}

/**
 阿里云推送： 解除账号账号,并且移出已经存在的通知
 **/
+ (void)unbingAccountWithAliPush
{
    if ([self isSimulator]) {
        return;
    }
    //解除账号
    [CloudPushSDK unbindAccount:^(CloudPushCallbackResult *res) {
        TKLog(@"Push SDK 账号解绑成功");
    }];
    //清除通知
    [self cleanAllNotifactions];
}

/** 同步通知角标数到服务端 */
+ (void)syncBadgeNum:(NSUInteger)badgeNum
{
    if ([self isSimulator]) {
        return;
    }
    [CloudPushSDK syncBadgeNum:badgeNum withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            TKLog(@"Push SDK Sync badge num: [%lu] success.", (unsigned long)badgeNum);
        } else {
            TKLog(@"Push SDK Sync badge num: [%lu] failed, error: %@", (unsigned long)badgeNum, res.error);
        }
    }];
}


/**
 清除所有推送通知通知
 **/
+ (void)cleanAllNotifactions
{
    if ([self isSimulator]) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        UIApplication *application = [UIApplication sharedApplication];
        application.applicationIconBadgeNumber = -1;
        application.applicationIconBadgeNumber = 0;
        if (@available(iOS 10.0, *)) {
            UNUserNotificationCenter *_notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
            [_notificationCenter removeAllPendingNotificationRequests];
        } else {
            [application cancelAllLocalNotifications];
        }
        [self syncBadgeNum:0];
    });
}

/**
 检查当前是否是模拟器
 **/
+ (BOOL)isSimulator
{
    BOOL isSimulator = NO;
#if TARGET_OS_SIMULATOR
    isSimulator = YES;
#endif
    return isSimulator;
}



@end
