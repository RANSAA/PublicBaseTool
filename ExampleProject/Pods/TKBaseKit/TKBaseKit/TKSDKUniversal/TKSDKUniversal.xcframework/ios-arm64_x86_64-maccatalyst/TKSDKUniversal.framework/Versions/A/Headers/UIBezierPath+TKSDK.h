//
//  UIBezierPath+TKSDK.h
//  TKBaseKit
//
//  Created by PC on 2022/1/3.
//  Copyright © 2022 PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSValue+TKSDK.h"


NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (TKSDK)
/**
 创建任意圆角的UIBezierPath，cornerEdge表示4个顶点的圆角半径。
 与原生的几个创建圆角路径的区别是：可以自定义各个圆角的半径
 */
+ (UIBezierPath *)bezierPathWithRoundedRect:(CGRect)rect cornerEdge:(UIEdgeCorners)cornerEdge;

@end

NS_ASSUME_NONNULL_END
