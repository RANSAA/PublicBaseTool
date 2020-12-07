//
//  TKRotateManager.m
//  AdultLP
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKRotateManager.h"

@implementation TKRotateManager{
    UIInterfaceOrientationMask lastMask;
}

+ (TKRotateManager *)shared
{
    static TKRotateManager *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[TKRotateManager alloc] init];
        obj.dirMaskType = 0;
    });
    return obj;
}


/**
 检查手机是否横屏
 */
+ (BOOL)isInterfaceLandscape
{
    if ([UIDevice TK_isInterfaceLandscape]) {
        return YES;
    }
    return NO;
}


/**
 强制设置屏幕方向：YES:强制设置为横屏(Home right) NO:强制设置屏幕方向为竖屏(Home Bottom)
 PS:强制设置屏幕方向之后，注意手动修复一下dirMaskType的值
 设置横屏之后 dirMaskType=1
 设置竖屏之后 dirMaskType=0或者2
 (当前已经修复了)
 **/
- (void)setForceHorizontalScreen:(BOOL)isHorizontal
{
    UIInterfaceOrientation mask;
    self.dirMaskType = 2;//复原
    if (isHorizontal) {
        mask = UIInterfaceOrientationLandscapeRight;
    }else{
        mask = UIInterfaceOrientationPortrait;
    }
    
    //首先设置UIInterfaceOrientationUnknown欺骗系统，避免可能出现直接设置无效的情况
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationUnknown) forKey:@"orientation"];

    [[UIDevice currentDevice] setValue:@(mask) forKey:@"orientation"];
    //刷新
//    [UIViewController attemptRotationToDeviceOrientation];
    
    //修复方向
    if (isHorizontal) {
        self.dirMaskType = 1;
    }else{
        self.dirMaskType = 0;
    }
}


/**
 保存程序上一次的方向，用于固定某个页面的方向
 PS:保存-恢复成对出现
 **/
- (void)saveLastOrientation
{
    lastMask = self.dirMaskType;
    TKLog(@"saveLastOrientation:%ld",lastMask);
}

/**
 恢复程序上一次的方向，用于固定某个页面的方向
 PS:保存-恢复成对出现
 **/
- (void)recoveryLastOrientation
{
    [self setForceHorizontalScreen:lastMask];
    TKLog(@"recoveryLastOrientation:%ld",lastMask);
}


#pragma mark 方向支持控制
- (UIInterfaceOrientationMask)dirAllMask//旋转屏幕支持的方向
{
    UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskAll;
    switch (self.dirMaskType) {
        case 0:
            mask = UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
            break;
        case 1:
            mask = UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskLandscapeLeft;
            break;
        default:
            mask = UIInterfaceOrientationMaskAll;
            break;
    }
    return mask;
}

- (UIInterfaceOrientationMask)dirCurMask//控制APP屏幕旋转方向
{
    UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskAll;
    switch (self.dirMaskType) {
        case 0:
            mask = UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
            break;
        case 1:
            mask = UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskLandscapeLeft;
            break;
        default:
            mask = UIInterfaceOrientationMaskAll;
            break;
    }
    return mask;
}

- (UIInterfaceOrientation)dirDefaultMask
{
    UIInterfaceOrientation mask = UIInterfaceOrientationPortrait;
    switch (self.dirMaskType) {
        case 0:
            mask = UIInterfaceOrientationPortrait;
            break;
        case 1:
            mask = UIInterfaceOrientationLandscapeRight;
            break;
        default:
            mask = UIInterfaceOrientationPortrait;
            break;
    }
    return mask;
}

// 当前用户界面是否为横屏
- (BOOL)interfaceIsLandscape
{
    BOOL isLandscape = NO;
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        isLandscape = YES;
    }
    return isLandscape;
}







#pragma mark 旋转方式1--示例-->可以直接使用该工具类方式
//PS:注意AppDelegate，UITabViewControllert，UINavigationController，UIViewController的优先级

//1:
//1：直接把下面这段代码复制到AppDelegate中，并在配置文件中将4个方向都勾上
//-----------------程序旋转屏幕控制区域---------------------

///**
// APP支持旋转屏幕的方向(把4个方向都选上)
// 默认为info.plist中勾选的方向
// **/
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations//旋转屏幕支持的方向
//{
//    return [TKRotateManager shared].dirAllMask;
//}
//
///** 程序启动时默认方向 */
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPersentation
//{
//    return [TKRotateManager shared].dirDefaultMask;
//}
//
///**
// * 旋转时支持的屏幕方向
// * PS:目前好像只有这个方向才有效
// **/
//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    return [TKRotateManager shared].dirCurMask;
//}




#pragma mark 旋转方式2--示例
//2:
/**

//AppDelegate中实现，只示例了UINavigationController，(UITabViewControllert同理)
//
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    UINavigationController *navigationController = (id)self.window.rootViewController;
    if ([navigationController isKindOfClass:[UINavigationController class]]) {
        return [navigationController.visibleViewController supportedInterfaceOrientations];
    }
    return navigationController.supportedInterfaceOrientations;
}



// UIViewController中实现，以控制单个页面旋转状态(UINavigationController，UITabViewControllert中也要实现相应操作)
//
- (BOOL)shouldAutorotate{
    return YES;
}
//当前控制器支持方向：动态修改控制
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if (self.isLock || self.isEnterBackground) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }else{
        return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
    }
}
//默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}



**/





#pragma mark 手动切换方向
//方式1：
/**
 //首先设置UIInterfaceOrientationUnknown欺骗系统，避免可能出现直接设置无效的情况
  [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationUnknown) forKey:@"orientation"];
  [[UIDevice currentDevice] setValue:@(mask) forKey:@"orientation"];
 */


//方式2：
/**
 + (void)setFullOrHalfScreen {
     BOOL isFull = [self isInterfaceOrientationPortrait];
     if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
         SEL selector = NSSelectorFromString(@"setOrientation:");
         NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
         [invocation setSelector:selector];
         [invocation setTarget:[UIDevice currentDevice]];
         int val = isFull ? UIInterfaceOrientationLandscapeRight:UIInterfaceOrientationPortrait;

         [invocation setArgument:&val atIndex:2];
         [invocation invoke];
     }
     [[UIApplication sharedApplication]setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
 }

 + (BOOL)isInterfaceOrientationPortrait {
     UIInterfaceOrientation o = [[UIApplication sharedApplication] statusBarOrientation];
     return o == UIInterfaceOrientationPortrait;
 }


 */





@end
