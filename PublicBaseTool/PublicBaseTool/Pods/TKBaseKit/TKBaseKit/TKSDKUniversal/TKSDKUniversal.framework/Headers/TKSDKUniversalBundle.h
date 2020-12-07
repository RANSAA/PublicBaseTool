//
//  TKSDKUniversalBundle.h
//  TKSDKUniversal
//
//  Created by PC on 2018/10/18.
//  Copyright © 2018年 PC. All rights reserved.
//

#import <Foundation/Foundation.h>


/** 声明获取TKSDKUniversal中的bundle对象 **/

//#define TKSDKBundle   [TKSDKUniversalBundle getTKSDKUniversalBundle]

NS_ASSUME_NONNULL_BEGIN

/**
 * sdk内部获取sdk中的资源使用方式
 **/

@interface TKSDKUniversalBundle : NSObject

/** 获取TKSDKUniversal的bundleID */
+ (NSString *)TK_getSDKUniversalBundleID;
/** 获取TKSDKUniversal中的bundleID，用于获取xib， 资源等数据额bundle */
+ (NSBundle *)TK_getSDKUniversalBundle;
/**
 * 直接获取TKSDKUniversal的bundle，如果没有则获取main bundle
 **/
+ (NSBundle *)TK_getBundle;

@end

NS_ASSUME_NONNULL_END
