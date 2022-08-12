//
//  TKUIBaseXib.m
//  TKUIKitDemo
//
//  Created by PC on 2021/1/4.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import "TKUIBaseXib.h"

@implementation TKUIBaseXib

/**
 重写该方法，可从指定bundle中加载xib
 */
- (NSBundle *)returnBundle
{
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundle = [NSBundle bundleForClass:self.class];
        //判断xx.bundle是否存在（是否是pods导入）
        NSBundle *xibBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"TKUIKit" ofType:@"bundle"]];
        NSString *path = [xibBundle resourcePath];
        BOOL isDir = NO;
        BOOL isFile = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
        if (isFile || isDir) {
            bundle = xibBundle;
        }
    });
    return bundle;
}


@end
