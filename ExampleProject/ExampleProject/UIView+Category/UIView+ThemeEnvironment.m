//
//  UIView+ThemeEnvironment.m
//  ExampleProject
//
//  Created by PC on 2022/8/14.
//

#import "UIView+ThemeEnvironment.h"
#import "TKMethodSwap.h"
#import <objc/runtime.h>

API_AVAILABLE(ios(12.0)) typedef void(^TKMonitorThemeViewBlock)(UIUserInterfaceStyle theme, UIView* view);
API_AVAILABLE(ios(8.0)) typedef void(^TKMonitorTraitCollectionViewBlock)(UITraitCollection *traitCollection, UIView* view);
API_AVAILABLE(ios(12.0)) @interface UIView ()
@property(nonatomic, copy) TKMonitorThemeViewBlock monitorThemeCompletionHandlerUseUserTK;
@property(nonatomic, copy) TKMonitorTraitCollectionViewBlock monitorTraitCollectionCompletionHandlerUseUserTK;
@end

API_AVAILABLE(ios(12.0)) @implementation UIView (ThemeEnvironment)

// MARK: - add property

- (void)setMonitorThemeCompletionHandlerUseUserTK:(TKMonitorThemeViewBlock)completionHandler
{
    objc_setAssociatedObject(self, @selector(monitorThemeCompletionHandlerUseUserTK), completionHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TKMonitorThemeViewBlock)monitorThemeCompletionHandlerUseUserTK
{
    return objc_getAssociatedObject(self, @selector(monitorThemeCompletionHandlerUseUserTK));
}

- (void)setMonitorTraitCollectionCompletionHandlerUseUserTK:(TKMonitorTraitCollectionViewBlock)completionHandler
{
    objc_setAssociatedObject(self, @selector(monitorTraitCollectionCompletionHandlerUseUserTK), completionHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TKMonitorTraitCollectionViewBlock)monitorTraitCollectionCompletionHandlerUseUserTK
{
    return objc_getAssociatedObject(self, @selector(monitorTraitCollectionCompletionHandlerUseUserTK));
}


// MARK: - 绑定监听变化
/**
 绑定监听显示主题切换
 */
- (void)bingMonitorTheme:(void(^)(UIUserInterfaceStyle style, UIView* view))completionHandler
{
    self.monitorThemeCompletionHandlerUseUserTK = completionHandler;
}

/**
 绑定监听TraitCollectionDidChange:
 */
- (void)bingMonitorTraitCollection:(void(^)(UITraitCollection *previousTraitCollection, UIView* view))completionHandler
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

    /**
     performSelector:方法调用通过String创建的selector会出现内存可能会泄露警告，解决方法可直接通过函数指针方式调用，如下：
     */
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




@implementation UIImageView (ThemeEnvironment)

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





@implementation UILabel (ThemeEnvironment)

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
