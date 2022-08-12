//
//  TKSlider.h
//  TKUIKitDemo
//
//  Created by PC on 2020/12/31.
//  Copyright © 2020 芮淼一线. All rights reserved.
//

/**
 功能：
    1.解决使用thumbTintColor时靠边有间隙的问题
    2.设置thumb的图片为[UIImage new]可以达到隐藏thumb的效果
    3.通过新增bufferView以达到显示缓冲进度条
    4.通过代理实现点击与拖动回调同步功能
 
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TKSlider;
@protocol TKSilderDelegate <NSObject>
@optional
/** slider操作结束时回调 */
- (void)TKSlider:(TKSlider *)slider endValue:(CGFloat)value;
/** slider value发生变化时回调 */
- (void)TKSlider:(TKSlider *)slider changedValue:(CGFloat)value;

@end

@interface TKSlider : UISlider

/** 与thumbTintColor 互斥*/
@property (nonatomic, strong) UIImage *thumbImage;
/** thumb滑动到首尾时，thumb的中心是否与首尾边对齐 */
@property (nonatomic, assign) BOOL centerThumb;
/** 缓冲条,默认不显示 */
@property (nonatomic, strong) UIView *bufferView;
/** 缓冲条的值，范围:0 ~ 1.0 */
@property (nonatomic, assign) CGFloat bufferValue;
/** 是否允许点击 */
@property (nonatomic, assign) BOOL isClick;
@property (nonatomic, weak) id<TKSilderDelegate> delegate;


/** 创建带阴影的圆形/椭圆图片 */
+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
