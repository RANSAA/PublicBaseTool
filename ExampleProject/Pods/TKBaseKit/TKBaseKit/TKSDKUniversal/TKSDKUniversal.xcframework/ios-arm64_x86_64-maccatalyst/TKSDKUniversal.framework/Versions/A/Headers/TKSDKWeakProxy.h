//
//  TKSDKWeakProxy.h
//  TKSDKUniversal
//
//  Created by PC on 2021/12/22.
//  Copyright © 2021 lt. All rights reserved.
//
#import <Foundation/Foundation.h>


/**
 功能：可利用NSProxy的消息转发机制来避免循环引用，用在NSTimer或者CADisplayLink中
 使用示例:
 _link = [CADisplayLink displayLinkWithTarget:[TKSDKWeakProxy proxyWithTarget:self] selector:@selector(tick:)];
 [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

 */

NS_ASSUME_NONNULL_BEGIN

@interface TKSDKWeakProxy : NSProxy
+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
