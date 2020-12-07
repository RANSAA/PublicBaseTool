//
//  NSString+TKWeb.h
//  Evaluate
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 mac. All rights reserved.
//
/**
 扩展处理WKWebView
 网页视图控制器: https://developer.mozilla.org/en-US/docs/Web/CSS/WebKit_Extensions
 **/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TKWeb)

/** 校验是否为正常的URL  */
+ (BOOL)TKWebIsMatchUrl:(NSString *)url;
/** 修改web的背景颜色
 web:WKWebView
 color:颜色字符串，#FFFFFF
 **/
+ (void)TKWebBackgroundColorWith:(id)web color:(nullable NSString *)color;

/**
 返回WKUserScript，用于设置禁止放大缩小(捏合手势)
 如果使用的是WKWebView，推荐使用该方式！
 **/
+ (id)TKWebProhibitZoomBack;

/**
 返回WKUserScript，用于设置禁止长按出现菜单
 如果使用的是WKWebView，推荐使用该方式！
 **/
+ (id)TKWebProhibitLongPressBack;

/**
 设置禁止点击
 **/
+ (void)TKWebProhibitClickLink:(id)web;

@end

NS_ASSUME_NONNULL_END
