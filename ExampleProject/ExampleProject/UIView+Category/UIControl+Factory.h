//
//  UIControl+Factory.h
//  ExampleProject
//
//  Created by PC on 2022/7/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (Factory)
/**
 接收Event事件时间间隔，default 0。
 使用场景: 防止控件连续点击
 */
@property(nonatomic, assign) NSTimeInterval acceptEventInterval;
@property(nonatomic, assign) BOOL ignoreEvent;

@end

NS_ASSUME_NONNULL_END
