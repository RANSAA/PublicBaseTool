//
//  UIDevice+Orientation.h
//  TKSDKXibView
//
//  Created by kimi on 2023/8/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice ()
/** 设置屏幕方向，小于iOS16 */
- (void)setOrientation:(UIInterfaceOrientation)orientation API_DEPRECATED("iOS16+使用setOrientationIOS16:", ios(2.0, 16.0));
@end

@interface UIDevice (Orientation)
/** 设置屏幕方向，iOS16+ */
- (void)setOrientationIOS16:(UIInterfaceOrientationMask)orientation API_AVAILABLE(ios(16.0));
- (void)setOrientationIOS16:(UIInterfaceOrientationMask)orientation errorHandler:(nullable void (^)(NSError *error))errorHandler API_AVAILABLE(ios(16.0));
@end

NS_ASSUME_NONNULL_END
