//
//  BaseViewController.h
//  Orchid
//
//  Created by Mac on 2019/1/11.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <TKSDKUniversal/TKSDKUniversal.h>
#import "TKErrorPopView.h"

@interface BaseViewController : TKSDKViewController
/** 重写该方法，利用storyboard创建controller */
+ (nullable instancetype)createVC;
/** 给导航条添加阴影效果，如果不需要，直接重写该方法保留一个空白函数即可 */
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



#pragma mark --错误提示处理--
/** 网络错误提示view */
@property(nonatomic, strong, nullable) TKErrorPopView *errorNoNetworkView;
/** 没有数据提示view */
@property(nonatomic, strong, nullable) TKErrorPopView *errorNoDataView;
/** 数据加载失败view */
@property(nonatomic, strong, nullable) TKErrorPopView *errorLoadFailView;
/** 是否显示网络错误提示view */
- (nullable TKErrorPopView *)showErrorNetWorkViewWith:(BOOL)isShow;
/** 是否显示没有数据view */
- (nullable TKErrorPopView *)showErrorNoDataViewWith:(BOOL)isShow;
/** 是否显示数据加载失败view */
- (nullable TKErrorPopView *)showErrorLoadFailViewWith:(BOOL)isShow;
/** 没有数据点击回调action */
- (void)errorFunNoDataView;
/** 数据加载失败回调action  */
- (void)errorFunLoadFailView;
/** 网络错误回调action */
- (void)errorFunNetWorkView;




@end
