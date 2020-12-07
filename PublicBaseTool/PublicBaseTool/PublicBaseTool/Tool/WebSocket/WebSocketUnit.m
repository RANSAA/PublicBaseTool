//
//  WebSocketUnit.m
//  swift
//
//  Created by mac on 2019/10/9.
//  Copyright © 2019 mac. All rights reserved.
//


#import "WebSocketUnit.h"
#import <SocketRocket/SocketRocket.h>

@interface WebSocketUnit ()<SRWebSocketDelegate>
@property(nonatomic, copy) NSURL *url;
@end

@implementation WebSocketUnit{
    dispatch_queue_t queue;
    SRWebSocket *socket;
}

+ (id)sheard
{
    static dispatch_once_t onceToken;
    static WebSocketUnit *unit = nil;
    dispatch_once(&onceToken, ^{
        unit = [WebSocketUnit new];
        unit->queue = dispatch_queue_create("updateVideoProgress", 0);
    });
    return unit;
}

- (NSURL *)url
{
    NSString *str = [NSString stringWithFormat:@"%@?token=%@",ApiSocketWS,[AppManager shared].sessionid];
    NSLog(@"webSocket ws adr:\n%@",str);
    return [NSURL URLWithString:str];
}

- (void)rest
{
    if (socket) {
        if (socket.readyState == SR_OPEN) {
            [socket close];
        }
        socket.delegate = nil;
        socket = nil;
    }
}

#pragma mark 创建并连接webSocket
/**
 创建并且连接webSocket
 **/
- (void)open
{
    [self rest];
    socket = [[SRWebSocket alloc] initWithURL:self.url];
    socket.delegate = self;
    [socket setDelegateDispatchQueue:queue];
    [socket open];
}

/**
 断开连接
 **/
- (void)close
{
    [self rest];
}

/**
 发送数据，返回NO表示当前不是处于OPEN状态，需要重新连接
 **/
- (BOOL)sendData:(id)data
{
    if (socket.readyState == SR_OPEN) {
        TKLog(@"webSocket数据发送成功！");
        [socket send:data];
        return YES;
    }else{
        TKLog(@"webSocket发送失败，重新open再进行发送");
        //重连并且延时处理，最好是手动处理
        return NO;
    }
}

/**
 发送心跳包数据，返回NO表示当前不是处于OPEN状态，需要重新连接
 **/
- (BOOL)sendPingData:(nullable NSData *)data
{
    if (socket.readyState == SR_OPEN) {
        TKLog(@"webSocket数据发送成功！");
        [socket sendPing:data];
        return YES;
    }else{
        TKLog(@"webSocket发送失败，重新open再进行发送");
        return NO;
    }
}

#pragma mark SRWebSocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    TKLog(@"webSocket连接成功！");
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    //连接失败，可以处理断网重连等操作
    TKLog(@"webSocket连接错误error:%@",error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean
{
    TKLog(@"webSocket连接断开 didClose  code:%ld   reason:%@",code,reason);
}


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    TKLog(@"webSocket从服务器接收到的message:%@",message);
}


- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload
{
    TKLog(@"webSocket心跳pongPayload:%@",pongPayload);
}

@end
