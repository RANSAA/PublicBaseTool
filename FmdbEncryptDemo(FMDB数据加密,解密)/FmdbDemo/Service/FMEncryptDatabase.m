//
//  FMEncryptDatabase.m
//  FmdbDemo
//
//  Created by ZhengXiankai on 15/7/31.
//  Copyright (c) 2015年 ZhengXiankai. All rights reserved.

#import "FMEncryptDatabase.h"

#if FMDB_SQLITE_STANDALONE
#import <sqlite3/sqlite3.h>
#else
#import <sqlite3.h>
#endif



@implementation FMEncryptDatabase

static NSString *encryptKey_;
+ (void)initialize
{
    [super initialize];
    //初始化数据库加密key，在使用之前可以通过 setEncryptKey 修改
    encryptKey_ = @"FDLSAFJEIOQJR34JRI4JIGR93209T489FR";
}

#pragma mark - 配置方法
+ (void)setEncryptKey:(NSString *)encryptKey
{
    encryptKey_ = encryptKey;
}

#pragma mark - 重载原来方法
- (BOOL)open {
    if (self.isOpen) {
        return YES;
    }

    // if we previously tried to open and it failed, make sure to close it before we try again
    if (_db) {
        [self close];
    }

    // now open database
    int err = sqlite3_open([self sqlitePath], (sqlite3**)&_db );
    if(err != SQLITE_OK) {
        NSLog(@"error opening!: %d", err);
        return NO;
    }else{
        //1. open sqlite
        //2. 为sqlite数据库设置密码
        [self setKey:encryptKey_];
    }


    if (self.maxBusyRetryTimeInterval > 0.0) {
        // set the handler
        [self setMaxBusyRetryTimeInterval:self.maxBusyRetryTimeInterval];
    }
    self.isOpen = YES;
    return YES;
}


- (BOOL)openWithFlags:(int)flags vfs:(NSString *)vfsName {
#if SQLITE_VERSION_NUMBER >= 3005000
    if (self.isOpen) {
        return YES;
    }

    // if we previously tried to open and it failed, make sure to close it before we try again

    if (_db) {
        [self close];
    }

    // now open database
    int err = sqlite3_open_v2([self sqlitePath], (sqlite3**)&_db, flags, [vfsName UTF8String]);
    if(err != SQLITE_OK) {
        NSLog(@"error opening!: %d", err);
        return NO;
    }else{
        //1. open sqlite
        //2. 为sqlite数据库设置密码
        [self setKey:encryptKey_];
    }

    if (self.maxBusyRetryTimeInterval > 0.0) {
        // set the handler
        [self setMaxBusyRetryTimeInterval:self.maxBusyRetryTimeInterval];
    }

    self.isOpen = YES;

    return YES;
#else
    NSLog(@"openWithFlags requires SQLite 3.5");
    return NO;
#endif
}


//或者直接将Super FMDatabase中的-(void)sqlitePath：方法暴露在.h文件中
- (const char*)sqlitePath {
    if (!self.databasePath) {
        return ":memory:";
    }

    if ([self.databasePath length] == 0) {
        return ""; // this creates a temporary database (it's an sqlite thing).
    }
    return [self.databasePath fileSystemRepresentation];
}


@end
