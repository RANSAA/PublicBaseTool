//
//  AppDelegate.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "AppDelegate.h"
#import <WebKit/WebKit.h>
#import "Touch3DManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"home:%@",NSHomeDirectory());

    NSLog(@"AppDelegate keyWin:%@",[UIApplication.sharedApplication getKeyWindow]);
    NSLog(@"first:%@",UIApplication.sharedApplication.windows.firstObject);


    NSString *language = [NSLocale preferredLanguages].firstObject;
    NSLog(@"NSLocale: %@",[NSLocale preferredLanguages]);

    //给字体设置增量
//    TKFontManager.shared.increaseSize = 60;
    
    

    [self registerFont];


    [self delayLoadView];
    
    [self init3DTouch];


    if (@available(iOS 13.0, *)) {
        NSLog(@"first 13.0+:%@",UIApplication.sharedApplication.connectedScenes.allObjects.firstObject);
    }else{
        [LaunchPageManager.shared userAgreementStatusDetectionCompletionHandler:^{
            TabBarViewController *tabVC = [[TabBarViewController alloc] init];
            self.window.rootViewController = tabVC;
            [self.window makeKeyAndVisible];
        }];
    }


    return YES;
}

- (void)registerFont
{
//    [TKFontManager.shared turnOnAutoRefreshFonts];
    NSString *path = [NSBundle.mainBundle pathForResource:@"dynamic-AaJianHaoTi" ofType:@"ttf"];
//    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    [TKFontManager.shared dynamicLoadFontPath:path checkFontName:@"AaJianHaoTi"];
    [TKFontManager.shared dynamicLoadFontPath:path checkFontName:@"AaJianHaoTi"];
    [TKFontManager.shared turnOnAutoRefreshFonts];
//    [TKFontManager.shared fontNames];
}

#pragma mark - 小于13.0的生命周期
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"appdelegate did enter background");
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.

    NSLog(@"launch 1....");
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    NSLog(@"lunch 2...");
}


//MARK: - 延迟加载一些第一次初始化比较耗时的UI
- (void)delayLoadView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        WKWebView *web = [[WKWebView alloc] init];
        [UIApplication.sharedApplication.windows.firstObject addSubview:web];
        [web removeFromSuperview];
    });
}


//MARK: - 3D Touch
- (void)init3DTouch
{
    [Touch3DManager.shared addShortItems];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    [Touch3DManager.shared performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
}

@end
