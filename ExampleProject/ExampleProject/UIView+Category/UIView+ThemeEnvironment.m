//
//  UIView+ThemeEnvironment.m
//  ExampleProject
//
//  Created by PC on 2022/8/14.
//

#import "UIView+ThemeEnvironment.h"
#import "TKMethodSwap.h"
#import <objc/runtime.h>

API_AVAILABLE(ios(12.0)) typedef void(^TKMonitorThemeBlock)(UIUserInterfaceStyle theme, UIView* view);
API_AVAILABLE(ios(12.0)) @interface UIView ()
@property(nonatomic, copy) TKMonitorThemeBlock monitorThemeCompletionHandlerCache;
@end

API_AVAILABLE(ios(12.0)) @implementation UIView (ThemeEnvironment)

// MARK: - add property
- (void)setMonitorThemeCompletionHandlerCache:(TKMonitorThemeBlock)completionHandler
{
    objc_setAssociatedObject(self, @selector(monitorThemeCompletionHandlerCache), completionHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TKMonitorThemeBlock)monitorThemeCompletionHandlerCache
{
    return objc_getAssociatedObject(self, @selector(monitorThemeCompletionHandlerCache));
}

// MARK: 请求监听绑定
- (void)ThemeEnvironment_requestMonitorThemeHandlerWith:(UITraitCollection *)previousTraitCollection
{
    if (@available(iOS 13.0, *)) {
        //主题切换才会调用
        if (self.monitorThemeCompletionHandlerCache) {
            //判断当前模式是否发生变化，因为屏幕旋转也会触发该方法。
            if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
                __weak typeof(self)weakSelf = self;
                self.monitorThemeCompletionHandlerCache(self.traitCollection.userInterfaceStyle, weakSelf);
            }
//            NSLog(@"self.monitorThemeCompletionHandlerCache:%@      class:%@",self.monitorThemeCompletionHandlerCache,self.class);
        }
        //other
    }
}

// MARK: - 绑定监听显示主题切换
- (void)bingMonitorTheme:(void(^)(UIUserInterfaceStyle theme, UIView* view))completionHandler;
{
    self.monitorThemeCompletionHandlerCache = completionHandler;
}

// MARK: - 交换实现主题切换监听绑定
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = self.class;
        SEL selector = NSSelectorFromString(@"ThemeEnvironment_traitCollectionDidChange:");
        [TKMethodSwap swizzleMethod:cls originSel:@selector(traitCollectionDidChange:) swizzSel:selector];
    });
}

- (void)ThemeEnvironment_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [self ThemeEnvironment_traitCollectionDidChange:previousTraitCollection];
    SEL selector = NSSelectorFromString(@"ThemeEnvironment_requestMonitorThemeHandlerWith:");
    if ([self respondsToSelector:selector]) {
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL,id) = (void *)imp;
        if (func) {
            func(self,selector,previousTraitCollection);
        }
    }
}

@end




@implementation UIImageView (ThemeEnvironment)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = self.class;
        SEL selector = NSSelectorFromString(@"ThemeEnvironment_traitCollectionDidChange:");
        [TKMethodSwap swizzleMethod:cls originSel:@selector(traitCollectionDidChange:) swizzSel:selector];
    });
}

- (void)ThemeEnvironment_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [self ThemeEnvironment_traitCollectionDidChange:previousTraitCollection];
    SEL selector = NSSelectorFromString(@"ThemeEnvironment_requestMonitorThemeHandlerWith:");
    if ([self respondsToSelector:selector]) {
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL,id) = (void *)imp;
        if (func) {
            func(self,selector,previousTraitCollection);
        }
    }
}

@end





@implementation UILabel (ThemeEnvironment)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = self.class;
        SEL selector = NSSelectorFromString(@"ThemeEnvironment_traitCollectionDidChange:");
        [TKMethodSwap swizzleMethod:cls originSel:@selector(traitCollectionDidChange:) swizzSel:selector];
    });
}

- (void)ThemeEnvironment_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [self ThemeEnvironment_traitCollectionDidChange:previousTraitCollection];
    SEL selector = NSSelectorFromString(@"ThemeEnvironment_requestMonitorThemeHandlerWith:");
    if ([self respondsToSelector:selector]) {
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL,id) = (void *)imp;
        if (func) {
            func(self,selector,previousTraitCollection);
        }
    }
}

@end
