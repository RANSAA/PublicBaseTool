//
//  JumpToAppStore.h
//  BaseTool
//
//  Created by PC on 2020/4/26.
//  Copyright © 2020 PC. All rights reserved.
//
/**
 跳转到Appstore上的指定APP
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JumpToAppStore : NSObject

/**
 跳转到App Store
 presentVC:跳转Appstore需要依托的控制器
 */
- (void)jumpWithPresentVC:(UIViewController *)presentVC;

@end

NS_ASSUME_NONNULL_END
