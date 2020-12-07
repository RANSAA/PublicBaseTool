//
//  JumpToAppStore.h
//  BaseTool
//
//  Created by PC on 2020/4/26.
//  Copyright © 2020 PC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 功能：跳转到Appstore上的指定APP
 PS：需要修改 AppleAppID 的值
*/

NS_ASSUME_NONNULL_BEGIN
@class UIViewController;
@interface JumpToAppStore : NSObject

/**
 不离开本应用，应用内跳转到App Store
 presentVC:跳转Appstore需要依托的控制器
 */
- (void)jumpWithPresentVC:(UIViewController *)presentVC;

/**
 离开本应用,直接跳转到App Store
 */
- (void)jump;

@end

NS_ASSUME_NONNULL_END
