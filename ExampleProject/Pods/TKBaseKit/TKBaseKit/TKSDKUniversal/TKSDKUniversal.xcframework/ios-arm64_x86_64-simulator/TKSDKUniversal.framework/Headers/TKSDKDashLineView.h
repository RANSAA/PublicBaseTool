//
//  TKSDKDashLineView.h
//  TKBaseKit
//
//  Created by PC on 2022/1/2.
//  Copyright © 2022 PC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 绘制虚线的View，UIBezierPath绘制
 */
NS_ASSUME_NONNULL_BEGIN

@interface TKSDKDashLineView : UIView
@property(nonatomic, assign) BOOL isVertical;//是否按照垂直方向绘制虚线， default NO
@property(nonatomic, strong) UIColor *lineColor;//虚线段颜色
@property(nonatomic, assign) CGFloat phase;//虚线开始处的偏移量，default 0
@property(nonatomic, copy, nullable) NSArray<NSNumber *> *lineWidthPattern;//虚线线段长度数组，默认长度为14
@property(nonatomic, copy, nullable) NSArray<NSNumber *> *lineSpacePattern;//虚线之间的间隔长度数组，默认间隔为8
@end

NS_ASSUME_NONNULL_END
