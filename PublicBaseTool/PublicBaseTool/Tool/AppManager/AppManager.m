//
//  AppManager.m
//  收米
//
//  Created by Mac on 2018/11/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "AppManager.h"

#define kAppMangerKey @"AppManagerLocalUserInfoKey"

static AppManager *obj = nil;

@implementation AppManager

#pragma mark 创建单利并获取配置信息
+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [userDefaults objectForKey:kAppMangerKey];
        id unarchiverObj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (unarchiverObj) {
            obj = unarchiverObj;
        }else{
            obj = [[AppManager alloc] init];
        }
//        TKLog(@"AppManager:%@",obj);
    });
    return obj;
}

/** 设置替换掉的单利 **/
- (void)setAppManagerWith:(AppManager *)tmpObj
{
    obj = [tmpObj copy];
}

/** 将用户数据保存到本地 */
- (void)saveToLocal
{
    NSData *archiverData = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (archiverData) {
        [userDefaults setValue:archiverData forKey:kAppMangerKey];
    }
    NSLog(@"clas:%@",self);
    [userDefaults synchronize];
}

/** 保存用户账号，密码--现在不做加密操作了 */
- (void)setLoginTel:(NSString *)tel pwd:(NSString *)pwd
{
    self.loginTel = tel;
    self.loginPwd = pwd;
    [self saveToLocal];
}



/** 该用户是否已经登录**/
- (BOOL)isLogin
{
    if (self.sessionid.length<1) {
        return NO;
    }else{
        return YES;
    }
}

///** 退出登录，只修改登录状态，不修改其它数据 */
- (void)logout
{
    self.sessionid = nil;
}

/** 退出登录,并保存 */
- (void)logoutAndSave
{
    AppManager *tmp = [[AppManager alloc] init];
    tmp.loginTel = self.loginTel;
    tmp.loginPwd = self.loginPwd;
    obj = tmp;
    [obj saveToLocal];
}


@end
