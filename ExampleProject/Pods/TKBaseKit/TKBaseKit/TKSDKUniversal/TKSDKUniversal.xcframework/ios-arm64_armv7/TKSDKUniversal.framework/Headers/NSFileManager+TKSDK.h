//
//  NSFileManager+TKSDK.h
//  TKBaseKit
//
//  Created by PC on 2022/3/25.
//  Copyright © 2022 PC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (TKSDK)

/**
 检查文件是否存在，如果存在则删除(不区分是文件还是目录)
 */
- (void)checkFileExitsToPath:(NSString *)toPath;
- (void)checkFileExitsToURL:(NSURL *)toURL;

/**
 功能：move，新增覆盖功能
 overwrite：是否覆盖
 */
- (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath overwrite:(BOOL)overwrite error:(NSError **)error;
/**
 功能：copy，新增覆盖功能
 overwrite：是否覆盖
 */
- (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath overwrite:(BOOL)overwrite error:(NSError **)error;



/**
 功能：move，新增覆盖功能
 overwrite：是否覆盖
 */
- (BOOL)moveItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL overwrite:(BOOL)overwrite error:(NSError **)error;
/**
 功能：copy，新增覆盖功能
 overwrite：是否覆盖
 */
- (BOOL)copyItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL overwrite:(BOOL)overwrite error:(NSError **)error;


@end

NS_ASSUME_NONNULL_END
