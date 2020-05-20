//
//  NSString+TK.m
//  AdultLP
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NSString+TK.h"

@implementation NSString (TK)

///** 解析html中的图片地址 **/
//+ (NSArray *)TKHtmlFilterImagesWithStr:(NSString *)htmlStr
//{
//    NSMutableArray *resultArray = [NSMutableArray array];
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
//    NSArray *result = [regex matchesInString:htmlStr options:NSMatchingReportCompletion range:NSMakeRange(0, htmlStr.length)];
//    for (NSTextCheckingResult *item in result) {
//        NSString *imgHtml = [htmlStr substringWithRange:[item rangeAtIndex:0]];
//        NSArray *tmpArray = nil;
//        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
//            tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
//        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
//            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
//        }
//        if (tmpArray.count >= 2) {
//            NSString *src = tmpArray[1];
//            NSUInteger loc = [src rangeOfString:@"\""].location;
//            if (loc != NSNotFound) {
//                src = [src substringToIndex:loc];
//                [resultArray addObject:src];
//            }
//        }
//    }
//    return resultArray;
//}

+ (NSDateFormatter *)dataFormatterStyle
{
    static NSDateFormatter * formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    });
    return formatter;
}

/**
 时间戳转换成时间字符串
 格式：2019/07/09 10:27:55
 **/
+ (NSString *)TKTimeConvertStrWithTimeStamp:(NSInteger )timesTamp
{
    //设置时间格式
    NSDateFormatter * formatter= [self dataFormatterStyle];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:timesTamp];
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}

/**
 时间戳转换成时间字符串
 格式：2019-07-09 10:27:55
 **/
+ (NSString *)TKTimeConvertStrWithStyle:(NSInteger)timesTamp
{
    //设置时间格式
    NSDateFormatter * formatter= [self dataFormatterStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:timesTamp];
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}

/**
 时间戳转换成时间字符串
 格式：2019-07-09
 **/
+ (NSString *)TKTimeConvertStrWithStyleDate:(NSInteger)timesTamp
{
    //设置时间格式
    NSDateFormatter * formatter= [self dataFormatterStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:timesTamp];
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}

/**
 将秒数转化成时间字符串
 格式：120:23(120分钟23秒), 00:01
 */
+ (NSString *)TKTimeConvertStrWithStyleSecond:(NSInteger)second
{
    NSMutableString *str = [[NSMutableString alloc] init];
    NSInteger m = second/60;
    if (m>0) {
        [str appendFormat:@"%02ld:",m];
    }else{
        [str appendString:@"00"];
    }
    NSInteger s = second - m*60;
    [str appendFormat:@"%02ld",s];
    return str;
}


/**
 将秒数转化成时间字符串
 格式：3小时5分45秒
 */
+ (NSString *)TKTimeConvertStrWithSecond:(NSInteger)second
{
    NSString *str = @"";
    NSInteger hour = second/3600;
    if (hour>0) {
        str = [NSString stringWithFormat:@"%lu时",hour];
    }
    second -= hour*3600;
    NSInteger m = second/60;
    if (m>0) {
        str = [NSString stringWithFormat:@"%@%lu分",str,m];
    }
    second -= m*60;
    if (second>0) {
        str = [NSString stringWithFormat:@"%@%lu秒",str,second];
    }
    if (str.length<1) {
        str = @"0秒";
    }
    return str;
}


/**
 去除字符串开头和结尾的空格,和\t
 **/
