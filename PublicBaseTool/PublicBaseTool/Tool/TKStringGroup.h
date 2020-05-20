//
//  TKStringGroup.h
//  AdultLP
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

/**
 根据文字的首字母进行排序分组
 **/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKStringGroup : NSObject

/**
 对数据模型数组进行排序-利用UILocalizedIndexedCollation
 modelAry：对应的数据模型数组
 sortkey: 模型中要排序的属性名称
 返回数据 key-对应字符串首字母 value-同字母的model数组
 **/
+ (NSDictionary *)TKShortGroupWith:(NSArray *)modelAry sortKey:(NSString *)sortkey;

/**
 对数据模型数组进行排序--直排-直排-效率低
 modelAry：对应的数据模型数组
 sortkey: 模型中要排序的属性名称
 返回数据 key-对应字符串首字母 value-同字母的model数组
 PS:多音字无法排序
 **/
+ (NSDictionary *)TKShortReGroupWith:(NSArray *)modelAry sortKey:(NSString *)sortkey;


@end

NS_ASSUME_NONNULL_END
