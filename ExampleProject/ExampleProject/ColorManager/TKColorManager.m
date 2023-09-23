//
//  TKColorManage.m
//  ThemeDarkManage
//
//  Created by PC on 2022/7/25.
//

#import "TKColorManager.h"

@implementation TKColorManager

/**
 * 模式1：
 * 直接使用alloc创建的单利对象(不是真正意义上的单利)，该类可以创建不同的对象
 *
 * 模式2：
 * 使用[super allocWithZone:NULL]创建单利对象，并重写allocWithZone，可以保证该类只能创建一个对象
 *
 * 可以根据不同需求，选择不同的单利创建模式
 */
+ (instancetype)sheard
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        obj = [[self.class alloc] init];
        obj = [super allocWithZone:NULL];
    });
    return obj;
}

+ (instancetype)allocWithZone:(NSZone *)zone
{
    return [self.class sheard];
}



#pragma color

/**
 功能：使用十六进制的字符串创建颜色，支持两种模式
 模式一：不带透明度的字符串，如：@"#123456",@"0x123456"，@"0X123456",@"123456"等四中写法。
 模式二：带透明度的字符串，如：@"#12345678",@"0x12345678"，@"0X12345678",@"12345678"等四中写法,后两位表示透明度。
 注意：如果传入带透明度的字符串，那么alpha值将无效
*/
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6){
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]){
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6 && [cString length] != 8){
        return [UIColor clearColor];
    }
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    float _alpha = alpha;
    if (cString.length == 8) {
        range.location = 6;
        NSString *aString = [cString substringWithRange:range];
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        _alpha = a/255.0;
    }

    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha: _alpha];
}

/**
从十六进制字符串获取颜色
color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
透明度为1.0
*/
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}


/**
 返回动态UIColor-适配暗夜模式
 正常模式下返回lightColor，暗夜模式下返回darkColor
 如果：darkColor的值为nil，则暗夜模式下返回darkColor的值为lightColor
 PS:iOS13.0以下的系统直接返回lightColor （不支持暗夜模式）
 */
+ (UIColor *)colorWithLight:(nonnull UIColor*)lightColor dark:(nullable UIColor *)darkColor
{
    UIColor *dyColor = nil;
    if (@available(iOS 13.0, *)) {
        UIColor *tmpDarkColor = darkColor?darkColor:lightColor;
        dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return tmpDarkColor;
            }else{
                return lightColor;
            }
        }];
    } else {
        dyColor = lightColor;
    }
    return dyColor;
}




@end




//MARK: - APP主题相关颜色
@implementation TKColorManager (Theme)



+ (UIColor *)colorWhite
{
//    return [self lightText];
    return UIColor.whiteColor;
}

+ (UIColor *)colorTextField
{
    return [self darkText];
}

+ (UIColor *)colorTextFieldPlaceholder
{
    return [self placeholderText];
}

+ (UIColor *)colorTextView
{
    return [self darkText];
}

+ (UIColor *)colorTextViewBackground
{
    return [self colorWithLight:UIColor.whiteColor dark:nil];
}

@end





#pragma mark - iOS13+后系统自带的动态颜色
@implementation TKColorManager (SystemColor)

+ (UIColor *)label
{
    if (@available(iOS 13.0, *)) {
        return [UIColor labelColor];
    }else{
        return [self colorWithHexString:@"#000000ff"];
    }
}

+ (UIColor *)secondaryLabel
{
    if (@available(iOS 13.0, *)) {
        return [UIColor secondaryLabelColor];
    }else{
        return [self colorWithHexString:@"#3c3c4399"];
    }
}
+ (UIColor *)tertiaryLabel
{
    if (@available(iOS 13.0, *)) {
        return [UIColor tertiaryLabelColor];
    }else{
        return [self colorWithHexString:@"#3c3c434c"];
    }
}

+ (UIColor *)quaternaryLabel
{
    if (@available(iOS 13.0, *)) {
        return [UIColor quaternaryLabelColor];
    }else{
        return [self colorWithHexString:@"#3c3c432d"];
    }
}
+ (UIColor *)systemFill
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemFillColor];
    }else{
        return [self colorWithHexString:@"#78788033"];
    }
}

+ (UIColor *)secondarySystemFill
{
    if (@available(iOS 13.0, *)) {
        return [UIColor secondarySystemFillColor];
    }else{
        return [self colorWithHexString:@"#78788028"];
    }
}

+ (UIColor *)tertiarySystemFill
{
    if (@available(iOS 13.0, *)) {
        return [UIColor tertiarySystemFillColor];
    }else{
        return [self colorWithHexString:@"#7676801e"];
    }
}

+ (UIColor *)quaternarySystemFill
{
    if (@available(iOS 13.0, *)) {
        return [UIColor quaternarySystemFillColor];
    }else{
        return [self colorWithHexString:@"#74748014"];
    }
}

