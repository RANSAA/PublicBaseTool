//
//  TKSDKViewController.h
//  AF
//
//  Created by Apple on 2018/3/2.
//  Copyright © 2018年 PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKSDKNavigationBar.h"

/**
 继承UIVIewController，添加自定义导航条，侧滑返回等功能
 使用自定义的导航条--默认是把系统的导航条给隐藏了的
 使用自定义的导航调配，新页面显示可以利用PUSH与Model的方式进行
 支持侧滑返回(使用系统默认的侧滑返回方式)
 实现了UIGestureRecognizerDelegate代理
 注意：
    导航条的默认高度为44，并且横竖屏不同状态可以分别设置导航条的高度，需要修改导航条的有效高度时，直接调用TKNavigationBar对应的方法即可
 */


NS_ASSUME_NONNULL_BEGIN

@interface TKSDKViewController : UIViewController <UIGestureRecognizerDelegate>
@property(nonatomic, strong) TKSDKNavigationBar * _Nullable TKNavigationBar;//自定义的导航条
@property(nonatomic, assign) BOOL isEnabledSideslip;//是否开启侧滑返回，默认开启
@property(nonatomic, assign) BOOL isEnabledTKNavigationBar;//是否开启TKNavigationBar的使用，默认开启
/**
作用：
        使控制器默认加载时不创建TKNavigationBar，只有当它的值设置为YES时才会有效，
        并且需要在[self viewDidLoad]方法或者之前设置才会有效。
可用于替换：
        [self defaultEnabledConfig]中重写的
        [self setValue:@(NO) forKey:@"_isEnabledTKNavigationBar"]操作
 */
@property(nonatomic, assign) BOOL isDefaultNoUseTKNavBar;


#pragma mark TKSDKNavigationBar默认配置相关区域
/**
默认配置方法，重写修改配置:
执行顺序：重写init，initWithXXXX方法时，就会执行该方法。
可修改的值：
       _isEnabledSideslip
       _isEnabledTKNavigationBar
注意:
       重写时先[self super]，再修改。修改时使用kvc的方式修改，如：
       [self setValue:@(NO) forKey:@"_isEnabledTKNavigationBar"];
PS:
       主要是当前controller作为childController时，默认不需要创建TKSDKNavigationBar时，重写！
*/
- (void)defaultEnabledConfig;



#pragma mark 默认基础函数区域
/**  返回函数操作 */
- (void)backAction:(id _Nonnull)sender;
/**
 当页面完全返回上一级页面后会调用该函数
 :- (void)didMoveToParentViewController:(UIViewController *)parent
 */
- (void)backDidParentControllerAction;


#pragma mark 状态栏相关显示设置
/**
 设置状态栏文字样式
 0:默认黑色
 1:白色高亮
 2:自动
*/
- (void)setStatusBarStyleType:(NSInteger)styleType;
/**  设置设备竖屏时，状态栏是否隐藏*/
- (void)setStatusBarIsHidden:(BOOL)isHidden;
/**
 设置设备横屏时，状态栏是否隐藏，默认隐藏
 PS:iOS13.0+无效，横屏时不能显示状态栏
 */
- (void)setStatusBarLandscapeIsHidden:(BOOL)isHidden;


#pragma mark 扩展UINavigationController相关方法
/**
  扩展使其等效于UINavigationController中对应的方法
  PS:如果当前控制器不在NavigationController中，则使其等效于对应present与dismiss方法
 */
- (void)pushViewController:(UIViewController *_Nullable)viewController animated:(BOOL)animated;
- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *_Nullable)viewController animated:(BOOL)animated;


#pragma mark 工具函数区域
/**
作用：解决侧滑返回时，控制器左边有Scrollview控制而引起冲突问题，导致侧滑失效问题。
   ：即可以不设置控制器中多个控件都可以同时接收同一个手势
*/
- (void)setTKPanGestureRecognizerWithScrollView:(UIScrollView *_Nullable)scrollView;



@end

NS_ASSUME_NONNULL_END
