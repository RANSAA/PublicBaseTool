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
    if (@available(iOS 13.0, *))
    {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive)
            {
                for (UIWindow *window in windowScene.windows)
                {
                    if (window.isKeyWindow)
                    {
                        return window;
                    }
                }
            }
        }
    }
    else
    {
        return [UIApplication sharedApplication].keyWindow;
    }
    return UIApplication.sharedApplication.windows.firstObject;
}
@end