+ (NSString *)TKStringRemoveBeginAndEnd:(NSString *)str
{
    if (str) {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        str = [str stringByReplacingOccurrencesOfString:@"\t    " withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\t   " withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\t  " withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\t " withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    }
    return str;
}


/**
 将float转成字符串，如果末尾小数为0
 则将小数尾数向前移动一位
 PS:即为去除小数点后面的0
 **/
+ (NSString *)TKStringRemoveZeroWithFloat:(CGFloat)Float
{
    NSString *numStr = [NSString stringWithFormat:@"%.7f",Float];
    NSInteger lastIndex = numStr.length;
    NSString *lastStr   = [numStr substringFromIndex:lastIndex-1];
    while (([numStr containsString:@"."] && [lastStr isEqualToString:@"0"]) || [lastStr isEqualToString:@"."] ) {
        numStr = [numStr substringWithRange:NSMakeRange(0, lastIndex-1)];
        lastIndex = numStr.length;
        lastStr   = [numStr substringFromIndex:lastIndex -1];
    }
    return numStr;
}

/**
 获取字符串中所有子字符串重复出现的位置NSRange Array
 备注：得到返回的数组后，取出来的元素是NSValue，需要转换成NSRange使用
 NSRange range = [value rangeValue];
 **/
+ (NSArray *)TKStringRangeInStr:(NSString *)inStr subStr:(NSString *)subStr
{
    NSMutableArray *rangeArray = [NSMutableArray array];
    if (inStr.length>subStr.length) {
        NSRange targetRange = NSMakeRange(0, inStr.length);
        NSRange range = targetRange;
        while (true) {
            range = [inStr rangeOfString:subStr options:NSLiteralSearch range:targetRange];
            if (range.location != NSNotFound) {
                [rangeArray addObject:[NSValue valueWithRange:range]];
                targetRange = NSMakeRange(NSMaxRange(range), inStr.length-NSMaxRange(range));
            } else {
                break;
            }
        }
    }
    return rangeArray;
}

/**
 获取字符串中，子字符串重复出现的次数
 **/
+ (NSInteger)TKStringNumberInStr:(NSString *)inStr subStr:(NSString *)subStr
{
    NSArray *ary = [self TKStringRangeInStr:inStr subStr:subStr];
    return ary.count;
}

/**
 将字符串中的每个字符排序
 主要用来排@"ACB"-->@"ABC"
 PS:排序的字符串最好是不要有空格，如果有空格，空格会被排在字符串的开头
 **/
+ (NSString *)TKStringSortChatWithStr:(NSString *)str
{
    if (str.length>1) {
        NSMutableArray *ary = @[].mutableCopy;
        for (NSInteger i=0; i<str.length; i++) {
            NSString *tmp = [str substringWithRange:NSMakeRange(i, 1)];
            [ary addObject:tmp];
        }
        NSArray *tmpAry = [ary sortedArrayUsingSelector:@selector(compare:)];
        NSMutableString *tmpStr =  [[NSMutableString alloc] init];
        for (NSString *nodeStr in tmpAry) {
            [tmpStr appendString:nodeStr];
        }
        return tmpStr;
    }else {
        return str;
    }
}



/**
 阿拉伯数字转中文数字
 **/
+(NSString *)TKTranslation:(NSInteger)albNum
{
    NSString *str = [NSString stringWithFormat:@"%ld",albNum];
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        [sums addObject:sum];
    }
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    return chinese;
}

/**
 中文数字转阿拉伯数字
 **/
+(NSString *)TKTranslatNum:(NSString *)zhNumStr

{
    NSString *str = zhNumStr;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零", @"十"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:arabic_numerals forKeys:chinese_numerals];
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *sum = substr;
        if([chinese_numerals containsObject:substr]){
            if([substr isEqualToString:@"十"] && i < str.length){
                NSString *nextStr = [str substringWithRange:NSMakeRange(i+1, 1)];
                if([chinese_numerals containsObject:nextStr]){
                    continue;
                }
            }
            sum = [dictionary objectForKey:substr];
        }
        [sums addObject:sum];
    }
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    return sumStr;
}

/**
 123转ABC
 **/
+ (NSString *)TKCharacterWithIndex:(NSInteger)index
{
    NSString *cString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    if (index<0 && index>= cString.length) {
        return @"";
    }else{
        return [cString substringWithRange:NSMakeRange(index, 1)];
    }
}


/**
 富文本HTML中的图片高宽自适应
 即是在html中插入一段H5样式，来解决图片自适应的问题
 str:含图片的h5(也可是普通的文字，只是没有效果而已)
 width:用于固定图片的宽度
 PS:html中所有的图片的宽度都被固定了
 **/
+ (NSString *)TKHtmlImgAutoWithStr:(NSString *)str width:(CGFloat)width
{
    if (str) {
        str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",width,str];
        return str;
    }else{
        return @"";
    }
}

