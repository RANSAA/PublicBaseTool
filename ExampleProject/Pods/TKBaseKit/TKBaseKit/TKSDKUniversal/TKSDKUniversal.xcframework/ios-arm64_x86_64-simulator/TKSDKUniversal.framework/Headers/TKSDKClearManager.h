//
//  TKSDKClearManager.h
//  TKSDKUniversal
//
//  Created by Mac on 2019/3/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
 获取所有指定路径中的缓存大小，单位M。
 success: 缓存计算完成后回调
 PS:该操作是在子线程中进行的。
*/
- (void)getAllCacheSizeSuccess:(void(^)(CGFloat size))success;
/**
 清除指定目录中的所有缓存
 success: 缓存清理完成后回调
 PS:该操作是在子线程中进行的。
*/
- (void)clearAllCacheSuccess:(void(^)(CGFloat size))success;


/**
 获取所有指定路径中的缓存大小，单位M。
 PS:推荐在子线程中获取缓存大小。
 */
- (CGFloat)getAllCacheSize;
/**
 清除指定目录中的所有缓存
 PS:推荐在子线程中清除缓存
 */
- (void)clearAllCache;

@end

NS_ASSUME_NONNULL_END
