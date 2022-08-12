//
//  AppIconManage.m
//  ExampleProject
//
//  Created by PC on 2022/8/12.
//

#import "AppIconManage.h"
#import "TKMethodSwap.h"



// MARK: - App Icon图标动态更换管理图标
@implementation AppIconManage

+ (instancetype)shared
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [super allocWithZone:NULL];
    });
    return obj;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return self.shared;
}


- (void)setShowAlert:(BOOL)showAlert
{
    _showAlert = showAlert;
    if (!showAlert) {
        [UIViewController appIconDynamicSwap];
    }
}

// MARK: - APP图标替换

/**
 APP图标替换
 iconName: Icon files (iOS 5) -> CFBundleAlternateIcons -> iconName ; 如果为nil则使用默认icon
 */
- (void)changeAppIconWithName:(NSString *)iconName
{

    if (@available(iOS 10.3, *)) {
        if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
            return;
        }

        if ([iconName isEqualToString:@""]) {
            iconName = nil;
        }
        [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"更换app图标发生错误了 ： %@",error);
            }else{
                NSLog(@"更换成功");
            }
        }];
    } else {
        NSLog(@"iOS版本小于10.3不支持动态更换APP图标。");
    }
}

@end





// MARK: - 为UIViewController添加扩展，实现去掉更换icon时的弹框

@implementation UIViewController (AppIconDynamic)

/**
 开启函数交换实现更换icon时去掉弹出
 */
+ (void)appIconDynamicSwap
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = UIViewController.class;
        [TKMethodSwap swizzleMethod:cls originSel:@selector(presentViewController:animated:completion:) swizzSel:@selector(AppIconDynamic_presentViewController:animated:completion:)];
    });
}

- (void)AppIconDynamic_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {

    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (alertController.title == nil && alertController.message == nil) {
            return;
        }
    }
    [self AppIconDynamic_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
