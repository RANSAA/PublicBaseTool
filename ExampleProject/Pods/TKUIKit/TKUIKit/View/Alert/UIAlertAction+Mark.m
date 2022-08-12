//
//  UIAlertAction+Mark.m
//  TKUIKitDemo
//
//  Created by PC on 2021/1/4.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import "UIAlertAction+Mark.h"
#import <objc/runtime.h>

@implementation UIAlertAction (Mark)

- (void)dealloc
{
    objc_removeAssociatedObjects(self);
}

- (void)setTag:(NSInteger)tag
{
    objc_setAssociatedObject(self, @selector(tag), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)tag
{
    NSNumber *num = objc_getAssociatedObject(self, @selector(tag));
    return num.intValue;
}



@end
