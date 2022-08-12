//
//  NSObject+TKSDK.h
//  TKSDKUniversal
//
//  Created by Mac on 2019/3/22.
//  Copyright © 2019年 Mac. All rights reserved.
//
/**
 学习网址：https://www.jianshu.com/p/6c6f3a24b1ef
 **/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (TKSDK)

#pragma mark Selector
/**
 功能：可以传递多个参数的performSelector方法
 @param selector 调用的方法，注意selector中的基础类型需要包装成类类型
 @param objects 参数数组
 警告：原selector方法返回类型包装方式：1.基础数据类型将会被包装为NSNumber。2.struct类型会被包装成NSValue,然后可以使用NSValue的getValue方法获取到具体的结构体数据。
 */
- (id)performSelector:(SEL)selector withObjects:(nullable NSArray *)objects;
+ (id)performSelector:(SEL)selector withObjects:(nullable NSArray *)objects;

@end

NS_ASSUME_NONNULL_END
