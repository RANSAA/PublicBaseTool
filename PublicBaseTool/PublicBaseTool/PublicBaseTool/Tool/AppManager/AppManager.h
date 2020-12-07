//
//  AppManager.h
//  收米
//
//  Created by Mac on 2018/11/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

/**
 * 用户个人信息管理，以及一些登录状态
 **/


#import "UserInfoCacheModel.h"
#import "LoginResult.h"
#import "LoginInfoResult.h"

//登录类型
typedef NS_ENUM(NSInteger, UserLoginType){
    UserLoginTypeUnknown    = 0,//未知
    UserLoginTypeTel        = 1,
    UserLoginTypeQQ         = 2,
    UserLoginTypeWeiXin     = 3
};

@interface AppManager : BaseModel
/** 用户sesstion-用作登录有效期判断 */
@property(nonatomic, copy)NSString *sessionid;//token
/** uid */
@property(nonatomic, copy)NSString *uid;
/** 上一个用户的uid */
@property(nonatomic, copy)NSString *lastUid;

/** 当前用户是否登录，利用sesstionid的值进行判断的 */
@property(nonatomic, assign)BOOL isLogin;
/** 明文Tel */
@property(nonatomic, copy)NSString *loginTel;
/** 明文pwd */
@property(nonatomic, copy)NSString *loginPwd;



/** 是否设置了支付安全密码 */
@property(nonatomic, assign)BOOL isPayPwd;
/** 是否设置了手势密码 */
@property(nonatomic, assign)BOOL isGesturePwd;
/** 明文pwd */
@property(nonatomic, strong)NSString *gesturePwdStr;
/** 是否设置了指纹密码 */
@property(nonatomic, assign)BOOL isTouchPwd;
/** 该用户是否实名认证了 */
@property(nonatomic, assign)BOOL isRealName;

/** 当前登录类型 */
@property(nonatomic, assign)UserLoginType loginType;


/** 登录成功响应数据信息-成教 */
@property(nonatomic, strong)LoginResult *loginResult;

/** 登录成功相应数据--过程性系统评价 **/
@property(nonatomic, strong)LoginInfoResult *loginInfoResult;


//用户塞选-专业ID
@property(nonatomic, copy) NSString *selectedSpecialtyID;
//用户塞选-班级ID
@property(nonatomic, copy) NSString *selectedSchoolID;
//用户塞选-班级名称
@property(nonatomic, copy) NSString *selectedSchoolName;



#pragma mark 一些通用的附加信息
/** 用户头像 */
@property(nonatomic, copy)NSString *headUrl;
/** 不完全显示的手机号 */
@property(nonatomic, copy)NSString *telHiden;
/** 用户昵称 */
@property(nonatomic, copy)NSString *nickName;
/** 心情描述 **/
@property(nonatomic, copy)NSString *starRemark;

/** 个人中心是否显示提示信息 **/
@property(nonatomic, assign) BOOL isShowTipsInUser;


#pragma mark 接口校验相关属性
@property (nonatomic, copy)   NSString  *token;
@property (nonatomic, copy)   NSString  *refresh_token;
@property (nonatomic, assign) NSInteger expire;
@property (nonatomic, assign) NSInteger refresh_expire;



+ (instancetype)shared;
/** 将用户数据保存到本地 */
- (void)saveToLocal;
/** 保存用户账号，密码--现在不做加密操作了 */
- (void)setLoginTel:(NSString *)tel pwd:(NSString *)pwd;
/** 退出登录,并保存 */
- (void)logoutAndSave;
/** 退出登录，只修改登录状态，不修改其它数据 */
- (void)logout;

/** 设置替换掉的单利 **/
- (void)setAppManagerWith:(AppManager *)tmpObj;




@end
