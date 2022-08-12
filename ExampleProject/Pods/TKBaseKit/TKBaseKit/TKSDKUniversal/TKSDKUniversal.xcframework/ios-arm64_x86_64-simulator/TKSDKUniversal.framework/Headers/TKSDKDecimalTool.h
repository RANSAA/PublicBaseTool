//
//  TKSDKDecimalTool.h
//  testText
//
//  Created by PC on 2021/10/3.
//

/**
 功能：多种进制相互转换工具，支持正数(整数，小数)，不支持负数。
 提示：
    1.与十进制数相关转换可以直接通过计算得出，小数部分说明：
        十进制转other：乘2/8/16取整，顺序排列
        other转十进制：顺序球x的负n次冥，依次相加
    2.二进制/八进制/十六进制相符转化时，可以使用三/四分发通过二进制转换，也可以通过十进制中转。
 PS:https://blog.csdn.net/meegomeego/article/details/49948241
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 十进制转换到其它进制时小数部分的精度值,该数是一个小于1的小数，精度最高取值为0.0
 推荐两个值：0.0， 0.0001
 */
#define kDecToOtherSmallPrecision 0.0


@interface TKSDKDecimalTool : NSObject

#pragma mark 十六进制与字符串互转


/// 普通字符串转换成16进制字符串
/// @param string 输入的普通字符串
+ (NSString *)hexStringFromString:(nonnull NSString *)string;

/// 16进制字符串转换成普通字符串
/// @param hexString 输入的16进制字符串
+ (NSString *)stringFromHexString:(nonnull NSString *)hexString;


#pragma mark 与十进制相互转换
//二进制转十进制
+ (NSString *)binToDec:(NSString *)binString;
//八进制转换十进制
+ (NSString *)octToDec:(NSString *)octString;
//十六进制转换十进制
+ (NSString *)hexToDec:(NSString *)hexString;
//十进制转二进制
+ (NSString *)decToBin:(NSString *)decString;
//十进制转八进制
+ (NSString *)decToOct:(NSString *)decString;
//十进制转十六进制
+ (NSString *)decToHex:(NSString *)decString;


#pragma mark 下面区域的进制转换可以通过十进制中转
//二进制转八进制
+ (NSString *)binToOct:(NSString *)binString;
//八进制转二进制
+ (NSString *)octToBin:(NSString *)octString;
//二进制转十六进制
+ (NSString *)binToHex:(NSString *)binString;
//十六进制转二进制
+ (NSString *)hexToBin:(NSString *)hexString;
//八进制转十六进制
+ (NSString *)octToHex:(NSString *)octString;
//十六进制转八进制
+ (NSString *)hexToOct:(NSString *)hexString;


@end

NS_ASSUME_NONNULL_END
