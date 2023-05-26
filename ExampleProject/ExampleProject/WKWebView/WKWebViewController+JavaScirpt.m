//
//  WKWebViewController+JavaScirpt.m
//  ExampleProject
//
//  Created by kimi on 2023/5/11.
//

#import "WKWebViewController+JavaScirpt.h"


@implementation WKWebViewController (JavaScirpt)


/**
 校验该URL是否是一个正确的URL
 */
+ (BOOL)jsIsMatchWithUrl:(NSString *)url
{
    NSString *pattern = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *regexArray = [regex matchesInString:url options:0 range:NSMakeRange(0, url.length)];
    return regexArray.count>0?YES:NO;
}


/**
 修改web的背景颜色
 web:WKWebView
 color:颜色字符串，格式:#FFFFFF
 **/
+ (void)jsSetBackgroundColor:(nullable NSString *)color with:(WKWebView*)webView
{
    if(color){
        NSString *js = [NSString stringWithFormat:@"document.body.style.backgroundColor=\"%@\"",color];
        [webView evaluateJavaScript:js completionHandler:nil];
    }
}


/**
 返回WKUserScript，用于设置禁止放大缩小(捏合手势)
 如果使用的是WKWebView，推荐使用该方式！
 **/
+ (WKUserScript *)jsProhibitZoomBackToUserScript
{
    NSString *js = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    return script;
}

/**
 返回WKUserScript，用于设置禁止长按出现菜单
 如果使用的是WKWebView，推荐使用该方式！
 **/
+ (WKUserScript *)jsProhibitLongPressBackToUserScript
{
    // 禁止选择CSS
    NSString *css = @"body{-webkit-user-select:none;-webkit-user-drag:none;-webkit-touch-callout:none;}";
    // CSS选中样式取消
    NSMutableString *js = [NSMutableString string];
    [js appendString:@"var style = document.createElement('style');"];
    [js appendString:@"style.type = 'text/css';"];
    [js appendFormat:@"var cssContent = document.createTextNode('%@');", css];
    [js appendString:@"style.appendChild(cssContent);"];
    [js appendString:@"document.body.appendChild(style);"];
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    return script;
    
//    //方法二：
//    [js appendString:@"document.documentElement.style.webkitUserSelect='none';"];//禁止选择
//    [js appendString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止长按
//    [webView evaluateJavaScript:js completionHandler:nil];
}

/**
 设置禁止点击
 **/
+ (void)jsProhibitClickLinkWith:(WKWebView *)webView
{
    NSMutableString *js = [NSMutableString string];
    [js appendString:@"document.documentElement.style.pointerEvents='none';"];//禁止点击超链接
    [webView evaluateJavaScript:js completionHandler:^(id _Nullable sapce, NSError * _Nullable error) {
    }];
}


/**
 自定义的UserAgent
 */
+ (NSString *)jsUserAgent
{
    return  @"Apple/WebKit";
}

@end
