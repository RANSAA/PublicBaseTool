//
//  NSObject+Person.m
//  Review
//
//  Created by PC on 2020/9/1.
//  Copyright © 2020 PC. All rights reserved.
//

#import "NSObject+Person.h"
#import <objc/runtime.h>

//static NSString *nameKey = @"nameKey"; //name对应的key


@implementation NSObject (Person)

//添加一个自定义方法，用于清除所有关联属性
- (void)clearAssociatedObjcet{
    objc_removeAssociatedObjects(self);
}


- (void)setUrlString:(NSString *)urlString {
    objc_setAssociatedObject(self, @selector(urlString), urlString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)urlString {
    return objc_getAssociatedObject(self, @selector(urlString));
}

//- (void)setUrlString:(NSString *)urlString {
//    objc_setAssociatedObject(self, &nameKey, urlString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//- (NSString *)urlString {
//    return objc_getAssociatedObject(self, &nameKey);
//}


@end
