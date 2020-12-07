//
//  TabBarViewController.m
//  Orchid
//
//  Created by Mac on 2019/1/11.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TabBarViewController.h"
//#import "HomeRootViewController.h"
//#import "RecordRootViewController.h"
//#import "UserRootViewController.h"
//
//
//#import "LoginNewViewController.h"


@interface TabBarViewController ()<UITabBarControllerDelegate>
@property(nonatomic, assign) BOOL isShowReloginAlert;//控制是否允许显示重新登录alert，防止重复弹窗
@property(nonatomic, strong) UIButton *btnServer;
@end

@implementation TabBarViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//
//    [self setTabBarControllerStyle];
////    [self customTabBar];
////
////    [self addCheckNetworkSate];
//    [self addNotifaction];
//
//}

//
//- (void)setTabBarControllerStyle
//{
//    UIColor *colorNormal   = kColorFontBlack;
//    UIColor *colorSelected = kColorBlueNav;
////    UIColor *colorSelected = kHEXColor(@"#007EFF");
//    self.aryItems = [[NSMutableArray alloc] init];
//
//    NSArray *titles = @[@"我的学习",@"平台课程",@"学考分析",@"个人中心"];
//    NSArray *imgAryNormal = @[@"bar-item2-NO",@"bar-item1-NO",@"bar-item0-NO",@"bar-item3-NO"];
//    NSArray *imgArySelected = @[@"bar-item2-YES",@"bar-item1-YES",@"bar-item0-YES",@"bar-item3-YES"];
//    NSArray *storyNameAry = @[StoryHomeCourse,StoryPlatform,StoryLearnRecord,StoryCenter];
//    for (NSInteger i=0; i<storyNameAry.count; i++) {
//        NSString *title = titles[i];
//        NSString *imgNormal = imgAryNormal[i];
//        NSString *imgSelected = imgArySelected[i];
//        NSString *storyName = storyNameAry[i];
//        UIViewController *vc = [kStoryboard(storyName) instantiateInitialViewController];
//        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
//        UITabBarItem *item = [[UITabBarItem alloc]init];
//        item.title = title;
//        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0],
//                                       NSForegroundColorAttributeName:colorNormal
//                                       } forState:UIControlStateNormal];
//        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0],
//                                       NSForegroundColorAttributeName:colorSelected
//                                       } forState:UIControlStateSelected];
//        item.selectedImage = [[UIImage imageNamed:imgSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        item.image = [[UIImage imageNamed:imgNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        nav.tabBarItem = item;
//        [self.aryItems addObject:item];
//        [self addChildViewController:nav];
//    }
//    self.delegate = self;
//    self.selectedIndex = 1;
//
////    UITabBarItem *item = self.aryItems[3];
////    item.badgeValue = @"4";
//
//
//}
//
//


