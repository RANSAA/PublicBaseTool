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
 从十六进制字符串获取颜色
 color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 透明度为1.0
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 从十六进制字符串获取颜色
 color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
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
 :https://blog.csdn.net/shifang07/article/details/101307247
 */
+ (UIColor *)TKLightColor:(nonnull UIColor *)lightColor darkColor:(nullable UIColor *)darkColor;


@end

NS_ASSUME_NONNULL_END
