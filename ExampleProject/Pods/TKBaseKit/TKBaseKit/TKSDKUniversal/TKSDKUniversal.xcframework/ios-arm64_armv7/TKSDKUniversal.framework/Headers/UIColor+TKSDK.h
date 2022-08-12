//
//  UIColor+TKSDK.h
//  TKSDKUniversal
//
//  Created by Mac on 2019/3/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (TKSDK)

/**
 使用十六进制的字符串创建颜色，支持两种模式
 模式一：不带透明度的字符串，如：@"#123456",@"0x123456"，@"0X123456",@"123456"等四中写法。
 模式二：带透明度的字符串，如：@"#12345678",@"0x12345678"，@"0X12345678",@"12345678"等四中写法,后两位表示透明度。
 透明度默认为1.0
*/
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 使用十六进制的字符串创建颜色，支持两种模式
 模式一：不带透明度的字符串，如：@"#123456",@"0x123456"，@"0X123456",@"123456"等四中写法。
 模式二：带透明度的字符串，如：@"#12345678",@"0x12345678"，@"0X12345678",@"12345678"等四中写法,后两位表示透明度。
 注意：如果传入带透明度的字符串，那么alpha值将无效
*/
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 从十进制数值创建颜色
 color 格式： red:255  green:255 blue:255
 透明度 1.0
 */
+ (UIColor *)colorWithDecRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

/**
 从十进制数值创建颜色
 color 格式： red:255  green:255 blue:255 1.0
 */
+ (UIColor *)colorWithDecRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 返回动态UIColor-适配暗夜模式
 正常模式下返回lightColor，暗夜模式下返回darkColor
 如果：darkColor的值为nil，则暗夜模式下返回darkColor的值为lightColor
 PS:iOS13.0以下的系统直接返回lightColor （不支持暗夜模式）
 */
+ (UIColor *)colorWithLight:(nonnull UIColor*)lightColor dark:(nullable UIColor *)darkColor;

/**
 创建一个随机颜色
 */
+ (UIColor *)colorRandom;

@end

NS_ASSUME_NONNULL_END
