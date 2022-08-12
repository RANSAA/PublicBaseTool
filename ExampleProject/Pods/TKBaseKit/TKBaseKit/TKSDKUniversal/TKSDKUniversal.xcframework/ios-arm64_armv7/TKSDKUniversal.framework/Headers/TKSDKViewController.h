//
//  TKSDKViewController.h
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
 
 other:
         如果出现TKNavigationBar导航条被遮挡的情况，请执行[self makeNavigationBarToFront],使TKNavigationBar始终保持在最上层。
         或者直接使用addSubView:方法向self.view上添加新视图，并且总能使TKNavigationBar保持在最上层。
 
 */


NS_ASSUME_NONNULL_BEGIN

@interface TKSDKViewController : UIViewController <UIGestureRecognizerDelegate>
@property(nonatomic, strong) TKSDKNavigationBar * _Nullable TKNavigationBar;//自定义的导航条
@property(nonatomic, assign) BOOL isEnabledSideslip;//是否开启侧滑返回，默认开启
@property(nonatomic, assign) BOOL isEnabledTKNavigationBar;//是否开启TKNavigationBar的使用，默认开启

#pragma mark TKSDKNavigationBar默认配置区域

/**
 功能：默认配置函数，该方法是在viewDidLoad之前执行的。
 说明：如果直接用对应属性的seter方法修改，会先初始化相应配置，再进行修改。所以如果某些功能不使用，可以重写该方法然后再用KVC的方式修改。
 重写：修改修改默认配置时，需要先执行[self super]，然后再修改，如：[self setValue:@(NO) forKey:@"_isEnabledTKNavigationBar"];
 场景：如当前controller作为childController时并且默认不需要创建TKSDKNavigationBar时，即可重写！
 可修改的key值：
             _isEnabledTKNavigationBar  //默认是否开启TKNavigationBar
             _isEnabledSideslip         //默认是否开启侧滑返回
 */
- (void)defaultEnabledConfig;



/**
 值为YES则会使makeNavigationBarToFront方法无效化(即不会使TKNavigationBar总是保持在最上层)。 Default：NO
 */
@property (nonatomic, assign) BOOL makeNavigationBarToFrontInvalid;
/**
 使TKNavigationBar保持在self.view的最上层.
 PS:如果出现TKNavigationBar出现被其它控件遮挡的情况时，使用此方法使其置顶
 */
- (void)makeNavigationBarToFront;

/**
 向self.view添加view,并执行makeNavigationBarToFront。
 PS：推荐使用该方法添加新控件，让TKNavigationBar总是保持在最上层。
 */
- (void)addSubView:(UIView *)view;



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
