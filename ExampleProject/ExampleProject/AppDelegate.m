//
//  AppDelegate.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"home:%@",NSHomeDirectory());

    [self registerFont];



    if (@available(iOS 13.0, *)) {

    }else{
        TabBarViewController *tabVC = [[TabBarViewController alloc] init];
        self.window.rootViewController = tabVC;
        [self.window makeKeyAndVisible];
    }

    return YES;
}

- (void)registerFont
{
//    [TKFontManager.shared turnOnAutoRefreshFonts];
    NSString *path = [NSBundle.mainBundle pathForResource:@"dynamic-AaJianHaoTi" ofType:@"ttf"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    [TKFontManager.shared dynamicLoadFontPath:path checkFontName:@"AaJianHaoTi"];
    [TKFontManager.shared dynamicLoadFontPath:path checkFontName:@"AaJianHaoTi"];
    [TKFontManager.shared turnOnAutoRefreshFonts];
//    [TKFontManager.shared fontNames];
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