+ (UIColor *)placeholderText
{
    if (@available(iOS 13.0, *)) {
        return [UIColor placeholderTextColor];
    }else{
        return [self colorWithHexString:@"#3c3c434c"];
    }
}

+ (UIColor *)systemBackground
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemBackgroundColor];
    }else{
        return [self colorWithHexString:@"#ffffffff"];
    }
}

+ (UIColor *)secondarySystemBackground
{
    if (@available(iOS 13.0, *)) {
        return [UIColor secondarySystemBackgroundColor];
    }else{
        return [self colorWithHexString:@"#f2f2f7ff"];
    }
}

+ (UIColor *)tertiarySystemBackground
{
    if (@available(iOS 13.0, *)) {
        return [UIColor tertiarySystemBackgroundColor];
    }else{
        return [self colorWithHexString:@"#ffffffff"];
    }
}

+ (UIColor *)systemGroupedBackground
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemGroupedBackgroundColor];
    }else{
        return [self colorWithHexString:@"#f2f2f7ff"];
    }
}

+ (UIColor *)secondarySystemGroupedBackground
{
    if (@available(iOS 13.0, *)) {
        return [UIColor secondarySystemGroupedBackgroundColor];
    }else{
        return [self colorWithHexString:@"#ffffffff"];
    }
}

+ (UIColor *)tertiarySystemGroupedBackground
{
    if (@available(iOS 13.0, *)) {
        return [UIColor tertiarySystemGroupedBackgroundColor];
    }else{
        return [self colorWithHexString:@"#f2f2f7ff"];
    }
}

+ (UIColor *)separator
{
    if (@available(iOS 13.0, *)) {
        return [UIColor separatorColor];
    }else{
        return [self colorWithHexString:@"#3c3c4349"];
    }
}

+ (UIColor *)opaqueSeparator
{
    if (@available(iOS 13.0, *)) {
        return [UIColor opaqueSeparatorColor];
    }else{
        return [self colorWithHexString:@"#c6c6c8ff"];
    }
}

+ (UIColor *)link
{
    if (@available(iOS 13.0, *)) {
        return [UIColor linkColor];
    }else{
        return [self colorWithHexString:@"#007affff"];
    }
}

+ (UIColor *)darkText
{
    if (@available(iOS 13.0, *)) {
        return [UIColor darkTextColor];
    }else{
        return [self colorWithHexString:@"#000000ff"];
    }
}


+ (UIColor *)lightText
{
    if (@available(iOS 13.0, *)) {
        return [UIColor lightTextColor];
    }else{
        return [self colorWithHexString:@"#ffffff99"];
    }
}

+ (UIColor *)systemBlue
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemBlueColor];
    }else{
        return [self colorWithHexString:@"#007affff"];
    }
}

+ (UIColor *)systemGreen
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemGreenColor];
    }else{
        return [self colorWithHexString:@"#34c759ff"];
    }
}

+ (UIColor *)systemIndigo
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemIndigoColor];
    }else{
        return [self colorWithHexString:@"#5856d6ff"];
    }
}

+ (UIColor *)systemOrange
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemOrangeColor];
    }else{
        return [self colorWithHexString:@"#ff9500ff"];
    }
}

+ (UIColor *)systemPink
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemPinkColor];
    }else{
        return [self colorWithHexString:@"#ff2d55ff"];
    }
}

+ (UIColor *)systemPurple
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemPurpleColor];
    }else{
        return [self colorWithHexString:@"#af52deff"];
    }
}

+ (UIColor *)systemRed
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemRedColor];
    }else{
        return [self colorWithHexString:@"#ff3b30ff"];
    }
}

+ (UIColor *)systemTeal
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemTealColor];
    }else{
        return [self colorWithHexString:@"#ff3b30ff"];
    }
}

+ (UIColor *)systemYellow
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemYellowColor];
    }else{
        return [self colorWithHexString:@"#ffcc00ff"];
    }
}

+ (UIColor *)systemGray
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemGrayColor];
    }else{
        return [self colorWithHexString:@"#8e8e93ff"];
    }
}

+ (UIColor *)systemGray2
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemGray2Color];
    }else{
        return [self colorWithHexString:@"#aeaeb2ff"];
    }
}

+ (UIColor *)systemGray3
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemGray3Color];
    }else{
        return [self colorWithHexString:@"#c7c7ccff"];
    }
}

+ (UIColor *)systemGray4
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemGray4Color];
    }else{
        return [self colorWithHexString:@"#d1d1d6ff"];
    }
}

+ (UIColor *)systemGray5
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemGray5Color];
    }else{
        return [self colorWithHexString:@"#e5e5eaff"];
    }
}

+ (UIColor *)systemGray6
{
    if (@available(iOS 13.0, *)) {
        return [UIColor systemGray6Color];
    }else{
        return [self colorWithHexString:@"#f2f2f7ff"];
    }
}


@end
