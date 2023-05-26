//
//  WKWebViewController.h
//  ExampleProject
//
//  Created by kimi on 2023/5/11.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 WKWebView参考:
 https://developer.mozilla.org/en-US/docs/Web/CSS/WebKit_Extensions
 https://blog.csdn.net/chennai1101/article/details/122175965
 
 问题参考:
 1. 第一次加载缓慢:https://www.jianshu.com/p/b7666fc916a9
 2. 白屏(卡顿)-1:https://www.jianshu.com/p/b154a7b5bbd6/
 2. 白屏(卡顿)-2:https://cloud.tencent.com/developer/beta/article/1005691
 */


//MARK: - 参数提示：下面的所有参数都应该在viewDidLoad方法之前设置。
@interface WKWebViewController : BaseViewController
//MARK: - 导航
/** 是否使用自定义的导航条 */
@property(nonatomic, assign) BOOL customNavBar;
/**是否显示导航条上右边的按钮, 默认NO*/
@property(nonatomic, assign) BOOL showNavRightItem;
/**点击返回按钮时是否直接返回到上一级页面，YES:直接返回到上一级控制器，NO:WebView执行goBack方法,   默认: YES  */
@property(nonatomic, assign) BOOL isDirectBack;
/** 是否开启侧滑返回上一级控制器，默认YES */
@property(nonatomic, assign) BOOL isSideslipBack;
/** 允许webview支持侧滑返回，默认YES，注意：只有当isDirectBack=NO,isSideslipBack=YES时，将值设置为YES时才能生效 */
@property(nonatomic, assign) BOOL allowsBackForwardNavigationGestures;
/** 当前控制器允许支持的屏幕方向方向类型: 0:只支持竖屏，1:只支持横屏，2：横竖屏同时支持。 默认：0 */
@property(nonatomic, assign) NSInteger orientation;
/** 是否根据webview.title自动更新navBar.title, 默认YES：YES */
@property(nonatomic, assign) BOOL updateTitle;


//MARK: - 加载资源类型
/** 当前WebView加载资源的类型： 0:URL网页  1:HTML字符串  2:PDF文件， 默认: 0  */
@property(nonatomic, assign) NSInteger loadType;

//MARK: - 自定义请求
/** 是否使用自定义的方式进行请求数据。 默认NO*/
@property(nonatomic, assign) BOOL customRequest;
/** 自定义数据请求方式：POST, GET。 默认POST */
@property(nonatomic, copy) NSString *HTTPMethod;
/**  request header */
@property(nonatomic, copy) NSDictionary *header;
/**
 附加的请求参数，位于Body中,POST方式才追加。
 **/
@property(nonatomic, copy) NSDictionary *parameter;


//MARK: -  实例方法
/**
 实例方法-加载url
 @param title 标题
 @param urlString 请求url
 */
+ (instancetype)instanceWithTitle:(NSString *)title urlString:(NSString *)urlString;
/**
 实例方法-加载HTML标签字符串
 @param title 标题
 @param htmlString HTML字符串
 @param baseURL baseURL
 */
+ (instancetype)instanceWithTitle:(NSString *)title htmlString:(NSString *)htmlString baseURL:(nullable NSString *)baseURL;

/**
 实例方法-加载pdf,word文档等，支持本地与远程路径
 title:标题
 readerURL:文档路径url，注意加载本地文件应该使用(file:///)
 **/
+ (instancetype)instanceWithTitle:(NSString *)title readerURL:(NSString *)readerURL;

@end

NS_ASSUME_NONNULL_END
