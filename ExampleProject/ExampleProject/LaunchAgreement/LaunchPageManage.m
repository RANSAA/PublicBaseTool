//
//  LaunchPageManage.m
//  ExampleProject
//
//  Created by PC on 2022/8/4.
//

#import "LaunchPageManage.h"
#import "LaunchPageViewController.h"


@interface LaunchPageManage ()

@end

@implementation LaunchPageManage

+ (instancetype)shared
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [super allocWithZone:NULL];
    });
    return obj;
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
        vc.block = completion;
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

- (void)saveUserAgreementStatus
{
    [NSUserDefaults.standardUserDefaults setValue:@(YES) forKey:@"UserAgreementStatus"];
}

- (BOOL)getUserAgreementStatus
{
    BOOL status = [[NSUserDefaults.standardUserDefaults valueForKey:@"UserAgreementStatus"] boolValue];
    return status;
}

@end
