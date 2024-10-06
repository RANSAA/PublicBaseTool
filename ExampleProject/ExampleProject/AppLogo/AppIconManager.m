//
//  AppIconManage.m
//  ExampleProject
//
//  Created by PC on 2022/8/12.
//

#import "AppIconManager.h"
#import "TKMethodSwap.h"



// MARK: - App Icon图标动态更换管理图标
@implementation AppIconManager

+ (instancetype)shared
{
    static AppIconManager* obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [super allocWithZone:NULL];
        obj.showAlert = YES;
    });
    return obj;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return self.shared;
}

//
//- (void)setShowAlert:(BOOL)showAlert
//{
//    _showAlert = showAlert;
//    if (!showAlert) {
//        [UIViewController appIconDynamicSwap];
//    }
//}

// MARK: - APP图标替换

/**
 APP图标替换
 iconName: Icon files (iOS 5) -> CFBundleAlternateIcons -> iconName ; 如果为nil则使用默认icon
 */
- (void)changeAppIconWithName:(nullable NSString *)iconName
{

    if (@available(iOS 10.3, *)) {
        if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
            return;
        }
        if ([iconName isEqualToString:@""]) {
            iconName = nil;
        }

        if (self.showAlert) {
            [self requestAlertAppIconWithName:iconName];
        }else{
            [self requestAppIconWithName:iconName];
        }
    } else {
        NSLog(@"iOS版本小于10.3不支持动态更换APP图标。");
    }
}

- (void)requestAlertAppIconWithName:(NSString *)iconName
{
    if (@available(iOS 10.3, *)) {
        __weak typeof(self)weakSelf = self;
        [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"更换app图标发生错误了 ： %@",error);
            }else{
                NSLog(@"更换成功");
            }
            if (weakSelf.completionHandler) {
                weakSelf.completionHandler(error);
            }
        }];
    } else {
        // Fallback on earlier versions
    }
}


/**
 使用IMP发送消息修改icon方式不会显示弹窗信息
 PS: 还可以使用[UIViewController appIconDynamicSwap]交换函数来实现不显示弹窗信息
 */
- (void)requestAppIconWithName:(NSString *)iconName
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(supportsAlternateIcons)] ){
         NSMutableString *selectorString = [[NSMutableString alloc] initWithCapacity:40];
         [selectorString appendString:@"_setAlternate"];
         [selectorString appendString:@"IconName:"];
         [selectorString appendString:@"completionHandler:"];

         SEL selector = NSSelectorFromString(selectorString);
         IMP imp = [[UIApplication sharedApplication] methodForSelector:selector];
         void (*func)(id, SEL, id, id) = (void *)imp;
         if (func){
             __weak typeof(self)weakSelf = self;
             func([UIApplication sharedApplication], selector, iconName, ^(NSError * _Nullable error) {
                 if (error) {
                     NSLog(@"更换app图标发生错误了 ： %@",error);
                 }else{
                     NSLog(@"更换成功");
                 }
                 if (weakSelf.completionHandler) {
                     weakSelf.completionHandler(error);
                 }
             });
         }
     }
}



@end






// MARK: - 为UIViewController添加扩展，实现去掉更换icon时的弹框
@interface UIViewController (AppIconDynamic)
/**
 开启函数交换实现更换icon时去掉弹出
 */
+ (void)appIconDynamicSwap;
@end


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
