//
//  TKColorManage.h
//  ThemeDarkManage
//
//  Created by PC on 2022/7/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKColorManage : NSObject

+ (instancetype)sheard;

/**
 功能：使用十六进制的字符串创建颜色，支持两种模式
 模式一：不带透明度的字符串，如：@"#123456",@"0x123456"，@"0X123456",@"123456"等四中写法。
 模式二：带透明度的字符串，如：@"#12345678",@"0x12345678"，@"0X12345678",@"12345678"等四中写法,后两位表示透明度。
 注意：如果传入带透明度的字符串，那么alpha值将无效
*/
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 返回动态UIColor-适配暗夜模式
 正常模式下返回lightColor，暗夜模式下返回darkColor
 如果：darkColor的值为nil，则暗夜模式下返回darkColor的值为lightColor
 PS:iOS13.0以下的系统直接返回lightColor （不支持暗夜模式）
 */
+ (UIColor *)colorWithLight:(nonnull UIColor*)lightColor dark:(nullable UIColor *)darkColor;

@end




//MARK: - APP主题相关颜色
#define kWhite [TKColorManage white]
#define kTextField [TKColorManage textFieldText]
#define kTextFieldPlaceholder [TKColorManage textFieldPlaceholder]
#define kTextView [TKColorManage textViewText]


@interface TKColorManage (Theme)

+ (UIColor *)white;
+ (UIColor *)textFieldText;
+ (UIColor *)textFieldPlaceholder;
+ (UIColor *)textViewText;


@end




#pragma mark - iOS13+后系统自带的动态颜色
/**
 iOS13+后系统自带的动态颜色
 详解：https://noahgilmore.com/blog/dark-mode-uicolor-compatibility/
 */

@interface TKColorManage (SystemColor)

+ (UIColor *)label;
+ (UIColor *)secondaryLabel;
+ (UIColor *)tertiaryLabel;
+ (UIColor *)quaternaryLabel;
+ (UIColor *)systemFill;
+ (UIColor *)secondarySystemFill;
+ (UIColor *)tertiarySystemFill;
+ (UIColor *)quaternarySystemFill;
+ (UIColor *)placeholderText;
+ (UIColor *)systemBackground;
+ (UIColor *)secondarySystemBackground;
+ (UIColor *)tertiarySystemBackground;
+ (UIColor *)systemGroupedBackground;
+ (UIColor *)secondarySystemGroupedBackground;
+ (UIColor *)tertiarySystemGroupedBackground;
+ (UIColor *)separator;
+ (UIColor *)opaqueSeparator;
+ (UIColor *)link;
+ (UIColor *)darkText;
+ (UIColor *)lightText;
+ (UIColor *)systemBlue;
+ (UIColor *)systemGreen;
+ (UIColor *)systemIndigo;
+ (UIColor *)systemOrange;
+ (UIColor *)systemPink;
+ (UIColor *)systemPurple;
+ (UIColor *)systemRed;
+ (UIColor *)systemTeal;
+ (UIColor *)systemYellow;
+ (UIColor *)systemGray;
+ (UIColor *)systemGray2;
+ (UIColor *)systemGray3;
+ (UIColor *)systemGray4;
+ (UIColor *)systemGray5;
+ (UIColor *)systemGray6;

@end

NS_ASSUME_NONNULL_END
