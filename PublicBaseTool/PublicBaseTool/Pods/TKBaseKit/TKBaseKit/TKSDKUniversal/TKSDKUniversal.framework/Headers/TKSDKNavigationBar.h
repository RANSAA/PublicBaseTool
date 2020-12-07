//
//  TKSDKNavigationBar.h
//  AF
//
//  Created by PC on 2018/3/3.
//  Copyright © 2018年 PC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 自定义导航条
 导航条区域主要分为：navView和statusBarView，导航条的整体高度为这两个区域的高度和
    navView:有效导航区域区域，默认高度44
    statusBarView:状态栏安全区域
    backgroundView:整个导航条最底部的背景图显示区域，和整个导航条的bounds保持一致
    navViewBackgroundView:navView中底部的背景图显示区域
 注：导航条中的所有子控件(navView除外)都是采用懒加载的方式。
 
 PS：instanceWithController:方法构建的导航条都是依赖于controller中的TopLayoutGuide.bottom进行约束的，
 约束条件是导航条底部(NavigationBar.bottom)相对于TopLayoutGuide.bottom进行约束的。

 */

@interface TKSDKNavigationBar : UIView
/**
 PS:子视图(都是懒加载,这几个view都设置了restorationIdentifier，值为对应的属性名称)
 */

/** navView,导航条的有效显示区域(不包含状态栏所在的区域)，默认44 */
@property(nonatomic, strong, nullable) UIView *navView;
/** statusBarView 状态栏所在区域 */
@property(nonatomic, strong, nullable) UIImageView *statusBarView;
/** 整个导航条最底部的背景图区域 */
@property(nonatomic, strong, nullable) UIImageView *backgroundView;
/** navView中底部的背景图区域 */
@property(nonatomic, strong, nullable) UIImageView *navViewBackgroundView;
/** 返回按钮*/
@property(nonatomic, strong, nullable) UIButton *btnBack;
/** 右边按钮*/
@property(nonatomic, strong, nullable) UIButton *btnRight;
/** 标题*/
@property(nonatomic, strong, nullable) UILabel  *labTitle;



#pragma mark ----------配置----------
/** navView竖屏时的高度，默认为44 */
@property(nonatomic, assign) CGFloat navViewPortraitHeight;
/** navView横屏时的高度，默认为44 */
@property(nonatomic, assign) CGFloat navViewLandscapeHeight;


#pragma mark ----------约束----------
//返回按钮的宽度约束
@property(nonatomic, strong, nullable)NSLayoutConstraint *layBtnBackWidth;
//返回按钮距离导航条的左边的距离-竖屏
@property(nonatomic, assign)CGFloat layBtnBackLeftMarginPortrait;
//返回按钮距离导航条的左边的距离-横屏
@property(nonatomic, assign)CGFloat layBtnBackLeftMarginLandscape;
//返回按钮距离导航条的左边的距离-横屏-iphone X系列
@property(nonatomic, assign)CGFloat layBtnBackLeftMarginLandscapeX;


//右边按钮的宽度约束
@property(nonatomic, strong, nullable)NSLayoutConstraint *layBtnRightWidth;
//右边按钮距离导航条的右边约束-竖屏
@property(nonatomic, assign)CGFloat layBtnRightRightMarginPortrait;
//右边按钮距离导航条的右边约束-横屏
@property(nonatomic, assign)CGFloat layBtnRightRightMarginLandscape;
//右边按钮距离导航条的右边约束-横屏-iphone X系列
@property(nonatomic, assign)CGFloat layBtnRightRightMarginLandscapeX;


//labTitle相对于navView的左边边距，默认58-竖屏
@property(nonatomic, assign)CGFloat layLabTitleLeftMarginPortrait;
//labTitle相对于navView的左边边距，默认58-横屏
@property(nonatomic, assign)CGFloat layLabTitleLeftMarginLandscape;
//labTitle相对于navView的左边边距，默认58+34-横屏-iphone X系列
@property(nonatomic, assign)CGFloat layLabTitleLeftMarginLandscapeX;
//labTitle相对于navView的右边边距，默认58-竖屏
@property(nonatomic, assign)CGFloat layLabTitleRightMarginPortrait;
//labTitle相对于navView的右边边距，默认58-横屏
@property(nonatomic, assign)CGFloat layLabTitleRightMarginLandscape;
//labTitle相对于navView的右边边距，默认58+34-横屏-iphone X系列
@property(nonatomic, assign)CGFloat layLabTitleRightMarginLandscapeX;


/**
 获取状态栏安全区域的高度
 PS：和状态栏的高度由差别,iPhoneX系列隐藏状态栏时，状态栏高度为0，但是安全区域高度不为0
 */
- (CGFloat)getStatusBarAreaHeight;
/**
 实时获取导航条navView区域的高度
 PS:返回值是区分了横竖屏的
 */
- (CGFloat)getNavViewAreaHeight;
/**
 获取整个导航条的高度：navView+statusBar 的高度
 */
- (CGFloat)getNavigationBarHeight;
/**
 更新状态栏约束
 PS:更优的方式是在外部动态计算navView与statusBar的高度，来修改整个导航条的高度
 */
- (void)updateNavigationBarConstraints;




/**
 创建TKNavigationBar并添加到指定的Controller上面
 */
+ (nullable instancetype)instanceWithController:(nullable UIViewController *)controller;



@end

