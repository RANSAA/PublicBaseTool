//
//  TouchIDManager.h
//  ExampleProject
//
//  Created by kimi on 2023/10/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
    Touch ID 指纹解锁
 */
@interface TouchIDManager : NSObject

+ (instancetype)shared;

/**
 开始指纹认证
 success： 是否成功
 msg：提示信息
 */
- (void)startTouchIDWithCompare:(void(^)(BOOL success ,NSString* msg))result;

@end

NS_ASSUME_NONNULL_END
