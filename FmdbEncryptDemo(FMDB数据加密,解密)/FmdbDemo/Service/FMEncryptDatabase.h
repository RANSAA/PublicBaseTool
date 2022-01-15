//
//  FMEncryptDatabase.h
//  FmdbDemo
//
//  Created by ZhengXiankai on 15/7/31.
//  Copyright (c) 2015年 ZhengXiankai. All rights reserved.
//

#import "FMDatabase.h"


/**
 使用注意：需要修改fmdb源代码，将FMDatabase.m中的 _db 变量的声明修改放在FMDatabase.h中
 即：
 @interface FMDatabase : NSObject
 {
     void*               _db;
 }
 //xxx

 @end
 */


@interface FMEncryptDatabase : FMDatabase
/** 如果需要自定义encryptkey，可以调用这个方法修改（在使用之前）*/
+ (void)setEncryptKey:(NSString *)encryptKey;
@end
