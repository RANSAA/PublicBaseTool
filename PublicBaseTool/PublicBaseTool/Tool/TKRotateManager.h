//
//  TKRotateManager.h
//  AdultLP
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 mac. All rights reserved.
//

/**
 app方向管理与控制，即横竖屏管理旋转等
 使用时将当前类中的屏幕方向管理代码复制到AppDelegate中，放在AppDelegate中时
 控制等级最高，如果不想让AppDelegate控制，也可以将对应的旋屏代码放在对用的控制器中，
 使用方式一样，只是要注意各种控制器的优先级
 推荐直接在AppDelegate中控制

 info.plist方向配置问题:
 如果在AppDelegate中使用了TKRotateManager进行方向控制，那么项目设置中的设备支持方向可以不勾选
 勾选上也是可以的，但是没有效果，因为程序的支持的方向全部t由该类控制

 iPad横竖屏切换无效解决方法：
 将iPad对应的设备方向全都不勾选，这样屏幕方向控制就有效了。(即在通用设备处选中iPad然后让它所有的方向都不勾选)

 **/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKRotateManager : NSObject
/** 支持的方向：0：只支持竖屏 1：只支持横屏 2：支持所有的方向。默认为0 */
@property(nonatomic, assign) NSInteger dirMaskType;
/** APP支持的方向，记得在info.plist的所有方向都勾上**/
@property(nonatomic, assign, readonly) UIInterfaceOrientationMask dirAllMask;
/** 旋转时支持的方向 */
@property(nonatomic, assign, readonly) UIInterfaceOrientationMask dirCurMask;
/** App启动时默认支持方向 */
@property(nonatomic, assign, readonly) UIInterfaceOrientation dirDefaultMask;
/** 当前用户界面方向是否为横屏 YES:为横屏 NO:为竖屏 */
@property(nonatomic, assign, readonly) BOOL interfaceIsLandscape;

/** 单利初始化 */
+ (TKRotateManager *)shared;

/**
 强制设置屏幕方向：YES:强制设置为横屏(Home right) NO:强制设置屏幕方向为竖屏(Home Bottom)
 PS:强制设置屏幕方向之后，注意手动修复一下dirMaskType的值
 设置横屏之后 dirMaskType=1
 设置竖屏之后 dirMaskType=0或者2
 (当前已经修复了)
 **/
- (void)setForceHorizontalScreen:(BOOL)isHorizontal;


/**
 保存程序上一次的方向，用于固定某个页面的方向
 PS:保存-恢复成对出现
 **/
- (void)saveLastOrientation;
/**
 恢复程序上一次的方向，用于固定某个页面的方向
 PS:保存-恢复成对出现
 **/
- (void)recoveryLastOrientation;








#pragma mark 直接把下面这段代码复制到AppDelegate中即可

////-----------------程序旋转屏幕控制区域---------------------
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




@end

NS_ASSUME_NONNULL_END
