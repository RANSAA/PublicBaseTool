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


@class TKSDKNavigationBar;

@protocol TKSDKNavigationBarDelegate <NSObject>
@optional
/**
 功能：TKSDKNavigationBar的frame更新时回调
 navHeight:导航条有效区域高度(去除状态栏区域)
 allHeight:整个导航条的高度
 */
- (void)TKSDKNavigationBarUpdate:(TKSDKNavigationBar *_Nullable)navBar navHeight:(CGFloat)navHeight allHeight:(CGFloat)allHeight;

@end



@interface TKSDKNavigationBar : UIView
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
/** 实现该代理可以监听到TKSDKNavigationBar frame的变化  */
@property(nonatomic, weak, nullable) id<TKSDKNavigationBarDelegate> delegate;
/** navView区域中新增的toolbar，注意：1.使用时需要注意他与TKSDKNavigationBar的样式 2.如果直接添加到TKSDKNavigationBar中需要手动指定高度 */
@property(nonatomic, strong, nullable) UIToolbar *toolbar;



#pragma mark - ----------配置----------
/** navView竖屏时的高度，默认为44 */
@property(nonatomic, assign) CGFloat navViewPortraitHeight;
/** navView横屏时的高度，默认为44 */
@property(nonatomic, assign) CGFloat navViewLandscapeHeight;


#pragma mark - ----------约束----------
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
 添加UICollectionViewController,UITableViewController中的scrollView，
 并对scrollView.contentInsetAdjustmentBehavior 进行KVO键值监听
 */
- (void)addScrollView:(nullable UIScrollView *)scrollView;


/**
 创建TKNavigationBar并添加到指定的Controller上面
 */
+ (nullable instancetype)instanceWithController:(nullable UIViewController *)controller;



#pragma mark - 获取所有创建的TKSDKNavigationBar

/**
 获取所有的TKSDKNavigationBar控件，可用于批量处理
 PS:注意与appearance的区别
 */
+ (NSMutableSet *_Nonnull)stockList;


//MARK: - toolbar
/** 设置toolbar.barTintColor */
- (void)setToolBarTintColor:(nullable UIColor *)color;

@end

