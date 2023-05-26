//
//  WKWebViewController+JavaScirpt.h
//  ExampleProject
//
//  Created by kimi on 2023/5/11.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 针对WKWebView处理js的一些常用扩展
 */
@interface WKWebViewController (JavaScirpt)
/**
 校验该URL是否是一个正确的URL
 */
+ (BOOL)jsIsMatchWithUrl:(NSString *)url;

/**
 修改web的背景颜色
 web:WKWebView
 color:颜色字符串，#FFFFFF
 **/
+ (void)jsSetBackgroundColor:(nullable NSString *)color with:(WKWebView*)webView;


/**
 返回WKUserScript，用于设置禁止放大缩小(捏合手势)
 如果使用的是WKWebView，推荐使用该方式！
 **/
+ (WKUserScript *)jsProhibitZoomBackToUserScript;

/**
 返回WKUserScript，用于设置禁止长按出现菜单
 如果使用的是WKWebView，推荐使用该方式！
 **/
+ (WKUserScript *)jsProhibitLongPressBackToUserScript;

/**
 设置禁止点击
 **/
+ (void)jsProhibitClickLinkWith:(WKWebView *)webView;

/**
 自定义的UserAgent
 */
+ (NSString *)jsUserAgent;


@end

NS_ASSUME_NONNULL_END
