//
//  TKSDKEncryptTool.h
//  TKSDKTool
//
//  Created by Mac on 2019/5/25.
//  Copyright © 2019 PC. All rights reserved.
//

/**
 常用的加密，解密工具
 PS:需要导入Security.framework框架
 **/
#import <Foundation/Foundation.h>
#import "TKSDKToolExternalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKSDKEncryptTool : NSObject

#pragma mark ---DES加密解密---
/**
 DES加密
 @param plainText 需要被加密的明文
 @param key 加密密码
 @param ivStr 加盐字符串
 @param isHex YES:返回数据格式为16进制 NO:返回数据格式为base64
 @return 返回加密的密文
 PS:与解密参数要保持一些
 */
+ (NSString *)TKEncryptUseDES:(NSString *)plainText key:(NSString *)key ivStr:(nullable NSString*)ivStr isHex:(BOOL)isHex;
/**
 DES 解密
 @param cipherText 被加密的密文
 @param key 解密所用的key
 @param ivStr 加盐字符串
 @param isHex YES:返回数据格式为16进制 NO:返回数据格式为base64
 @return 返回解密之后的str
 PS:与加密参数要保持一些
 */
+ (NSString *)TKDecryptUseDES:(NSString *)cipherText key:(NSString *)key ivStr:(nullable NSString*)ivStr isHex:(BOOL)isHex;

#pragma mark ---散列/哈希(Hash/MD5)----
/** MD5  32位小写  */
+ (NSString *)TKMd5Input:(NSString *)input;
/** SHA1 加密 **/
+ (NSString *)TKHashSha1Input:(NSString *)input;
/** SHA224 加密 **/
+ (NSString *)TKHashSha224Input:(NSString *)input;
/** SHA256加密 **/
+ (NSString *)TKHashSha256Input:(NSString*)input;
/** SHA384加密 **/
+ (NSString *)TKHashSha384Input:(NSString*)input;
/** SHA512加密 **/
+ (NSString *)TKHashSha512Input:(NSString*)input;
#pragma mark ---散列/哈希Hmac-(Hash/MD5)----
/** Hmac-MD5   */
+ (NSString *)TKHmacMd5Input:(NSString *)input key:(NSString*)key;
/** Hmac-SHA1   */
+ (NSString *)TKHmacSha1Input:(NSString *)input key:(NSString*)key;
/** Hmac-SHA224   */
+ (NSString *)TKHmacSha224Input:(NSString *)input key:(NSString*)key;
/** Hmac-SHA256   */
+ (NSString *)TKHmacSha256Input:(NSString *)input key:(NSString*)key;
/** Hmac-SHA384   */
+ (NSString *)TKHmacSha384Input:(NSString *)input key:(NSString*)key;
/** Hmac-SHA512   */
+ (NSString *)TKHmacSha512Input:(NSString *)input key:(NSString*)key;
/**
 PBKDF2-SHA256
 PBKDF 全拼Password-Base Key Derivation Function，就是一个用来导出密钥的函数，经常用于生成加密的密码。
 key:key或者说明文
 salt:盐
 PS:这个方法可能根据具体的情况有很大的不同，需要根据实际情况处理
 */
+ (NSString *)TKPBKDF2Key:(NSString*)key salt:(NSString *)salt;

@end

NS_ASSUME_NONNULL_END
