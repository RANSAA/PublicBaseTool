//
//  UIView+Factory.m
//  ExampleProject
//
//  Created by PC on 2022/7/31.
//

#import "UIView+Factory.h"
#import <objc/runtime.h>

@implementation UIView (Factory)

/**
 获取类型为className或其子类的第一个子控件
 */
- (nullable UIView *)subViewKindOfClassName:(NSString*)className
{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(className)]) {
            return subView;
        }
        UIView *resultFound = [subView subViewKindOfClassName:className];
        if (resultFound) {
            return  resultFound;
        }
    }
    return nil;
}

/**
 获取类型为className的第一个子控件
 */
- (nullable UIView*)subViewOfClassName:(NSString*)className
{
    for (UIView *subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        UIView *resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return  resultFound;
        }
    }
    return nil;
}

/**
 获取类型为className的所有子控件
 */
- (NSArray*)subViewsOfClassName:(NSString*)className
{
    NSMutableArray *ary = [[NSMutableArray alloc] init];
    for (UIView *subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            [ary addObject:subView];
        }else{
            [ary addObjectsFromArray:[subView subViewsOfClassName:className]];
        }
    }
    return ary;
}

/**
 获取所有子控件类型，并分级排序。
 注意：最好延迟一下再使用本函数，因为有些子控件是懒加载的。
 */
- (NSArray *)subViewsMark
{
    return [self subViewsMarkWithSuperName:nil];
}

- (NSArray *)subViewsMarkWithSuperName:(NSString *)superName
{
    NSMutableArray *ary = [[NSMutableArray alloc] init];
    NSString *className = superName?superName:NSStringFromClass(self.class);
    for (id subview in self.subviews) {
        NSString *subName = [NSString stringWithFormat:@"%@:%@",className,[subview class]];
        [ary addObject: subName];
        [ary addObjectsFromArray:[subview subViewsMarkWithSuperName:subName]];
    }
    return ary;
}


@end



