//
//  EnumManager.h
//  AdultLP
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

/**
文件说明：用于管理一些枚举类型
*/

#ifndef EnumManager_h
#define EnumManager_h

/** 请求结果返回code说明 */
typedef NS_ENUM(NSInteger, ResultCodeStatus) {
    ResultCodeStatusSuccess      = 200, //请求成功
    ResultCodeStatusRelogin      = -4,  //账号在其它设备登录,重新登录
    ResultCodeStatusRelogin1     = -3,  //账号在其它设备登录,重新登录
    ResultCodeStatusTokenInvalid = -2,  //token过期，refresh
    
};

#endif /* EnumManager_h */
