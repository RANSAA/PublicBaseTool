//
//  NSString+TK.h
//  AdultLP
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//移出字符串中的空格
#define kStrRemovSpace(str) [str stringByReplacingOccurrencesOfString:@" " withString:@""]

@interface NSString (TK)

///** 解析html中的图片地址 **/
//+ (NSArray *)TKHtmlFilterImagesWithStr:(NSString *)htmlStr;

/**
 时间戳转换成时间字符串
 格式：2019/07/09 10:27:55
 **/
+ (NSString *)TKTimeConvertStrWithTimeStamp:(NSInteger )timesTamp;

/**
 时间戳转换成时间字符串
 格式：2019-07-09 10:27:55
 **/
+ (NSString *)TKTimeConvertStrWithStyle:(NSInteger)timesTamp;

/**
 时间戳转换成时间字符串
 格式：2019-07-09
 **/
+ (NSString *)TKTimeConvertStrWithStyleDate:(NSInteger)timesTamp;

/** 将秒数转化成时间字符串
 格式：3小时5分45秒
 */
+ (NSString *)TKTimeConvertStrWithSecond:(NSInteger)second;

/**
 将秒数转化成时间字符串
 格式：120:23(120分钟23秒), 00:01
 */
+ (NSString *)TKTimeConvertStrWithStyleSecond:(NSInteger)second;

/**
 去除字符串开头和结尾的空格,和\t
 **/
+ (NSString *)TKStringRemoveBeginAndEnd:(NSString *)str;

/**
 将float转成字符串，如果末尾小数为0
 则将小数尾数向前移动一位
 PS:即为去除小数点后面的0
 **/
+ (NSString *)TKStringRemoveZeroWithFloat:(CGFloat)Float;

/**
 获取字符串中所有子字符串重复出现的位置NSRange Array
 备注：得到返回的数组后，取出来的元素是NSValue，需要转换成NSRange使用
 NSRange range = [value rangeValue];
 **/
+ (NSArray *)TKStringRangeInStr:(NSString *)inStr subStr:(NSString *)subStr;

/**
 获取字符串中，子字符串重复出现的次数
 **/
+ (NSInteger)TKStringNumberInStr:(NSString *)inStr subStr:(NSString *)subStr;

/**
 将字符串中的每个字符排序
 主要用来排@"ACB"-->@"ABC"
 PS:排序的字符串最好是不要有空格，如果有空格，空格会被排在字符串的开头
 **/
+ (NSString *)TKStringSortChatWithStr:(NSString *)str;


/**
 阿拉伯数字转中文数字
 **/
+(NSString *)TKTranslation:(NSInteger)albNum;

/**
 中文数字转阿拉伯数字
 **/
+(NSString *)TKTranslatNum:(NSString *)zhNumStr;

/**
 123转ABC
 **/
+ (NSString *)TKCharacterWithIndex:(NSInteger)index;


/**
 富文本HTML中的图片高宽自适应
 即是在html中插入一段H5样式，来解决图片自适应的问题
 str:含图片的h5(也可是普通的文字，只是没有效果而已)
 width:用于固定图片的宽度
 PS:html中所有的图片的宽度都被固定了
 **/
+ (NSString *)TKHtmlImgAutoWithStr:(NSString *)str width:(CGFloat)width;

/**
 处理html中图片宽高自适应问题
 str：
 maxWidth：图片的最大宽度
 PS:html中的图片，只有宽度超过maxWidth才会进行自适应
 https://www.cnblogs.com/someonelikeyou/p/3598655.html
 **/
+ (NSString *)TKHtmlImgAutoWithStr:(NSString *)str maxWidth:(CGFloat)maxWidth;



/**
 处理html富文本，修改字体样式
 将字符串放在font标签中并返回，可设置fontSzie,fontColor
 fontSize：字体大小：如果<=0，就不设置字体大小
 fontColor：字体颜色，如果为空则不设置颜色
 PS:有问题不要使用，可以改用 < span>标签
 **/
+ (NSString *)TKHtmlSpanWithStr:(NSString *)str fontSize:(CGFloat)fontSize fontColor:(NSString *)fontColor;

/**
 通过添加body标签设置字体颜色，大小,行间距默认为20px
 fontSize:字体大小
 fontColor：字体颜色，如#6FAC35
 **/
+ (NSString *)TKHtmlFontWithStr:(NSString *)str fontSize:(CGFloat)fontSize fontColor:(NSString *)fontColor;

/**
 通过添加body标签设置字体颜色，大小，行间距
 fontSize:字体大小
 fontColor：字体颜色，如#6FAC35
 lineHeight：行间距
 **/
+ (NSString *)TKHtmlFontWithStr:(NSString *)str fontSize:(CGFloat)fontSize fontColor:(NSString *)fontColor lineHeight:(CGFloat)lineHeight;

/**
 创建默认的 < span>标签对，适用于本项目，如果需要修改其它的样式
 直接修改style即可,
 PS:这是一个例子，具体需求，具体修改
 **/
+ (NSString *)TKHtmlSpanNodeDefaultStr:(NSString *)str;




@end

NS_ASSUME_NONNULL_END
