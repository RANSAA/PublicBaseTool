//
//  TKSDKToolBase.h
//  TKSDKTool
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 PC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKSDKToolBase : NSObject

/**
 创建目录
 */
+ (void)TKCreateStorageFolder:(NSString *)path;

/**
 获取TK在沙盒中的存储目录
 */
+ (NSString *)TKGetStorageFolder;


@end

NS_ASSUME_NONNULL_END
