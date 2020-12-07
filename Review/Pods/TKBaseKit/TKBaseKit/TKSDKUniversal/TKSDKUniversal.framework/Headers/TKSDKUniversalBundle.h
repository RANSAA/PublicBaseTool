//
//  TKSDKUniversalBundle.h
//  TKSDKUniversal
//
//  Created by PC on 2018/10/18.
//  Copyright © 2018年 PC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * sdk内部获取sdk中的资源使用方式
 * 该sdk中不会使用，可以将该方法放在TKSDKTool中获取其中的bundle资源
 **/

@interface TKSDKUniversalBundle : NSObject

/**
 获取SDK的mainBundle
 如果sdk是framework模式那么mainBundle则是framework文件目录，
 如果sdk是直接拷贝代码到主项目中，那么mainBundle和主项目的mainBundel相同
 */
+ (NSBundle *)mainBundle;

/**
 获取SDK中指定的bundle
 */
+ (nullable NSBundle *)bundleWithName:(NSString *)bundleName;


@end

NS_ASSUME_NONNULL_END
