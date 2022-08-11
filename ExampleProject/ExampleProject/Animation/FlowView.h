//
//  FlowView.h
//  ExampleProject
//
//  Created by PC on 2022/8/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FlowViewDirection){
    FlowViewDirectionVertical = 0,  //default
    FlowViewDirectionHorizontal
};

@interface FlowView : UIView
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, assign) CGFloat fixed;//固定要显示图片的高或者宽，如果未设置直接取值当前视图的高或者宽(PS:需要大于高/宽才有效)。
@property(nonatomic, assign) FlowViewDirection direction;//运行方向：水平 or 垂直
@property(nonatomic, assign) CGFloat distance;//步长， default 0.25, 负值表示反方向。
@end

NS_ASSUME_NONNULL_END
