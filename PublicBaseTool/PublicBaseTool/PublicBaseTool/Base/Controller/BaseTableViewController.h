//
//  BaseTableViewController.h
//  Orchid
//
//  Created by Mac on 2019/1/11.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <TKSDKUniversal/TKSDKUniversal.h>

@interface BaseTableViewController : TKSDKTableViewController
/** 重写该方法，利用storyboard创建controller */
+ (nullable instancetype)createVC;
/** 给导航条添加阴影效果 */
- (void)addShadowView;
/** 不显示导航条底部阴影 */
- (void)addShadowViewNoDisplay;
/**  设置导航条颜色白色，标题颜色黑色 **/
- (void)setNavBarStyleBgWhite;

/** 该方法用于每个页面的数据获取
 目的：用户重新登录后,直接发送通知-可进行调用该方法-进行数据刷新
 用法：后续继承，直接重写该方法，获取数据
 **/
- (void)getDatasFromServer;

/**
 登录成功通知action,执行getDatasFromServer方法之前
 会执行的方法
 **/
- (void)willGetDatasFromServer;

@end
