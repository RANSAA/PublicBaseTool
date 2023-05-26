//
//  Touch3DManager.h
//  TKSDKXibView
//
//  Created by kimi on 2023/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 3D Touch功能示例：即长按APP图标时出现的编辑条目，并且可以点击操作。
 */
@interface Touch3DManager : NSObject

+ (instancetype)shared;

/**
 添加short Items
 添加的图标大小为35x35
 */
- (void)addShortItems;

/**
 3D Touch事件响应回调，回调函数位于application:performActionForShortcutItem:completionHandler:
 */
- (void)performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler;

@end

NS_ASSUME_NONNULL_END
