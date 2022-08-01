//
//  TKMethodSwap.h
//  ExampleProject
//
//  Created by PC on 2022/7/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKMethodSwap : NSObject

/**
 函数交换
 交换类中的方法： Class.class -> self.class
 交换对象中的方法: obj.class -> objc_getClass("__NSArrayI");
 */
+ (void)swizzleMethod:(Class)class originSel:(SEL)originSel swizzSel:(SEL)swizzledSel;

@end

NS_ASSUME_NONNULL_END
