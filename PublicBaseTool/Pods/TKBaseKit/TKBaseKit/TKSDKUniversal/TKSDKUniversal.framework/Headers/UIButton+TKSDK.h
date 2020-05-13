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
/** 设置标题 UIControlStateNormal   */
- (void)setTitle:(NSString *)title;
/** 设置image UIControlStateNormal  */
- (void)setImage:(UIImage *)image;
/** 设置字体颜色 UIControlStateNormal */
- (void)setTitleColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
