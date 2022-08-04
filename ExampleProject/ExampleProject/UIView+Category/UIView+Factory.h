//
//  UIView+Factory.h
//  ExampleProject
//
//  Created by PC on 2022/7/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Factory)

/**
 获取类型为className或其子类的第一个子控件
 */
- (UIView *)subViewKindOfClassName:(NSString*)className;

/**
 获取类型为className的第一个子控件
 */
- (UIView*)subViewOfClassName:(NSString*)className;

/**
 获取类型为className的所有子控件
 */
- (NSArray*)subViewsOfClassName:(NSString*)className;

/**
 获取所有子控件类型，并分级排序。
 注意：最好延迟一下再使用本函数，因为有些子控件是懒加载的。
 */
- (NSArray *)subViewsMark;

@end

NS_ASSUME_NONNULL_END
