//
//  TKGrayWhiteFilterView.h
//  ExampleProject
//
//  Created by PC on 2022/12/9.
//

#import <UIKit/UIKit.h>

/**
 黑白滤镜，纪念主题。iOS13.0+
 参考:
 https://blog.csdn.net/IOSSHAN/article/details/123842441
 https://www.jianshu.com/p/f03faf64f63e
 */

NS_ASSUME_NONNULL_BEGIN

@interface TKGrayWhiteFilterView : UIView
/**
 设置是否启用黑白模式，并将状态存储在NSUserDefaults中。
 */
+ (void)setOpenWhiteBlackModel:(BOOL)isOpen;

/** 创建黑白滤镜，并添加到指定view。(可失败创建) */
+ (nullable instancetype)showGrayWhiteFilterWithSuperView:(UIView *)superView;
/**
 将黑白滤镜从指定view上移出
 */
+ (void)removeGrayWhiteFilterFrom:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
