//
//  UIButton+TKSDK.h
//  testFor
//
//  Created by Mac on 2019/6/15.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TKSDK)
/** ⚠️严重警告！请使用setTitleText方法代替*/
- (void)setTitle:(NSString *)title API_DEPRECATED_WITH_REPLACEMENT("setTitleText:", ios(2.0, 9.0));
/** 设置标题 */
- (void)setTitleText:(NSString *)title;
/** 设置字体颜色 */
- (void)setTitleColor:(UIColor *)color;
/** 设置image  */
- (void)setImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
