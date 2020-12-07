//
//  TKSDKClearManager.h
//  TKSDKUniversal
//
//  Created by Mac on 2019/3/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 垃圾清理
 */

NS_ASSUME_NONNULL_BEGIN

@interface TKSDKClearManager : NSObject
/** 单利  */
+ (instancetype)shared;


/**
 设置要清理垃圾的目录数组
 */
- (void)setClearPathAry:(NSArray *)clearPathAry;
/**
 计算：获取所有指定路径的缓存大小
 size：获取指定目录的缓存大小后回调,单位M
 PS:是在多线程(非主线程,GCD)中实现的
 */
- (void)getAllCacheSizeSuccess:(void(^)(CGFloat size))success;
/**
 清除缓存：所有指定路径中的缓存
 size: 缓存清理完毕回调
 PS:是在多线程(非主线程,GCD)中实现的
 */
- (void)clearAllCacheSuccess:(void(^)(CGFloat size))success;

@end

NS_ASSUME_NONNULL_END
