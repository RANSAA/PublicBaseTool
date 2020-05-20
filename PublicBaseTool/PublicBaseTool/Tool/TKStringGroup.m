//
//  TKStringGroup.m
//  AdultLP
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKStringGroup.h"

@implementation TKStringGroup

#pragma mark ---排序效率低，单不需要处理多音字----
/**
 对数据模型数组进行排序--直排-效率低
 modelAry：对应的数据模型数组
 sortkey: 模型中要排序的属性名称
 返回数据 key-对应字符串首字母 value-同字母的model数组
 PS:多音字无法排序
 **/
+ (NSDictionary *)TKShortReGroupWith:(NSArray *)modelAry sortKey:(NSString *)sortkey
{
    // 初始化UILocalizedIndexedCollation
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSArray *titlesAry = collation.sectionTitles;//A-Z,#
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    for (id model in modelAry) {
        NSString *str = [model valueForKey:sortkey];//获取指定字符串
        NSString *key = [NSString TKFirstCharactorWithString:str];//首字母
        key = [self TKCharactersWithKey:key compare:str];//处理多音字
        if (![titlesAry containsObject:key]) {
            key = @"#";
        }
        NSMutableArray *node = [dataDic objectForKey:key];
        if (!node) {
            node = [[NSMutableArray alloc] initWithCapacity:0];
            [dataDic setObject:node forKey:key];
        }
        [node addObject:model];
    }
    
    //数组模型排序-默认排序
    for (NSString *key in dataDic.allKeys) {
        NSMutableArray *ary = [dataDic objectForKey:key];
        [self valueCompareWith:ary sortKey:sortkey];
    }
    return [dataDic copy];
}

#pragma mark ----排序效率高，但是要处理多音字-----
/**
 对数据模型数组进行排序
 modelAry：对应的数据模型数组
 sortkey: 模型中要排序的属性名称
 返回数据 key-对应字符串首字母 value-同字母的model数组
 PS:多音字无法排序
 **/
+ (NSDictionary *)TKShortGroupWith:(NSArray *)modelAry sortKey:(NSString *)sortkey
{
    // 初始化UILocalizedIndexedCollation
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    //将每个名字分到某个section下
    for (id model in modelAry) {
        //获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
        NSInteger sectionNumber = [collation sectionForObject:model collationStringSelector:NSSelectorFromString(sortkey)];
        //key--对应的首字母
        NSString *key = collation.sectionTitles[sectionNumber];
        NSString *str = [model valueForKey:sortkey];//要获取首字母的字符串
        key = [self TKCharactersWithKey:key compare:str];//处理多音字
        NSMutableArray *node = [dataDic objectForKey:key];
        if (!node) {
            node = [[NSMutableArray alloc] initWithCapacity:0];
            [dataDic setObject:node forKey:key];
        }
        [node addObject:model];
    }
    
    //数组模型排序-默认排序
    for (NSString *key in dataDic.allKeys) {
        NSMutableArray *ary = [dataDic objectForKey:key];
        [self valueCompareWith:ary sortKey:sortkey];
    }
    return [dataDic copy];
}

#pragma mark ----排序效率高，但是要处理多音字-----

/**
 对分好组的model数组 value-ary-model 排序
 **/
+ (void)valueCompareWith:(NSMutableArray *)ary sortKey:(NSString *)sortkey
{
    [ary sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *name1 = [obj1 valueForKey:sortkey];
        NSString *name2 = [obj2 valueForKey:sortkey];
        return [name1 compare:name2 options:NSNumericSearch];
    }];
}

/** 筛选处理多音字 **/
+(NSString *)TKCharactersWithKey:(NSString *)key compare:(NSString *)str
{
//    if ([str hasPrefix:@"长安"]) {
//        key = @"C";
//    }
    return key;
}


@end
