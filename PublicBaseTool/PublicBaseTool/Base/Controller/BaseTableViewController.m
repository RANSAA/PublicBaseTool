//
//  BaseTableViewController.m
//  Orchid
//
//  Created by Mac on 2019/1/11.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

+ (nullable instancetype)createVC
{
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarStyleLightContent:NO];
    [self setNavigationBarStyle];
    [self addBaseNotifactions];
    
    TKLog(@"Class Name: %@",[self class]);
    
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
//    } else {
//        // Fallback on earlier versions
//        self.automaticallyAdjustsScrollViewInsets = YES;
//    }

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