/**
 处理html中图片宽高自适应问题
 str：
 maxWidth：图片的最大宽度
 PS:html中的图片，只有宽度超过maxWidth才会进行自适应
 https://www.cnblogs.com/someonelikeyou/p/3598655.html
 **/
+ (NSString *)TKHtmlImgAutoWithStr:(NSString *)str maxWidth:(CGFloat)maxWidth
{
    if (str) {
//        str = [NSString stringWithFormat:@"<html><head><style>img{max-width:%.2f;height:auto !important;width:auto !important;};</style></head><body style='margin:0; padding:0;'>%@</body></html>",maxWidth ,str];
        str = [NSString stringWithFormat:@"<head><style>img{max-width:%.2f;height:auto !important;width:auto !important};</style></head>%@",maxWidth ,str];
        return str;
    }else{
        return @"";
    }
}




/**
 处理html富文本，修改字体样式
 将字符串放在font标签中并返回，可设置fontSzie,fontColor
 fontSize：字体大小：如果<=0，就不设置字体大小
 fontColor：字体颜色，如果为空则不设置颜色
 PS:有问题不要使用，可以改用<span>标签
 **/
+ (NSString *)TKHtmlSpanWithStr:(NSString *)str fontSize:(CGFloat)fontSize fontColor:(NSString *)fontColor
{
    if (str) {
        if (fontSize>0 && fontColor) {
            str = [NSString stringWithFormat:@"<font size=\"%.f\" color=\"%@\">%@</font>",fontSize,fontColor,str];
            str = [NSString stringWithFormat:@"<spse size=\"%.f\" color=\"%@\">%@</p>",fontSize,fontColor,str];
        }else if (!fontColor){
            str = [NSString stringWithFormat:@"<font size=\"%.f\" >%@</font>",fontSize,str];
        }else if (fontSize <= 0){
            str = [NSString stringWithFormat:@"<font color=\"%@\">%@</font>",fontColor,str];
        }else{
            str = [NSString stringWithFormat:@"<font>%@</font>",str];
        }
        return str;
    }else{
        return @"";
    }
}


/**
 通过添加body标签设置字体颜色，大小,行间距默认为20px
 fontSize:字体大小
 fontColor：字体颜色，如#6FAC35
 **/
+ (NSString *)TKHtmlFontWithStr:(NSString *)str fontSize:(CGFloat)fontSize fontColor:(NSString *)fontColor
{
    return [self TKHtmlFontWithStr:str fontSize:fontSize fontColor:fontColor lineHeight:20.0];
}

/**
 通过添加body标签设置字体颜色，大小，行间距
 fontSize:字体大小
 fontColor：字体颜色，如#6FAC35
 lineHeight：行间距
 **/
+ (NSString *)TKHtmlFontWithStr:(NSString *)str fontSize:(CGFloat)fontSize fontColor:(NSString *)fontColor lineHeight:(CGFloat)lineHeight
{
    if (str) {
        //该方式直接添加font标签，并设置样式
        //str = [NSString stringWithFormat:@"<font size=\"%.f\" color=\"%@\">%@</font>",size,color,str];
        
        //该方法通过添加body标签，设置样式字体样式
//        NSString *style = [NSString stringWithFormat:@"\"font-size:%.fpx;color:%@;line-height:%fpx;text-align:left\"",fontSize,fontColor,lineHeight];
//        str = [NSString stringWithFormat:@"<body style=%@>%@</body>",style,str];
        
        //修改为span标签（）
        NSString *style = [NSString stringWithFormat:@"\"font-size:%.1fpx;color:%@;line-height:%.1fpx;text-align:left\"",fontSize,fontColor,lineHeight];
        str = [NSString stringWithFormat:@"<span style=%@>%@</span>",style,str];
        return str;
    }else{
        return @"";
    }
}

/**
 创建默认的<span>标签对，适用于本项目，如果需要修改其它的样式
 直接修改style即可,
 PS:这是一个例子，具体需求，具体修改
 **/
+ (NSString *)TKHtmlSpanNodeDefaultStr:(NSString *)str
{
    if (str) {
        str = [NSString stringWithFormat:@"<span style=\"font-size:14;color:#ff0000;background-color:#998877;text-align:left;padding-left:6;padding-right:6\"></span>"];
        return str;
    }else{
        return @"";
    }
}


@end
