//
//  LaunchPageManage.h
//  ExampleProject
//
//  Created by PC on 2022/8/4.
//
/**
 首次启动时弹出授权用户协议管理
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LaunchPageManager : NSObject

+ (instancetype)shared;

/// 用户协议检测
/// @param completion 在block回调中进行APP初始化配置。
- (void)userAgreementStatusDetectionCompletionHandler:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
