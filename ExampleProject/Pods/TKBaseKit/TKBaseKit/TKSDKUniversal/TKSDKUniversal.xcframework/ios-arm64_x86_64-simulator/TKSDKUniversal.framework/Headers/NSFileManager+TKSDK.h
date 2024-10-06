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

//MARK: - 添加，删除，移动
/** 如果目录不存在则创建，允许创建多级子目录 */
- (void)createDirectoryAtPath:(NSString *)path;

/**删除文件**/
- (BOOL)deleteWithPath:(NSString *)path;
/**删除文件**/
- (BOOL)deleteWithURL:(NSURL *)url;

/**
 功能：move，新增覆盖功能
 overwrite：是否覆盖
 */
- (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath overwrite:(BOOL)overwrite error:(NSError **)error;
/**
 功能：move，新增覆盖功能
 overwrite：是否覆盖
 */
- (BOOL)moveItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL overwrite:(BOOL)overwrite error:(NSError **)error;


/**
 功能：copy，新增覆盖功能
 overwrite：是否覆盖
 */
- (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath overwrite:(BOOL)overwrite error:(NSError **)error;
/**
 功能：copy，新增覆盖功能
 overwrite：是否覆盖
 */
- (BOOL)copyItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL overwrite:(BOOL)overwrite error:(NSError **)error;


//MARK: - 文件相关

/** 获取路径中的文件大小，如果是目录则计算目录的总大小，单位：字节 */
+ (NSUInteger)TKFileSizeWithPath:(NSString *)path;

/**
 将字节大小转换到对应的单位；byteSize为字节数。
 如：Bytes，KB，MB，GB，TB，PB, ...
 */
+ (NSString *)TKUnitConversionWithByteSize:(NSUInteger)fileSizeBytes;





//MARK: - 目录相关

/**
 获取Document这个目录
 */
+ (NSString *)TKGetStorageDocument;

/**
 获取Caches这个目录
 */
+ (NSString *)TKGetStorageCaches;

/**
 获取tmp这个目录
 */
+ (NSString *)TKGetStorageTmp;

/**
 获取Library这个目录
 */
+ (NSString *)TKGetStorageLibrary;

/**
 获取Library/Preferences这个目录
 */
+ (NSString *)TKGetStoragePreferences;

/**
 获取TK用户的专属目录：Library/TKStorageFolder，如果目录不存在会自动创建
 注意:这个目录不能被《文件》这个应用访问
 */
+ (NSString *)TKGetStorageFolder;

/**
获取NSBundle中的指定目录(不包括子目录)中的所有文件路径，并以升序方式进行排序
bundle: 需要获取文件的bundle
dirName:目录名称，例如:nil, /, dir_1 , dir1/dir2/dir3
isPath: 是否返回全路径，YES:返回全路径 NO:只返回文件名称
*/
+ (NSArray *)TKGetAllFilePathWithBundle:(NSBundle *)bundle dirName:(NSString *)dirName isPath:(BOOL)isPath;

/** 判断path是否是目录*/
+ (BOOL)TKIsDirWithPath:(NSString *)path;

/** 判断path是否是文件，但并不是目录*/
+ (BOOL)TKIsFileWithPath:(NSString *)path;

@end




NS_ASSUME_NONNULL_END
