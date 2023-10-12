//
//  TouchIDManager.m
//  ExampleProject
//
//  Created by kimi on 2023/10/12.
//

#import "TouchIDManager.h"
#import <LocalAuthentication/LocalAuthentication.h>



@implementation TouchIDManager

+ (instancetype)shared
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self.class alloc] init];
    });
    return obj;
}



//MARK: - 开始指纹认证
/**
 开始指纹认证
 success： 是否成功
 msg：提示信息
 */
- (void)startTouchIDWithCompare:(void(^)(BOOL success ,NSString* msg))result
{
    __block BOOL isSuccess = NO;
    __block NSString *msg  = @"";
    BOOL isSupport = [self isSupportTouchID];
    if(isSupport){
        LAContext *context = [[LAContext alloc]init];
        context.localizedFallbackTitle = @"输入密码";
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"请验证已有指纹" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                isSuccess = YES;
                msg = @"TouchID 校验成功";
            }else{
                isSuccess = NO;
                msg = @"TouchID 校验失败";
            }
            if (result) {
                result(isSuccess, msg);
            }
        }];
    }else{
        msg = @"该设备不支持Touch ID";
        if(result){
            result(NO,msg);
        }
    }
}



//MARK: - 检查设备是否支持Touch ID

/**
 功能：检查设备是否是否支持Touch ID
 PS:
 https://www.jianshu.com/p/d44b7d85e0a6
 https://www.jb51.net/article/138588.htm
 */
- (BOOL)isSupportTouchID
{
    BOOL isSupport = NO;
    if(@available(iOS 9, *)){
        LAContext *context = [[LAContext alloc]init];
        NSError *error = nil;
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            if (error) {
                isSupport = NO;
                [self checkLAErrorWith:error];
            }else{
                isSupport = YES;
            }
        }
    }
    return isSupport;
}


/**
 错误信息提示与处理
 */
- (void)checkLAErrorWith:(NSError *)error
{
    //msg
    NSString *msg = [NSString stringWithFormat:@"%@",error];
    //向用户提示的信息
    NSString *tipsMsg = @"";
    //标记是否需要弹出系统锁屏界面  --> 需要用户手动输入密码 -弹出输入框
    BOOL isShowLockAlert = NO;
    switch (error.code) {
        case LAErrorAuthenticationFailed:
            msg = @"TouchID 验证失败";
            break;
        case LAErrorUserCancel:
            msg = @"TouchID 被用户手动取消";
            break;
        case LAErrorUserFallback:
            msg = @"用户不使用TouchID,选择手动输入密码";
            break;
        case LAErrorSystemCancel:
            msg = @"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)";
            break;
        case LAErrorPasscodeNotSet://请先设置Touch ID - 提示
            msg = @"TouchID 无法启动,因为用户没有设置密码";
            tipsMsg = @"请先设置TouchID";
            break;
        case LAErrorTouchIDNotEnrolled: //请先添加指纹 - 提示
            msg = @"TouchID 无法启动,因为用户没有设置TouchID";
            tipsMsg = @"请先添加指纹";
            break;
        case LAErrorTouchIDNotAvailable:
            msg = @"TouchID 无效";
            break;
        case LAErrorTouchIDLockout://需要用户手动输入密码 -弹出输入框
            isShowLockAlert = YES;
            msg = @"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)";
            break;
        case LAErrorAppCancel:
            msg = @"当前软件被挂起并取消了授权 (如App进入了后台等)";
            break;
        case LAErrorInvalidContext:
            msg = @"当前软件被挂起并取消了授权 (LAContext对象无效)";
            break;
        default:
            break;
    }
    
    
    [self logTipsMsg:msg];
    if(tipsMsg.length > 0 ){
        [self showTipsMsgWith:tipsMsg];
    }
}

#pragma mark 提示用户信息
- (void)showTipsMsgWith:(NSString *)msg
{
    //提示信息给用户看的
    NSLog(@"show view:%@",msg);
}

#pragma mark 输出提示信息
- (void)logTipsMsg:(NSString *)msg
{
    NSLog(@"%@", msg);
}


@end
