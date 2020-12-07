//
//  WebSocketUnit.h
//  swift
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 mac. All rights reserved.
//
/**
 基于SocketRocket 的webSocket组件
 **/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebSocketUnit : NSObject

+ (id)sheard;

/**
 创建并且连接webSocket
 **/
- (void)open;

/**
 断开连接
 **/
- (void)close;

/**
 发送数据，返回NO表示当前不是处于OPEN状态，需要重新连接
 **/
- (BOOL)sendData:(id)data;

/**
 发送心跳包数据，返回NO表示当前不是处于OPEN状态，需要重新连接
 **/
- (BOOL)sendPingData:(nullable NSData *)data;

@end

NS_ASSUME_NONNULL_END
