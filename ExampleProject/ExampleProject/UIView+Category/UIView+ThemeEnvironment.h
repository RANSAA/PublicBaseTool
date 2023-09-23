//
//  UIView+ThemeEnvironment.h
//  ExampleProject
//
//  Created by PC on 2022/8/14.
//

#import <UIKit/UIKit.h>

/**
 扩展处理处理APP外观显示模式，
 1. Light or Dark 模式切换监听


 注意：本扩展主要在于交换View中的traitCollectionDidChange:函数实现绑定监听，但是有些之类的traitCollectionDidChange:方法并不继承父类，
 所以在某些UIView的子类控件中不生效，如在UIButton中生效，UIImageView中不生效。解决方法：即扩展不生效的子类控件并拷贝UIView (ThemeEnvironment)
 中实现函数交换的功能的方法与实现：
 + (void)load;
 - (void)TKThemeEnvironment_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection;

 */


NS_ASSUME_NONNULL_BEGIN
@interface UIView (ThemeEnvironment)
/**
 功能： 绑定监听显示样式切换， light or dark
 theme：style
 view： 本对象
 */
- (void)bingMonitorTheme:(void(^)(UIUserInterfaceStyle style, UIView* view))completionHandler API_AVAILABLE(ios(13.0));

/**
 绑定traitCollectionDidChange:方法，即traitCollectionDidChange:执行时会直接将参数传递到该方法并执行
 */
- (void)bingMonitorTraitCollection:(void(^)(UITraitCollection *previousTraitCollection, UIView* view))completionHandler;

@end



@interface UIImageView (ThemeEnvironment)
@end

@interface UILabel (ThemeEnvironment)
@end

NS_ASSUME_NONNULL_END
