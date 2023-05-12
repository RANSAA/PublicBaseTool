//
//  WKWebViewController.m
//  ExampleProject
//
//  Created by kimi on 2023/5/11.
//

#import "WKWebViewController.h"
#import "WKWebViewController+JavaScirpt.h"

@interface WKWebViewController ()<WKNavigationDelegate, WKUIDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) WKWebViewConfiguration * config;

@property (copy  , nonatomic) NSString *navTitle;

@property (copy  , nonatomic) NSString *soureURL;//资源路径
@property (copy  , nonatomic) NSURL *baseURL;

@property (nonatomic, assign) BOOL webViewLoadTitle;//是否已获取当前webView的title

@end

@implementation WKWebViewController

//MARK: -  实例方法
- (instancetype)init
{
    if(self = [super init]){
        self.customNavBar = NO;
        self.showNavRightItem = NO;
        
        self.isDirectBack = NO;
        self.isSideslipBack = YES;
        self.allowsBackForwardNavigationGestures = YES;
        
        self.updateTitle = YES;
        self.customRequest = NO;
        
        self.loadType = 0;
        self.orientation = 0;
    }
    return self;
}

/**
 实例方法-加载url
 @param title 标题
 @param urlString 请求url
 */
+ (instancetype)instanceWithTitle:(NSString *)title urlString:(NSString *)urlString
{
    WKWebViewController *controller = [[WKWebViewController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.loadType = 0;
    controller.navTitle = title;
    controller.soureURL = urlString;
    return controller;
}

/**
 实例方法-加载HTML标签字符串
 @param title 标题
 @param htmlString HTML字符串
 @param baseURL baseURL
 */
+ (instancetype)instanceWithTitle:(NSString *)title htmlString:(NSString *)htmlString baseURL:(nullable NSString *)baseURL
{
    WKWebViewController *controller = [[WKWebViewController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.loadType = 1;
    controller.navTitle = title;
    controller.soureURL = htmlString;
    controller.baseURL = [NSURL URLWithString:baseURL];
    return controller;
}

/**
 实例方法-加载pdf,word文档等，支持本地与远程路径
 title:标题
 readerURL:文档路径url，注意加载本地文件应该使用(file:///)
 **/
+ (instancetype)instanceWithTitle:(NSString *)title readerURL:(NSString *)readerURL
{
    WKWebViewController *controller = [[WKWebViewController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.loadType = 2;
    controller.navTitle = title;
    controller.soureURL = readerURL;
    return controller;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //注意：直接通过init方法创建的Controllers时，需要设置背景颜色，不然第一次进入时会卡顿。
    
    [self setNavBarStyle];
    [self setScreenDirection];
    
    [self instanceWKWebView];
    [self setupCustomView];
    
    [self addObserverForWebView];

    [self loadURLAction];

}


/**
 设置屏幕支持方向的处理，根据具体情况处理。
 */
- (void)setScreenDirection
{
    //设置控制横竖屏的处理，后面根据需求修改..
    NSLog(@"设置控制横竖屏的处理，后面根据需求修改..");
}

/**
 设置导航条样式
 */
- (void)setNavBarStyle
{
   //设置导航条相关样式，后面根据需求修改.....
    NSLog(@"设置导航条相关样式，后面根据需求修改.....");
    

    //下面是测试的两个关闭按钮，可根据实际情况修改
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    
}

- (void)backAction:(id)sender
{
    if(self.isDirectBack){
        //直接回到上一级
        //[super backAction:@(1)];
        [self backToPreviousWithAnimation:YES];
    }else{
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        } else {
            //直接回到上一级
            //[super backAction:@(1)];
            [self backToPreviousWithAnimation:YES];
        }
    }
}

- (void)closeAction
{
    //直接回到上一级
    //[super backAction:@(1)];
    [self backToPreviousWithAnimation:YES];
}

- (void)backToPreviousWithAnimation:(BOOL)ani
{
    if(self.navigationController.childViewControllers.count>1){
        [self.navigationController popViewControllerAnimated:ani];
    }else if (self.presentingViewController){
        [self dismissViewControllerAnimated:ani completion:nil];
    }
}

/**
 添加侧滑返回，使用系统自带效果
 */
- (void)sideslipBackGestureNavigationWithEnabled:(BOOL)isEnabled
{
    //使用系统默认的侧滑返回操作
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (isEnabled) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
            self.navigationController.interactivePopGestureRecognizer.enabled =  YES;
        }else{
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            self.navigationController.interactivePopGestureRecognizer.enabled =  NO;
        }
    }
}



/** 加载自定义的UI，如导航条下面的进度条 */
- (void)setupCustomView
{
    //进度条初始化
    CGFloat progressHeight = 2.0;
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, progressHeight)];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    _progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    _progressView.layer.zPosition = 1000;
    _progressView.hidden = YES;
    _progressView.translatesAutoresizingMaskIntoConstraints = NO;

    
    NSLayoutConstraint *lay0;
    NSLayoutConstraint *lay1;
    NSLayoutConstraint *lay2;
    NSLayoutConstraint *lay3;
    if(self.customNavBar){
        //自定义的导航条
        UIView *navBar = nil;
        [navBar addSubview:_progressView];
        lay0 = [_progressView.topAnchor constraintEqualToAnchor:navBar.bottomAnchor];
        lay1 = [_progressView.leadingAnchor constraintEqualToAnchor:navBar.leadingAnchor constant:0];
        lay2 = [_progressView.trailingAnchor constraintEqualToAnchor:navBar.trailingAnchor constant:0];
    }else{
        [self.view addSubview:_progressView];
        if (@available(iOS 11.0, *)) {
            lay0 = [_progressView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
        } else {
            lay0 = [_progressView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor];
        }
        lay1 = [_progressView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:-1];
        lay2 = [_progressView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:1];
    }
    lay3 = [_progressView.heightAnchor constraintEqualToConstant:progressHeight];
    [NSLayoutConstraint activateConstraints:@[lay0,lay1,lay2,lay3]];


    
}

/**
 KVO键值监听响应，更新对应UI,及其事件处理
 */
- (void)updateViewForObserverWithKeyPath:(NSString *)keyPath vaule:(nullable id)value
{
    NSLog(@"WKWebView KVO keypath:%@   value:%@",keyPath,value);
    if([keyPath isEqualToString:@"estimatedProgress"]){
        double estimatedProgress = [(NSNumber *)value doubleValue];
        self.progressView.progress = estimatedProgress;
        if(self.progressView.progress >= 1){
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                CGFloat hegith = weakSelf.progressView.frame.size.height;
                weakSelf.progressView.transform = CGAffineTransformMakeTranslation(0, -hegith);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                weakSelf.progressView.transform = CGAffineTransformIdentity;
            }];
        }else{
            self.progressView.hidden = NO;
        }
    }else if([keyPath isEqualToString:@"title"]){
        if(self.updateTitle){
            self.navigationItem.title = (NSString *)value;
        }
    }
}


