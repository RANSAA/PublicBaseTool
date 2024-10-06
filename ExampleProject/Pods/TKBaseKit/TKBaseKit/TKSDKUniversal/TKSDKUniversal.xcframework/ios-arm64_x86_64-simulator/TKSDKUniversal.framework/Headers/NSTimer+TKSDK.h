//
//  NSTimer+TKSDK.h
//  TKBaseKit
//
//  Created by PC on 2021/12/31.
//  Copyright © 2021 PC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (TKSDK)

/**
 注意:iOS10.0+自带了一个系统级可解决NSTimer循环强应用的block类型的API
 */

/** NSTimer block创建方式，可解决Runloop强引用问题*/
+ (NSTimer *)TKScheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)yesOrNo block:(void (^)(NSTimer *timer))block;

/** NSTimer block创建方式，可解决Runloop强引用问题，需要手动添加到NSRunloop中*/
+ (NSTimer *)TKTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)yesOrNo block:(void (^)(NSTimer *timer))block;


/** NSTimer selector创建方式，使用TKSDKWeakProxy代理方式可解决Runloop强引用问题 */
+ (NSTimer *)TKScheduledTimerWithTimeInterval:(NSTimeInterval)interval selector:(SEL)sel userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
/** NSTimer selector创建方式，使用TKSDKWeakProxy代理方式可解决Runloop强引用问题 */
+ (NSTimer *)TKTimerWithTimeInterval:(NSTimeInterval)interval selector:(SEL)sel userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;


@end

NS_ASSUME_NONNULL_END
