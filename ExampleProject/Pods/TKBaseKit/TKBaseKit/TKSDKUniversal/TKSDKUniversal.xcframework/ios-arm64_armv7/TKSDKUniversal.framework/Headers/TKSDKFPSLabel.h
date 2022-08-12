//
//  TKSDKFPSLabel.h
//  TKSDKUniversal
//
//  Created by PC on 2021/6/4.
//  Copyright © 2021 PC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKSDKFPSLabel : UILabel
/**
 直接创建并显示在keyWindow上面。
 PS:也可以通过initWithXX方式创建，并添加到指定View上。
 */
+ (void)show;

/**
 手动销毁CADisplayLink
 最新：已经不需要执行手动销毁操作
 */
- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
