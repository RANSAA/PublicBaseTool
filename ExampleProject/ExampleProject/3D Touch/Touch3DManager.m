//
//  Touch3DManager.m
//  TKSDKXibView
//
//  Created by kimi on 2023/5/26.
//

#import "Touch3DManager.h"

@implementation Touch3DManager

+ (instancetype)shared
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self.class alloc] init];
    });
    return obj;
}


/**
 添加short Items
 添加的图标大小为35x35
 */
- (void)addShortItems
{
    // 创建 item
    UIApplicationShortcutIcon *cameraIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"camera"];
    UIApplicationShortcutIcon *mosaicIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"mosaic"];
    
    UIMutableApplicationShortcutItem *cameraItem = [[UIMutableApplicationShortcutItem alloc] initWithType:@"event://camera" localizedTitle:@"Camera" localizedSubtitle:nil icon:cameraIcon userInfo:nil];
    UIMutableApplicationShortcutItem *mosaicItem = [[UIMutableApplicationShortcutItem alloc] initWithType:@"event://mosaic" localizedTitle:@"Mosaic" localizedSubtitle:nil icon:mosaicIcon userInfo:nil];
    
    // 放到应用中
    [UIApplication sharedApplication].shortcutItems = @[cameraItem,mosaicItem];
}

/**
 3D Touch事件响应回调，回调函数位于application:performActionForShortcutItem:completionHandler:
 */

- (void)performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    NSLog(@"3D Touch shortcutItem.type:%@",shortcutItem.type);
    if (shortcutItem) {
        if ([shortcutItem.type isEqualToString:@"event://camera"]) {
            // 跳转到照相页面
            NSLog(@"跳转到照相页面");
        } else if ([shortcutItem.type isEqualToString:@"event://mosaic"]) {
            // 跳转到马赛克页面
            NSLog(@"跳转到马赛克页面....");
        }
    }
    if (completionHandler) {
        completionHandler(YES);
    }
}


@end
