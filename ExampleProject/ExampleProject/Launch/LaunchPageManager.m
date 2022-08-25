//
//  LaunchPageManage.m
//  ExampleProject
//
//  Created by PC on 2022/8/4.
//

#import <UIKit/UIKit.h>
#import "LaunchPageManager.h"
#import "LaunchPageViewController.h"


@interface LaunchPageManager ()

@end

@implementation LaunchPageManager

+ (instancetype)shared
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [super allocWithZone:NULL];
    });
    return obj;
}


- (void)saveUserAgreementStatus
{
    [NSUserDefaults.standardUserDefaults setValue:@(YES) forKey:@"FirstLaunchUserAgreementAgreeStatus"];
}

- (BOOL)getUserAgreementStatus
{
    BOOL status = [[NSUserDefaults.standardUserDefaults valueForKey:@"FirstLaunchUserAgreementAgreeStatus"] boolValue];
    return status;
}



/// 用户协议检测
/// @param completion 在block回调中进行APP初始化配置。
- (void)userAgreementStatusDetectionCompletionHandler:(void (^)(void))completion
{
    if ([self getUserAgreementStatus]) {
        if (completion) {
            completion();
        }
    }else{
        LaunchPageViewController *vc = [self instanceViewController];
        vc.completion = completion;
        vc.saveAgreementStatus = ^{
            [self saveUserAgreementStatus];
        };
    }
}

- (LaunchPageViewController *)instanceViewController
{
    LaunchPageViewController *vc = [[LaunchPageViewController alloc] init];
    NavigationViewController *navVC = [[NavigationViewController alloc] initWithRootViewController:vc];
    navVC.navigationBarHidden = YES;
    UIWindow *keyWin = [UIApplication.sharedApplication getKeyWindow];
    keyWin.rootViewController = navVC;
    [keyWin makeKeyAndVisible];
    NSLog(@"[UIApplication.sharedApplication getKeyWindow]:%@",[UIApplication.sharedApplication getKeyWindow]);
    return  vc;;
}


@end
