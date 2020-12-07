//
//  AA.h
//  Review
//
//  Created by PC on 2020/9/1.
//  Copyright © 2020 PC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AA : NSObject
+ (BOOL)isPureNumber:(NSString *)string;
/** 判断字符串是否是数字,整数或者小数 */
+ (BOOL)TKIsNumberWithString:(NSString *)strValue;

+ (BOOL)isPureNumandCharacters:(NSString *)text;

+ (BOOL) deptNumInputShouldNumber:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
