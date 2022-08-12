//
//  TKMBProgressHUD.h
//  NovalSetApp
//
//  Created by Apple on 2018/3/21.
//  Copyright © 2018年 sayaDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKUIImportSDK.h"


/**
 * MBProgressHUD:二次封装
 **/

@interface TKMBProgressHUD : NSObject
    
@property(strong, nonatomic)MBProgressHUD *HUD;
    
/** 显示提示文字 */
+ (void)showText:(NSString *)text inView:(UIView *)view after:(CGFloat)after;
/** 显示提示文字 */
+ (void)showText:(NSString *)text inView:(UIView *)view ;
/** 显示提示文字在KeyWindow上 */
+ (void)showText:(NSString *)text;
    
    
/** 在keyWindows上显示loaing不消除 */
+ (TKMBProgressHUD *)showLoadding;
/** 显示loaing不消除 */
+ (TKMBProgressHUD *)showLoaddingInView:(UIView *)view;
/**显示loaing, 在after秒之后消除*/
+ (TKMBProgressHUD *)showLoaddingInView:(UIView *)view after:(CGFloat)after;

/** 隐藏showLoading */
+ (void)hideLoading;
/** 隐藏showLoading */
+ (void)hideLoadingAfter:(CGFloat)after;


@end
