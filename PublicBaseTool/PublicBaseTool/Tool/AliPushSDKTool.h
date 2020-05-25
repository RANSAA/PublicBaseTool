//
//  AliPushSDKTool.h
//  Evaluate
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


NS_ASSUME_NONNULL_BEGIN

@interface AliPushSDKTool : NSObject

/**
 阿里云推送： 初始化CloudPushSDK
 **/
+ (void)initCloudPushSDK;

/**
 阿里云推送： 绑定设备到指定账号
 **/
+ (void)bingAccountToAliPush;

/**
 阿里云推送： 解除账号账号,并且移出已经存在的通知
**/
+ (void)unbingAccountWithAliPush;

/** 同步通知角标数到服务端 */
+ (void)syncBadgeNum:(NSUInteger)badgeNum;

/**
 清除所有推送通知通知
 **/
+ (void)cleanAllNotifactions;

/**
 检查当前是否是模拟器
 **/
+ (BOOL)isSimulator;

@end

NS_ASSUME_NONNULL_END
