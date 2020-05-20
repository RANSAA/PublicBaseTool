//
//  HtmlViewController.m
//  CreaditCard
//
//  Created by Mac on 2018/1/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "HtmlViewController.h"
#import <WebKit/WebKit.h>


@interface HtmlViewController () <WKNavigationDelegate, WKUIDelegate>
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) WKWebViewConfiguration * config;
@property (copy  , nonatomic) NSString *navTitle;
@property (copy  , nonatomic) NSString *soureURL;//资源路径
@property (strong, nonatomic) NSURL *baseURL;
@property (assign, nonatomic) BOOL isHTMLLoad;//是否加载的HTML String
@end

@implementation HtmlViewController
/**
 实例方法-加载url
 @param title 标题
 @param urlString 请求url
 */
+ (instancetype)instanceWithTitle:(NSString *)title urlString:(NSString *)urlString {
    HtmlViewController *controller = [[HtmlViewController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.loadType = 0;
    controller.isHTMLLoad = NO;
    controller.isDirectBack = YES;
    controller.navTitle = title;
    controller.soureURL  = urlString;
    return controller;
}
/**
 实例方法-加载HTML标签字符串
 @param title 标题
 @param htmlString HTML字符串
 @param baseURL baseURL
 */
+ (instancetype)instanceWithTitle:(NSString *)title htmlString:(NSString *)htmlString baseURL:(NSString *)baseURL
{
    HtmlViewController *controller = [[HtmlViewController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.loadType = 0;
    controller.isHTMLLoad = YES;
    controller.isDirectBack = YES;
    controller.navTitle = title;
    controller.soureURL   = htmlString;
    controller.baseURL = [NSURL URLWithString:baseURL];
    return controller;
}


/**
 实例方法-加载pdf,word文档等，支持本地与远程路径
 title:标题
 readerURL:文档路径url，注意加载本地文件应该使用(file:///)前缀
 **/
+ (instancetype)instanceWithTitle:(NSString *)title readerURL:(NSString *)readerURL
{
    HtmlViewController *controller = [[HtmlViewController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.loadType = 1;
    controller.isDirectBack = YES;
    controller.navTitle = title;
    controller.soureURL  = readerURL;
    return controller;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setScreenDirection];

    [self setNavBarStyleBgWhite];
    [self instanceWKWebView];
    [self loadUrlAction];

}

#pragma mark 在导航条下面添加一条线
- (void)addLineWithNavBar
{
    UIView *line = [UIView new];
    line.backgroundColor = kColorViewBg;
    UIView *vi = self.TKNavigationBar;
    [vi addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(vi);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(vi).mas_offset(1);
    }];
}

#pragma mark 开启横屏模式
- (void)setScreenDirection
{
    if (self.loadType == 1) {
        [[TKRotateManager shared] saveLastOrientation];
        [TKRotateManager shared].dirMaskType = 2;
    }
}

- (void)backDidParentControllerAction
{
    if (self.loadType == 1) {
        [[TKRotateManager shared] recoveryLastOrientation];
    }
}


#pragma mark 初始化WKWebView
- (void)instanceWKWebView
{
    //设置title
    self.TKNavigationBar.labTitle.text = self.navTitle;
    [self addLineWithNavBar];

    //添加左右按钮
    if (self.isShowNavRightItem) {
        [self.TKNavigationBar.btnRight setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [self.TKNavigationBar.btnRight addTarget:self action:@selector(closeHtmlButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }

    UIView *navBar = self.TKNavigationBar;

    //进度条初始化
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1)];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //直接将进度条添加到导航条上
    [navBar addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1.5);
        make.left.equalTo(self.progressView.superview);
        make.right.equalTo(self.progressView.superview);
        make.bottom.equalTo(self.progressView.superview).mas_offset(1.5);
    }];

    _config = [[WKWebViewConfiguration alloc]init];
    _config.preferences.javaScriptEnabled = YES;
    _config.preferences.javaScriptCanOpenWindowsAutomatically = YES;

    //禁止长按
    WKUserContentController *userController = [[WKUserContentController alloc] init];
    [userController addUserScript:[NSString TKWebProhibitLongPressBack]];
    if (self.loadType != 1) {//非文档类型
        [userController addUserScript:[NSString TKWebProhibitZoomBack]];
    }
    _config.userContentController = userController;

    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:_config];
    [self.view insertSubview:_webView atIndex:0];
    _webView.allowsLinkPreview = NO;//取消重按链接预览功能
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(navBar.mas_bottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuideBottom);
    }];

    if (self.loadType == 0) {
        if (self.isDirectBack) {//WK直接返回，
            //WK本身是否支持侧滑
            _webView.allowsBackForwardNavigationGestures = NO;
        }else{
            _webView.allowsBackForwardNavigationGestures = YES;
        }
    }else{//加载文档
        _webView.allowsBackForwardNavigationGestures = NO;
    }

    //为进度条添加KVO监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark 加载HTML
- (void)loadUrlAction
{
    NSLog(@"soureWeb:%@",self.soureURL);
    if (self.loadType == 1) {//文档
        NSURL *url = [NSURL URLWithString:self.soureURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }else{
        if (self.isHTMLLoad) {
            [_webView loadHTMLString:self.soureURL baseURL:self.baseURL];
        }else{
            if ([NSString TKWebIsMatchUrl:self.soureURL]) {
                [self requestWKWebViewUrlAction];
            }else{
                NSLog(@"当前网址有误，加载失败!");
            }
        }
    }
}


/**
 WK自定义Request请求,并通过body传递数据
 **/
- (void)requestWKWebViewUrlAction
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:kURL(self.soureURL)];
    if (self.isCustomRequest) {//使用自定义方式请求URL
        NSString *method = self.HTTPMethod;
        if (method.length < 1) {
            method = @"POST";
        }
        request.HTTPMethod = method;
        for (NSString  *key in self.header.allKeys) {
            NSString *value = self.header[key];
            [request setValue:value forHTTPHeaderField:key];
        }
        if (self.par.allKeys.count > 0) {
            NSMutableString *str = [[NSMutableString alloc] init];
            NSInteger index = 0;
            for (NSString *key in self.par.allKeys) {
                NSString *value = self.par[key];
                if (index == 0) {
                    [str appendFormat:@"%@=%@",key,value];
                }else{
                    [str appendFormat:@"&%@=%@",key,value];
                }
                index++;
            }
            NSData *bodyData = [str dataUsingEncoding:NSUTF8StringEncoding];
            request.HTTPBody   = bodyData;
        }
    }
    [_webView loadRequest:request];
}



