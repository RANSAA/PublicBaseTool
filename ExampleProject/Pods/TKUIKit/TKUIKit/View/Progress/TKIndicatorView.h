//
//  TKIndicatorView.h
//  table
//
//  Created by PC on 2022/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, TKIndicatorViewStyle){
    TKIndicatorViewDefaultStyle = 1,
    TKIndicatorViewLinearStyle,
    TKIndicatorViewLinearSegmentStyle,
    TKIndicatorViewGradientStyle,
};

@interface TKIndicatorView : UIView
@property(nonatomic, assign) TKIndicatorViewStyle style;
@property(nonatomic, assign) CGFloat lineWidth;
@property(nonatomic, strong) UIColor *lineColor;
//TKIndicatorViewGradientStyle样式渐变色集合，count<2使用lineColor属性
@property(nonatomic, copy, nullable) NSArray<UIColor *> *patternColor;

- (instancetype)initWithFrame:(CGRect)frame style:(TKIndicatorViewStyle)style;

@end

NS_ASSUME_NONNULL_END
