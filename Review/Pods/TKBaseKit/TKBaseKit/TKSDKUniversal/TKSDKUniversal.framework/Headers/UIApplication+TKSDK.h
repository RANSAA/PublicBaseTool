//
//  UIApplication+TKSDK.h
//  TKSDKUniversal
//
//  Created by PC on 2019/12/23.
//  Copyright © 2019 PC. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (TKSDK)

/**
 xcode11创建项目时，获取keyWindow（PS:原[UIApplication sharedApplication].keyWindow 获取失效）
 如果需要实现iPad多屏处理，最好是使用SceneDelegate管理Window
 PS:该方法遍历[UIApplication sharedApplication]windows，返回keyWindow；
    如果没有找到返回firstObject;如果都没有则返回null
 */
+ (nullable UIWindow*)TK_keyWindow;

@end

NS_ASSUME_NONNULL_END
