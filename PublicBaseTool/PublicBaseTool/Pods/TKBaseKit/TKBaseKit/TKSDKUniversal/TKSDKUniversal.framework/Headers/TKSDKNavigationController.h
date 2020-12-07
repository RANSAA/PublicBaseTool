//
//  TKSDKNavigationController.h
//  AF
//
//  Created by Apple on 2018/3/2.
//  Copyright © 2018年 PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKSDKNavigationController : UINavigationController

/**
 设置状态栏文字样式
 0:默认黑色
 1:白色高亮
 2:自动
*/
- (void)setStatusBarStyleType:(NSNumber *)styleType;
/**设置状态栏隐藏-竖屏  */
- (void)setIsStatusBarStyleHidden:(NSNumber *)isHidden;
/**设置状态栏隐藏-横屏  */
- (void)setIsStatusBarLandscapeIsHidden:(NSNumber *)isHidden;

@end
