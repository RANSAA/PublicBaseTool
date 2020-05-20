//
//  TKAFNetworkTool.h
//  Orchid
//
//  Created by Mac on 2019/1/11.
//  Copyright © 2019年 Mac. All rights reserved.
//
/**
 注意目前回调都是放在主线程中的，后期可以更具情况看看是否修改线程位置
 **/
#import <TKSDKUniversal/TKSDKUniversal.h>

@interface TKAFNetworkTool : TKSDKAFNetworkTool


/**
 添加不需要网络请求错误提示的url
 并且会记录最后一个url
 **/
+ (void)addExceptUrl:(NSString *)url;


@end
