//
//  TKMethodSwap.m
//  ExampleProject
//
//  Created by PC on 2022/7/31.
//

#import "TKMethodSwap.h"
#import <objc/runtime.h>

@implementation TKMethodSwap

#pragma mark - 提供函数交换方法

/**
 函数交换
 交换类中的方法： Class.class -> self.class
 交换对象中的方法: obj.class -> objc_getClass("__NSArrayI");
 */
+ (void)swizzleMethod:(Class)class originSel:(SEL)originSel swizzSel:(SEL)swizzledSel
{
    Method originaMethod = class_getInstanceMethod(class, originSel);
    Method swizzleMethod = class_getInstanceMethod(class, swizzledSel);

    if (!originaMethod || !swizzleMethod) {
      return ;
    }

// 方式一：
    class_addMethod(class,
                    originSel,
                    class_getMethodImplementation(class, originSel),
                    method_getTypeEncoding(originaMethod));
    class_addMethod(class,
                    swizzledSel,
                    class_getMethodImplementation(class, swizzledSel),
                    method_getTypeEncoding(swizzleMethod));
    method_exchangeImplementations(class_getInstanceMethod(class, originSel),
                                   class_getInstanceMethod(class, swizzledSel));


//// 方式二：
//    BOOL didAddMethod = class_addMethod(class,
//                                        originSel,
//                                        method_getImplementation(swizzleMethod),
//                                        method_getTypeEncoding(swizzleMethod));
//    if (didAddMethod) {
//        class_replaceMethod(class,
//                            swizzledSel,
//                            method_getImplementation(originaMethod),
//                            method_getTypeEncoding(originaMethod));
//    } else {
//        method_exchangeImplementations(originaMethod, swizzleMethod);
//    }
    
}


/**
 新增：交换实例对象中的方法
 */
+ (void)exchangeInstanceMethod:(Class)class originSel:(SEL)originSel swizzSel:(SEL)swizzledSel
{
    Method originaMethod = class_getInstanceMethod(class, originSel);
    Method swizzleMethod = class_getInstanceMethod(class, swizzledSel);

    if (!originaMethod || !swizzleMethod) {
      return ;
    }
    
    BOOL didAddMethod = class_addMethod(class,
                                        originSel,
                                        method_getImplementation(swizzleMethod),
                                        method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSel,
                            method_getImplementation(originaMethod),
                            method_getTypeEncoding(originaMethod));
    } else {
        method_exchangeImplementations(originaMethod, swizzleMethod);
    }
}


/**
 新增：交换类中的方法
 */
+ (void)exchangeClassMethod:(Class)class originSel:(SEL)originSel swizzSel:(SEL)swizzledSel
{
    Method originaMethod = class_getClassMethod(class, originSel);
    Method swizzleMethod = class_getClassMethod(class, swizzledSel);

    if (!originaMethod || !swizzleMethod) {
      return ;
    }
    
    BOOL didAddMethod = class_addMethod(class,
                                        originSel,
                                        method_getImplementation(swizzleMethod),
                                        method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSel,
                            method_getImplementation(originaMethod),
                            method_getTypeEncoding(originaMethod));
    } else {
        method_exchangeImplementations(originaMethod, swizzleMethod);
    }
}



@end