#pragma mark WKNavigationDelegate

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.2f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    if (self.loadType == 1) {//文档

    }else{//html
        [NSString TKWebBackgroundColorWith:webView color:nil];
    }

}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{

}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    TKLog(@"navigationAction:%@",navigationAction.request.URL);
    if (self.loadType == 1) {
        NSString *url = [NSString stringWithFormat:@"%@",navigationAction.request.URL];
        if ([url isEqualToString:self.soureURL]) {
            decisionHandler(WKNavigationActionPolicyAllow);
        }else{
            decisionHandler(WKNavigationActionPolicyCancel);
        }
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

/**
 解决about:blank无法跳转问题，方案1
 **/
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (self.loadType != 1) {
        if (!navigationAction.targetFrame.isMainFrame) {
            [webView loadRequest:navigationAction.request];
        }
    }
    return nil;
}

///**
// 解决about:blank无法跳转问题,方案2
// **/
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
//{
//    if (!navigationAction.targetFrame.isMainFrame) {
//        [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
//    }
//    decisionHandler(WKNavigationActionPolicyAllow);
//}





#pragma mark WKNavigationDelegate

- (void)backAction:(id)sender
{
    if(self.isDirectBack){
        [super backAction:@(1)];
    }else{
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        } else {
            [super backAction:@(1)];
        }
    }
}

- (void)closeHtmlButtonClick
{
    [super backAction:@(1)];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.2f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end



























