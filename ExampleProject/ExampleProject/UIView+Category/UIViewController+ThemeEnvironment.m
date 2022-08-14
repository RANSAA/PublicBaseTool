//
//  UIViewController+ThemeEnvironment.m
//  ExampleProject
//
//  Created by PC on 2022/8/14.
//

#import "UIViewController+ThemeEnvironment.h"
#import "TKMethodSwap.h"
#import <objc/runtime.h>

API_AVAILABLE(ios(12.0)) typedef void(^TKMonitorThemeControllerBlock)(UIUserInterfaceStyle theme, UIViewController* controller);
typedef void(^TKMonitorTraitCollectionControllerBlock)(UITraitCollection *traitCollection, UIViewController* controller);
API_AVAILABLE(ios(12.0)) @interface UIViewController ()
@property(nonatomic, copy) TKMonitorThemeControllerBlock monitorThemeCompletionHandlerUseUserTK;
@property(nonatomic, copy) TKMonitorTraitCollectionControllerBlock monitorTraitCollectionCompletionHandlerUseUserTK;
@end

API_AVAILABLE(ios(12.0)) @implementation UIViewController (ThemeEnvironment)


// MARK: - add property

- (void)setMonitorThemeCompletionHandlerUseUserTK:(TKMonitorThemeControllerBlock)completionHandler
{
    objc_setAssociatedObject(self, @selector(monitorThemeCompletionHandlerUseUserTK), completionHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TKMonitorThemeControllerBlock)monitorThemeCompletionHandlerUseUserTK
{
    return objc_getAssociatedObject(self, @selector(monitorThemeCompletionHandlerUseUserTK));
}

- (void)setMonitorTraitCollectionCompletionHandlerUseUserTK:(TKMonitorTraitCollectionControllerBlock)completionHandler
{
    objc_setAssociatedObject(self, @selector(monitorTraitCollectionCompletionHandlerUseUserTK), completionHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TKMonitorTraitCollectionControllerBlock)monitorTraitCollectionCompletionHandlerUseUserTK
{
    return objc_getAssociatedObject(self, @selector(monitorTraitCollectionCompletionHandlerUseUserTK));
}






// MARK: - 绑定监听变化
/**
 绑定监听显示主题切换
 */
- (void)bingMonitorTheme:(void(^)(UIUserInterfaceStyle style, UIViewController* controller))completionHandler;
{
    self.monitorThemeCompletionHandlerUseUserTK = completionHandler;
}

/**
 绑定监听TraitCollectionDidChange
 */
- (void)bingMonitorTraitCollection:(void(^)(UITraitCollection *previousTraitCollection, UIViewController* controller))completionHandler
{
    self.monitorTraitCollectionCompletionHandlerUseUserTK = completionHandler;
}


// MARK: - 请求处理监听绑定回调事件集
- (void)TKThemeEnvironment_requestMonitorThemeHandlerWith:(UITraitCollection *)previousTraitCollection
{
    if (@available(iOS 13.0, *)) {
        //主题切换才会调用
        if (self.monitorThemeCompletionHandlerUseUserTK) {
            //判断当前模式是否发生变化，因为屏幕旋转也会触发该方法。
            if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
                self.monitorThemeCompletionHandlerUseUserTK(self.traitCollection.userInterfaceStyle, self);
            }
        }
    }

    if (self.monitorTraitCollectionCompletionHandlerUseUserTK) {
        self.monitorTraitCollectionCompletionHandlerUseUserTK(previousTraitCollection, self);
    }
}





// MARK: - 交换实现主题切换监听绑定
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = self.class;
        SEL selector = NSSelectorFromString(@"TKThemeEnvironment_traitCollectionDidChange:");
        [TKMethodSwap swizzleMethod:cls originSel:@selector(traitCollectionDidChange:) swizzSel:selector];
    });
}

- (void)TKThemeEnvironment_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [self TKThemeEnvironment_traitCollectionDidChange:previousTraitCollection];

    SEL selector = NSSelectorFromString(@"TKThemeEnvironment_requestMonitorThemeHandlerWith:");
    if ([self respondsToSelector:selector]) {
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL,id) = (void *)imp;
        if (func) {
            func(self,selector,previousTraitCollection);
        }
    }
}



@end
