//
//  UIView+TKSDK.h
//  TKSDKUniversal
//
//  Created by Mac on 2019/3/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSValue+TKSDK.h"


NS_ASSUME_NONNULL_BEGIN
@interface UIView (TKSDK)
#pragma mark frame相关设置
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;


#pragma mark 防止重复点击
/**
 设置防重复点击的延迟时间，默认0.3s
 */
- (void)setUserInteractionEnabledDelayTime:(CGFloat)delayTime;
/**
 设置开启防止重复点击操作，默认0.3秒后恢复;
 即:userInteractionEnabled=NO
 */
- (void)setAfterUserInteractionEnabled;


#pragma mark Layer: CAShapeLayer绘制任意圆角
//推荐使用：TKSDKCornerShadowView或者按照它的思想重新设置扩展
//后面有时间重新设计
/**
 使用CAShapeLayer绘制任意圆角，边框线的注意事项：
 1.setShapeLayerCornerRadiusWith与setShapeLayerBorderColor一般配合使用，不要与系统相关设置圆角,边框线的方法混用 不与系统的layer相关方法混用。
 2.使用setShapeLayerCornerRadiusWith绘制任意角后，如果还需要设置阴影时(设置阴影效果时可能需要设置背景颜色)，则必须实现以下操作：
   指定控件需要『扩展』或者『继承』来实现下列代码：

 + (Class)layerClass {
     return [CAShapeLayer class];
 }

 - (void)setBackgroundColor:(UIColor *)backgroundColor {
     self.layer.backgroundColor = backgroundColor.CGColor;
     ((CAShapeLayer *)self.layer).fillColor = backgroundColor.CGColor;
 }

 - (UIColor *)backgroundColor
 {
     CGColorRef colorRef = ((CAShapeLayer *)self.layer).fillColor;
     if (colorRef == NULL) {
         colorRef = self.layer.backgroundColor;
     }
     UIColor *bgColor = nil;
     if (colorRef) {
         bgColor = [UIColor colorWithCGColor:colorRef];
     }
     return bgColor;
 }
 */

//使用CAShapeLayer绘制任意圆角，corner表示4个顶点的圆角半径。frame变化时需要使用needsUpdateDisplayShapeLayer手动更新
- (void)setShapeLayerCornerRadiusWith:(UIEdgeCorners)corner;

//使用CAShapeLayer绘制绘制边框。frame变化时需要使用needsUpdateDisplayShapeLayer手动更新
-(void)setShapeLayerBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

// 更新ShapeLayer绘制的圆弧以及边框线
- (void)needsUpdateDisplayShapeLayer;




#pragma mark Controller: 获取当前View所在控制器

/**
功能：获取当前view所在的Controller控制器。
如果是childViewController的view，并且将view作为subView添加到ViewControler.view中,那么获取到的控制器依然是"作为主控制器的ViewControler"
PS:注意与controllerFromChildController的区别
 */
- (nullable UIViewController *)controllerFromController;

/**
功能：获取当前view所在的Controller控制器。
如果是childViewController的view，并且将view作为subView添加到ViewControler.view中,那么获取到的控制器将会是"作为子控制器的childViewController"。
PS:注意与controllerFromController的区别
*/
- (nullable UIViewController *)controllerFromChildController;

#pragma mark Constraints: 约束添加
/**
向view添加相对于toView的四边都对齐的约束，并返回。
return:返回四边的约束NSLayoutConstraint，顺序为top,left,Bottom,right
*/
- (NSArray<NSLayoutConstraint *>*)addEdgeConstraintsToView:(UIView *)toView API_AVAILABLE(ios(9.0));





@end

NS_ASSUME_NONNULL_END