//MARK: - add kvo
- (void)addObserverForWebView
{
    //添加监测网页加载进度的观察者
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    //添加监测网页标题title的观察者
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserverForWebView
{
    NSLog(@"移除WKWebView的KVO键值监听");
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)dealloc
{
    [self removeObserverForWebView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    if([keyPath isEqualToString:@"estimatedProgress"]){
        NSNumber *value = [NSNumber numberWithDouble:self.webView.estimatedProgress];
        [self updateViewForObserverWithKeyPath:@"estimatedProgress" vaule:value];
    }else if ([keyPath isEqualToString:@"title"]){
        NSString *title = self.webView.title;
        [self updateViewForObserverWithKeyPath:@"title" vaule:title];
    }else{
        [super observeValueForKeyPath: keyPath ofObject:object change:change context:context];
    }
}


//MARK: - INIT WKWebView
- (void)instanceWKWebView
{
    _config = [[WKWebViewConfiguration alloc]init];
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    _config.preferences.minimumFontSize = 0;
    //设置是否支持javaScript 默认是支持的
    _config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
    _config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
    _config.allowsInlineMediaPlayback = YES;
    //设置是否允许画中画技术 在特定设备上有效
    _config.allowsPictureInPictureMediaPlayback = YES;
    //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
    _config.mediaTypesRequiringUserActionForPlayback = YES;
    //设置支持AirPlay
    _config.allowsAirPlayForMediaPlayback = YES;
    
    
    //禁止长按
    WKUserContentController *userController = [[WKUserContentController alloc] init];
    [userController addUserScript:[self.class jsProhibitLongPressBackToUserScript]];
    if(_loadType != 2 ){//非文档类型(如非PDF)
        _config.userContentController = userController;
    }
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:_config];
    [self.view insertSubview:_webView atIndex:0];
    _webView.allowsLinkPreview = NO;//取消重按链接预览功能
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *lay0 = [_webView.topAnchor constraintEqualToAnchor:self.view.topAnchor];
    NSLayoutConstraint *lay1 = [_webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    NSLayoutConstraint *lay2 = [_webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    NSLayoutConstraint *lay3 = [_webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    [self.view addConstraints:@[lay0,lay1,lay2,lay3]];
    

    /**
     设置webview侧滑返回操作
     ：返回按钮直接返回上一级控制器时，禁用web的侧滑返回功能。
     */
    if(self.isDirectBack){
        _webView.allowsBackForwardNavigationGestures = NO;
    }else{
        if(self.isSideslipBack){
            _webView.allowsBackForwardNavigationGestures = _allowsBackForwardNavigationGestures;
        }else{
            _webView.allowsBackForwardNavigationGestures = NO;
        }
    }
    

}




/** 加载HTML */
- (void)loadURLAction
{
    if (self.loadType == 1) {//加载HTML String
        [self.webView loadHTMLString:self.soureURL baseURL:self.baseURL];
    }else{
        if([self.class jsIsMatchWithUrl:self.soureURL]){
            [self requestWebViewURLWithAction];
        }else{
            NSLog(@"当前网址有误，加载失败! soureURL:%@",self.soureURL);
        }
    }
}

/**
 请求URL，并之定义参数
 */
- (void)requestWebViewURLWithAction
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.soureURL]];
    if(self.customRequest){
        NSString *method = _HTTPMethod ? _HTTPMethod : @"POST";
        request.HTTPMethod = method;
        
        //header
        for (NSString *key in self.header) {
            NSString *value = self.header[key];
            [request setValue:value forHTTPHeaderField:key];
        }
        
        //parameter 这儿追加到body参数的格式可由具体项目修改
        if (self.parameter.allKeys.count > 0) {
            NSMutableString *str = [[NSMutableString alloc] init];
            NSInteger index = 0;
            for (NSString *key in self.parameter) {
                NSString *value = self.parameter[key];
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
    [self.webView loadRequest:request];
}







#pragma mark - WKNavigationDelegate
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {

    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    if(self.loadType != 2){//非文档类型，修改HTML背景颜色
        [self.class jsSetBackgroundColor:@"#FFFFFF" with:webView];
    }

}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{

}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"navigationAction:%@",navigationAction.request.URL);
    if (self.loadType == 2) {
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
    if (self.loadType != 2) {
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









//MARK: - 解决白屏，卡顿
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.webViewLoadTitle && self.webView.title == nil){
//        webView已获取title，但返回时无法获取title，可能是内存不足原因造成，此时需重新加载同时避免第一次进入时重新加载
        [self.webView reload];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(self.webView.title != nil){
        self.webViewLoadTitle = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //开启侧滑返回
    [self sideslipBackGestureNavigationWithEnabled:self.isSideslipBack];
}

//web内存过大，进程终止，重新加载webView
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
