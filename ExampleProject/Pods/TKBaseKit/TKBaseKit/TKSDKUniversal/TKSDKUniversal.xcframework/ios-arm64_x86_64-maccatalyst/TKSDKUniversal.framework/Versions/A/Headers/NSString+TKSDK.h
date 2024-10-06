//
//  NSString+TKSDK.h
//  TKSDKUniversal
//
//  Created by Mac on 2019/3/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

/**
 NSString的一些常用扩展
 **/
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TKSDK)

/**
获取字符串拼音的大写首字母
str:输入的字符串
firstChar:用于替换字符串拼音首字母不在A-Z区间时返回的字符,如果为nil,则不替换。
*/
+ (NSString *)TKGetFirstCharactorWith:(NSString *)str firstChar:(nullable NSString *)firstChar;

/**
获取字符串拼音的大写首字母
str:输入的字符串
firstChar:用于替换字符串拼音首字母不在A-Z区间时返回的字符,如果为nil,则不替换。
isNum:返回首字母是否包含数字区间，并且只有firstChar不为nil才有效
*/
+ (NSString *)TKGetFirstCharactorWith:(NSString *)str firstChar:(nullable NSString *)firstChar isNum:(BOOL)isNum;

/**
 将字符串数组按升序方式进行排序
 排序例子： @"123"，@"abc"，@"汉字"
 */
+ (NSArray *)TKSortedAscendingWith:(NSArray<NSString *> *)strAry;

/**
 将字符串数组按降序方式进行排序
 排序例子： @"汉字"，@"abc"，@"123"
 */
+ (NSArray *)TKSortedDescendingWith:(NSArray<NSString *> *)strAry;

/**
将字符串数组按升序方式进行排序,中文优先排序
排序例子： @"123"，@"汉字"，@"abc"
*/
+ (NSArray *)TKSortedAscendingChinesePriorityWith:(NSArray<NSString *> *)strAry;

/**
将字符串数组按降序方式进行排序,中文后排序
排序例子： @"abc"，@"汉字",@"123"
*/
+ (NSArray *)TKSortedDescendingChinesePriorityWith:(NSArray<NSString *> *)strAry;

/** URL编码 */
+ (NSString *)TKURLEncodedStringWith:(NSString *)url;

/** URL解码 */
+ (NSString *)TKURLDecodedStringWith:(NSString *)url;

/**
 Base64 URL Safe 编码
 see:https://www.jianshu.com/p/160e421d131b
 see:https://programmer.help/blogs/5c597b84891d3.html
 */
+ (NSString *)TKBase64SafeEncoderStringWith:(NSString *)str;

/**
 Base64 URL Safe 解码
 see:https://www.jianshu.com/p/160e421d131b
 see:https://programmer.help/blogs/5c597b84891d3.html
 */
+ (NSString *)TKBase64SafeDecoderStringWith:(NSString *)str;

/**
 Base64 编码
 */
+ (NSString *)TKBase64EncoderStringWith:(NSString *)str;

/**
 Base64 解码
 */
+ (NSString *)TKBase64DecoderStringWith:(NSString *)str;


/**
 判断字符串是否是数字,即整数或者小数
 样式：
    12345  123456.0
    -123456 -123456.0
    +123456 +123456.0
 */
+ (BOOL)TKIsNumberWithString:(NSString *)strValue;

/**
 判断字符串是否为整数
 */
+ (BOOL)TKIsIntWithString:(NSString *)strValue;

/**
 判断字符串是否为小数
 */
+ (BOOL)TKIsFloatWithString:(NSString *)strValue;



/**
 HTML转富文本
 */
+ (nullable NSAttributedString *)TKHTMLConverAttrStringWith:(NSString *)htmlString;

/**
 解析HTML中的图片地址
 */
+ (NSArray *)TKHTMLFilterImagesWith:(NSString *)htmlString;


/**
 计算字符串的高度或者宽度
 @param string 字符串类型为：NSString，NSAttributedString等
 @param fixed 需要固定的的值(计算高度就要固定宽度的值，反之亦然)
 @param type 0:计算字符串的高度 1：计算字符串的宽度
 @param attr string为NSString类型时，字符串的属性，如字体大小，类型等！
 @return 返回字符串的高度或者宽度
 */
+ (CGFloat)TKGetTextHighOrWideString:(id)string fixed:(CGFloat)fixed type:(NSInteger)type attributes:(nullable NSDictionary *)attr;


/**
 APP版本检测比较(字符串比较) V1>V2 返回YES
 return YES: 表示可升级
 */
+ (BOOL)TKUpdateCompareStringWith:(NSString *)v1 fast:(NSString *)v2;

/**
 去除小数点后多余的0，并返回去除0之后的字符串；
 maxLength:小数点后最大的长度 == 6
 */
+ (NSString *)TKStringRemoveExcessZeroWith:(CGFloat)value;
/**
 去除小数点后多余的0，并返回去除0之后的字符串
 maxLength:小数点后最大的长度
 示例:
 23.056 -> @"23.056"
 23.500 -> @"23.5"
 23.000 -> @"23"
 23.    -> @"23"
 23     -> @"23"
 */
+ (NSString *)TKStringRemoveExcessZeroWith:(CGFloat)value maxLength:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
