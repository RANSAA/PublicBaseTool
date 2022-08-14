//
//  UIViewController+ThemeEnvironment.h
//  ExampleProject
//
//  Created by PC on 2022/8/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ThemeEnvironment)
/**
 功能： 绑定监听显示样式切换， light or dark
 theme：style
 view： 本对象
 */
- (void)bingMonitorTheme:(void(^)(UIUserInterfaceStyle style, UIViewController* controller))completionHandler API_AVAILABLE(ios(13.0));

/**
 绑定监听TraitCollectionDidChange
 */
- (void)bingMonitorTraitCollection:(void(^)(UITraitCollection *previousTraitCollection, UIViewController* controller))completionHandler;

@end

NS_ASSUME_NONNULL_END