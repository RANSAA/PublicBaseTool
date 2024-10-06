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
/** 添加需要清理的path路径 */
- (void)addClearPath:(NSString*)path;


/**
 获取所有指定路径中文件的大小，单位字节
 */
- (NSUInteger)getAllCacheSize;
/**
 获取clearPaths中指定路径所有文件的大小，并进行单位格式化
 */
- (NSString *)getAllCacheSizeString;
/**
 删除clearPaths中所有路径对应的文件
 */
- (void)clearAllCaches;



/** 获取路径中的文件大小，如果是目录则计算目录的总大小，单位：字节 */
- (NSUInteger)fileSizeWithPath:(NSString *)path;
/** 删除指定路径对应的文件/目录 */
- (void)removeWithPath:(NSString *)path;


@end

NS_ASSUME_NONNULL_END
