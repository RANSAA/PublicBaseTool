//
//  BaseViewController.m
//  Orchid
//
//  Created by Mac on 2019/1/11.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

+ (nullable instancetype)createVC
{
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setStatusBarStyleLightContent:NO];
    [self setNavigationBarStyle];
    [self addBaseNotifactions];

    TKLog(@"Class Name: %@",[self class]);
}

- (void)setNavigationBarStyle
{
    self.TKNavigationBar.backgroundColor = kColorBlueNav;
    [self.TKNavigationBar.btnBack setImage:kImageName(@"public-back-white") forState:UIControlStateNormal];
    self.TKNavigationBar.labTitle.font = [UIFont boldSystemFontOfSize:18];
    self.TKNavigationBar.labTitle.textColor = kColorWhite;
    self.view.backgroundColor = kColorViewBg;
}

/** 给导航条添加阴影效果，如果不需要，直接重写该方法保留一个空白函数即可 */
- (void)addShadowView
{
    self.TKNavigationBar.layer.masksToBounds = NO;
    self.TKNavigationBar.layer.shadowOffset = CGSizeMake(0.0, 1.0f);
    self.TKNavigationBar.layer.shadowOpacity = 1.0;
    self.TKNavigationBar.layer.shadowRadius = 2.0;
    self.TKNavigationBar.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.08].CGColor;
}

/** 不显示导航条底部阴影 */
- (void)addShadowViewNoDisplay
{
    self.TKNavigationBar.layer.shadowOpacity = 0.0;
}

/**  设置导航条颜色白色，标题颜色黑色 **/
- (void)setNavBarStyleBgWhite
{
    [self.TKNavigationBar.btnBack setImage:kImageName(@"public-back-black")];
    self.TKNavigationBar.backgroundColor = kColorWhite;
    self.TKNavigationBar.labTitle.textColor = kColorFontBlack;
}

/** 该方法用于每个页面的数据获取
 目的：用户重新登录后,直接发送通知-可进行调用该方法-进行数据刷新
 用法：后续继承，直接重写该方法，获取数据
 **/
- (void)getDatasFromServer
{

}

- (void)addBaseNotifactions
{
    kNotifactionFunAdd(kNotifactionLoginSuccess,loginSuccessNotifaction);
}

- (void)dealloc
{
    TKLog(@"dealloc %@",self.class);
    kNotifactionFunRemove(kNotifactionLoginSuccess);
}

#pragma mark 登录成功通知action
- (void)loginSuccessNotifaction
{
    TKLog(@"%@ 登录成功通知action",[self class]);
    [self willGetDatasFromServer];
    [self getDatasFromServer];
}

/**
 登录成功通知action,执行getDatasFromServer方法之前
 会执行的方法
 **/
- (void)willGetDatasFromServer
{

}





















#pragma mark ---------处理网络错误，或者没有数据等错误相关----------------

- (TKErrorPopView *)errorNoNetworkView
{
    if (!_errorNoNetworkView) {
        WeakSelf
        _errorNoNetworkView = [TKErrorPopView createErrorNoNetworkShowView:self.view];
        _errorNoNetworkView.blockDone = ^{
            [weakSelf errorFunNetWorkView];
        };
    }
    return _errorNoNetworkView;
}

- (TKErrorPopView *)errorLoadFailView
{
    if (!_errorLoadFailView) {
        WeakSelf
        _errorLoadFailView = [TKErrorPopView createErrorLoadFailShowView:self.view];
        _errorLoadFailView.blockDone = ^{
            [weakSelf errorFunLoadFailView];
        };
    }
    return _errorLoadFailView;
}

- (TKErrorPopView *)errorNoDataView
{
    if (!_errorNoDataView) {
        WeakSelf
        _errorNoDataView = [TKErrorPopView createErrorNoDataShowView:self.view];
        _errorNoDataView.blockDone = ^{
            [weakSelf errorFunNoDataView];
        };
    }
    return _errorNoDataView;
}

- (nullable TKErrorPopView *)showErrorNoDataViewWith:(BOOL)isShow
{
    if (_errorNoDataView) {
        self.errorNoDataView.hidden = !isShow;
    }else{
        if (isShow) {
            self.errorNoDataView.hidden = !isShow;
        }
    }
    return _errorNoNetworkView;
}

- (nullable TKErrorPopView *)showErrorLoadFailViewWith:(BOOL)isShow
{
    if (_errorLoadFailView) {
        self.errorLoadFailView.hidden = !isShow;
    }else{
        if (isShow) {
            self.errorLoadFailView.hidden = !isShow;
        }
    }
    return _errorLoadFailView;
}

- (nullable TKErrorPopView *)showErrorNetWorkViewWith:(BOOL)isShow
{
    if (_errorNoNetworkView) {
        self.errorNoNetworkView.hidden = !isShow;
    }else{
        if (isShow) {
            self.errorNoNetworkView.hidden = !isShow;
        }
    }
    return _errorNoNetworkView;
}

/** 没有数据点击回调action */
- (void)errorFunNoDataView
{
    
}

/** 数据加载失败回调action  */
- (void)errorFunLoadFailView
{

}

/** 网络错误回调action */
- (void)errorFunNetWorkView
{

}


#pragma mark ---------处理网络错误，或者没有数据等错误相关----------------


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
