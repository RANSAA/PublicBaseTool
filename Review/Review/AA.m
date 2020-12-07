//
//  AA.m
//  Review
//
//  Created by PC on 2020/9/1.
//  Copyright © 2020 PC. All rights reserved.
//

#import "AA.h"

@interface AA ()
@property(nonatomic, copy) NSString *name;
@end

@implementation AA
-(void)setName:(NSString *)name{

    if (_name != name) {
//        [_name release];
        _name = [name copy];
    }
}
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/**

 */
+ (BOOL)isPureNumber:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float valFloat;
    int   valInt;
    return ([scan scanFloat:&valFloat] || [scan scanInt:&valInt]) && [scan isAtEnd];
}

/** 判断字符串是否是数字,整数或者小数 */
+ (BOOL)TKIsNumberWithString:(NSString *)strValue
{
    if (strValue) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
        NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (![strValue isEqualToString:filtered])
        {
            return NO;
        }
        return YES;
    }
    return NO;
}

+ (BOOL)isPureNumandCharacters:(NSString *)text
{
//    for(int i = 0; i < [text length]; ++i) {
//        int a = [text characterAtIndex:i];
//        if ([self isNum:a]){
//            continue;
//        } else {
//            return NO;
//        }
//    }
    return YES;
}

+ (BOOL) deptNumInputShouldNumber:(NSString *)str
{
   if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"^(\\-|\\+)?\\d+(\\.\\d+)?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}



@end
