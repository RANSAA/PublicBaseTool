//
//  UIApplication+Window.m
//  ExampleProject
//
//  Created by PC on 2022/8/4.
//

#import "UIApplication+Window.h"

@implementation UIApplication (Window)



- (UIWindow *)getKeyWindow
{
    UIWindow *mainWindow = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *windowScene in UIApplication.sharedApplication.connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        return window;
                    }
                }
            }
        }
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        mainWindow = UIApplication.sharedApplication.keyWindow;
#pragma clang diagnostic pop
    }
    if (!mainWindow) {
        mainWindow = UIApplication.sharedApplication.windows.firstObject;
    }
    return mainWindow;
}


@end
