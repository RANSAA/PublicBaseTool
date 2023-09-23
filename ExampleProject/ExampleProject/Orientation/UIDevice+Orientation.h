//
//  UIDevice+Orientation.h
//  TKSDKXibView
//
//  Created by kimi on 2023/8/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


//MARK: -- 区分版本写法
//@interface UIDevice ()
///** 设置屏幕方向，小于iOS16 */
//- (void)setOrientation:(UIInterfaceOrientation)orientation API_DEPRECATED("iOS16+使用setOrientationIOS16:", ios(2.0, 16.0));
//@end
//
//@interface UIDevice (Orientation)
///** 设置屏幕方向，iOS16+ */
//- (void)setOrientationIOS16:(UIInterfaceOrientationMask)orientation API_AVAILABLE(ios(16.0));
//- (void)setOrientationIOS16:(UIInterfaceOrientationMask)orientation errorHandler:(nullable void (^)(NSError *error))errorHandler API_AVAILABLE(ios(16.0));
//@end






//MARK: -- 优化版本：不区分版本写法

/**
 用于设置UI界面方向的自定义枚举值
 */
typedef NS_ENUM(NSInteger, TKInterfaceOrientation){
    TKInterfaceOrientationPortrait,
    TKInterfaceOrientationPortraitUpsideDown,
    TKInterfaceOrientationLandscapeLeft,
    TKInterfaceOrientationLandscapeRight
};


@interface UIDevice (Orientation)
/** 手动设置屏幕方向 */
- (void)setUIOrientation:(TKInterfaceOrientation)orientation;
/** 手动设置屏幕方向，新增错误操作回调 */
- (void)setUIOrientation:(TKInterfaceOrientation)orientation errorHandler:(nullable void (^)(NSError *error))errorHandler;
@end

NS_ASSUME_NONNULL_END
