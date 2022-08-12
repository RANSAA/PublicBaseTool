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

/** NSTimer block创建方式，可解决Runloop强引用问题*/
+ (NSTimer *)tk_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

/** NSTimer block创建方式，可解决Runloop强引用问题，需要手动添加到NSRunloop中*/
+ (NSTimer *)tk_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

@end

NS_ASSUME_NONNULL_END