#pragma mark 处理底部UITabBar
//- (void)customTabBar
//{
//    UIColor *shadowColor = kHEXColor(@"#F2F2F2");
//    CGRect rect = CGRectMake(0, 0, Screen_Width, 1);
//    UIImage *shadowImage = [TKSDKImageTool TKCreateImageWithColor:shadowColor rect:rect alpha:1.0];
//    rect.size.height = 49;
//    UIImage *bgImage     = [TKSDKImageTool TKCreateImageWithColor:kColorWhite rect:rect alpha:1.0];
//    self.tabBar.shadowImage = shadowImage;
//    [self.tabBar setBackgroundImage:bgImage];
//    self.tabBar.barTintColor = kColorWhite;
//    self.tabBar.layer.masksToBounds = NO;
//    self.tabBar.layer.shadowOffset = CGSizeMake(0.0, -.5);
//    self.tabBar.layer.shadowOpacity = 1.0;
//    self.tabBar.layer.shadowRadius = 1.0;
//    self.tabBar.layer.shadowColor = shadowColor.CGColor;
//}
//
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    NSInteger index = self.selectedIndex;
//    if ([AppManager shared].isLogin) {
////        if (index == 3) {
////            UITabBarItem *item = self.aryItems[3];
////            item.badgeValue = nil;
////        }
//    }else{
//        if (index != 1) {
//            self.selectedIndex = 1;
//            //跳转到登录页面
////            [self jumpLoginControllerWithType:0];
//        }
//
//    }
//
//}
//
//
//#pragma mark 检查网络状态
//- (void)addCheckNetworkSate
//{
////    [TKAFNetworkTool netWorkStatus:^(NSInteger status) {
////        if (status == -1) {//未知网络
////
////        }else if (status == 0){//未连接网络
////            if ([[[NSUserDefaults standardUserDefaults] objectForKey:kIsFirstLoadKey] boolValue]) {
////                [TKMBProgressHUD showText:@"未连接网络"];
////                TKAlertView *alertView = [TKAlertView TKAlertViewWithTitle:@"蜂窝移动数据已关闭" text:@"打开蜂窝移动数据或者使用无线局域网"];
////                [alertView.btnDone setTitle:@"设置" forState:UIControlStateNormal];
////                [alertView.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
////                alertView.blockDone = ^{
////                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
////                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
////                        if (@available(iOS 10.0, *)) {
////                            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
////                        } else {
////                            // Fallback on earlier versions
////                            [[UIApplication sharedApplication] openURL:url];
////                        }
////                    }
////                };
////            }
////        }else if (status == 1){//蜂窝移动网络
////
////        }else if (status == 2){//WIFI
////
////        }
////    }];
//}
//
//- (void)addNotifaction
//{
//    kNotifactionFunAdd(kNotifactionReLogin, reLoginAction);
//    kNotifactionFunAdd(kNotifactionJumpLoginPage, openLoginAction)
//    kNotifactionFunAdd(kNotifactionLoginSuccess, loginSuccessAction)
//}
//
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//#pragma mark token失效重新打开登录页面
//- (void)reLoginAction
//{
//    WeakSelf
//
//    NSArray *ary = self.selectedViewController.childViewControllers;
//    id vc = ary.lastObject;
//    if ([vc isKindOfClass:LoginNewViewController.class]) {
//        TKLog(@"已经在登录页面，不需要再弹出登录框");
//        return;
//    }
//
//    //解除AliPush账号绑定
////    [AliPushSDKTool unbingAccountWithAliPush];
//
//
//    //重新登录alert没有弹出来，并且也没有进入登录页面才会弹窗
//    if (![StateManager shared].isReloginJumpLogin && ![StateManager shared].isReloginAlert) {
//        //解除AliPush账号绑定
//        [AliPushSDKTool unbingAccountWithAliPush];
//
//        [StateManager shared].isReloginAlert = YES;
//        TKAlertView *alert = [TKAlertView showTipsRelogin];
//        alert.blockDone = ^{
//            [StateManager shared].isReloginAlert = NO;
//            [StateManager shared].isReloginJumpLogin = YES;
//            [weakSelf jumpLoginControllerWithType:1];
//        };
//        alert.blockCancel = ^{
//            [StateManager shared].isReloginAlert = NO;
//            UINavigationController *nav = weakSelf.selectedViewController;
//            [nav popToRootViewControllerAnimated:NO];
//            weakSelf.selectedIndex = 1;
//            TKLog(@"vc class:%@",nav);
//        };
//    }
//
//    TKLog(@"reLoginAction");
//}
//
//
//#pragma mark 跳转进入登录页面
///**
// 0:直接登录
// 1：重新登录
// **/
//- (void)jumpLoginControllerWithType:(NSInteger)type
//{
//    WeakSelf
//    LoginNewViewController *vc = [LoginNewViewController createVC];
//    vc.fromType = type;
//    vc.blockBack = ^(id value) {
//        NSInteger type = [value integerValue];
//        if (type == 0) {
//            weakSelf.selectedIndex = 0;
//        }
//    };
//    [self.selectedViewController pushViewController:vc animated:YES];
//}
//
//
//#pragma mark 首页未登录，通知打开登录页面
//- (void)openLoginAction
//{
//    [self jumpLoginControllerWithType:0];
//}
//
//
//#pragma mark 登录成功
//- (void)loginSuccessAction
//{
//    //AliPush:绑定指定账号到设备
//    [AliPushSDKTool bingAccountToAliPush];
//}
//
//
//
//
//
//
//
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//
//





@end
