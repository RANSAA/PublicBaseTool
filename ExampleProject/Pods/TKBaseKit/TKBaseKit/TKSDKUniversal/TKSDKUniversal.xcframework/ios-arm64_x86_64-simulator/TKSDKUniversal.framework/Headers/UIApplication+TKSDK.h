//
//  UIApplication+TKSDK.h
//  TKSDKUniversal
//
//  Created by PC on 2019/12/23.
//  Copyright © 2019 PC. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (TKSDK)
/**
 获取keyWindow,适配iOS13.0+
 PS:如果需要实现iPad多屏处理，最好是使用SceneDelegate管理Window
 小提示:该方法有可能获取不到Window(获取的时机问题，即：系统windows还未创建好)。
 多场景的是否使用对该方法获取null的影响(ios13.0+)：
 使用多场景：AppDelegate didFinishLaunchingWithOptions:方法中获取不到keyWindow
 不使用多场景：SceneDelegate willConnectToSession:方法中获取不到keyWindow。
 PS:如果获取不到keyWindow但是又必须在某个地方获取，可以做一下延时操作就可以获取到了。
 */
@property(class, nonatomic, strong, readonly) UIWindow *keyWindow;
/** 获取当前显示的视图控制器 */
@property(class, nonatomic, strong, readonly) UIViewController *currentShowController;
@end

NS_ASSUME_NONNULL_END
