//
//  TKAFNetworkTool.m
//  Orchid
//
//  Created by Mac on 2019/1/11.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKAFNetworkTool.h"
#import "TokenRefreshResult.h"

static NSString *curNoTipUrl = nil;//标记当前不需要进行错误提示的url,(如果有多个url同时请求，并且不需要提示时，需要重新处理)

@implementation TKAFNetworkTool

/** 
 用于装载不需要网络请求错误提示的url
 **/
+ (NSMutableSet *)exceptNoTipUrlSet
{
    static dispatch_once_t onceToken;
    static NSMutableSet *set = nil;
    dispatch_once(&onceToken, ^{
        set = [[NSMutableSet alloc] init];
    });
    return set;
}

/**
 添加不需要网络请求错误提示的url
 并且会记录最后一个url
 **/
+ (void)addExceptUrl:(NSString *)url
{
    NSMutableSet *set = [self exceptNoTipUrlSet];
    [set addObject:url];
    curNoTipUrl = url;
}



+ (NSString *)customRequestURL:(NSString *)url requestType:(TKSDKNetRequestType)requestType responseType:(TKSDKNetResponseType)responseType
{
    NSString *tmpUrl = [super customRequestURL:url requestType:requestType responseType:responseType];
    tmpUrl = [NSString stringWithFormat:@"%@%@",ApiPublicHost,tmpUrl];
    TKLog(@"请求URL:%@",tmpUrl);
    return tmpUrl;
}

+ (void)customPublicHeaderWith:(AFHTTPRequestSerializer *)requestSerializer
{
    [requestSerializer setValue:@"iOS" forHTTPHeaderField:@"Device"];
    [requestSerializer setValue:[UIDevice TK_getAppVersionID] forHTTPHeaderField:@"AppVersion"];
    [requestSerializer setValue:[UIDevice TK_getAppBuild] forHTTPHeaderField:@"AppBuild"];
    [requestSerializer setValue:@"application/x..v1" forHTTPHeaderField:@"Accept"];
    [requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[AppManager shared].sessionid] forHTTPHeaderField:@"Authorization"];

//    [requestSerializer setValue:[AppManager shared].sessionid forHTTPHeaderField:@"Authorization"];
}

+ (id)customRequestMutablePar:(id)par
{
    NSMutableDictionary *tmpPar = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (par) {
        [tmpPar addEntriesFromDictionary:par];
    }
//    [tmpPar addEntriesFromDictionary:@{@"device":[UIDevice TK_getUUID]}];
    TKLog(@"请求参数:\n%@",tmpPar);
    return tmpPar;
}

#pragma mark 筛选响应数据，进行特殊处理
+ (void)customResponseDataWithSuccess:(id)successData responseType:(TKSDKNetResponseType)responseType
{
    BaseResult *result = [BaseResult yy_modelWithJSON:successData];
    [self checkBaseResultCodeWith:result];
    TKLog(@"res:\n%@",successData);
}

#pragma mark 检查项目数据code
+ (void)checkBaseResultCodeWith:(BaseResult *)result
{
    if (result.code == ResultCodeStatusRelogin || result.code == ResultCodeStatusRelogin1) {//重新登录
        [AppManager shared].sessionid = nil;
        [[AppManager shared] saveToLocal];
        
        TKLog(@"过期需要重新登录-->发送通知");
        kNotifactionFunPost(kNotifactionReLogin)
    }else if (result.code == ResultCodeStatusTokenInvalid){//token refrsh
        [self refreshToken];
    }
    
}

#pragma mark 请求错误
+ (void)customResponseError:(NSError *)error
{
    NSMutableSet *set = [self exceptNoTipUrlSet];
    if (set.count>0 && curNoTipUrl) {
        BOOL showTips = YES;
        if ([set member:curNoTipUrl]) {
            curNoTipUrl = nil;
            showTips = NO;
        }
        if (showTips) {
            [TKMBProgressHUD showText:@"请求失败"];
        }
    }else{
        [TKMBProgressHUD showText:@"请求失败"];
    }
    TKLog(@"error:\n%@",error);
}

#pragma mark 刷洗token
+ (void)refreshToken
{
    NSDictionary *par = @{@"token":[AppManager shared].refresh_token};
    [TKAFNetworkTool JSONPostWithUrl:URLRefreshToken par:par success:^(id json) {
        TokenRefreshResult *result = [TokenRefreshResult yy_modelWithJSON:json];
        if (result.code == ResultCodeStatusSuccess) {//更新token
            [AppManager shared].token = result.token;
            [[AppManager shared] saveToLocal];
            TKLog(@"token refresh 成功，更新数据");
            kNotifactionFunPost(kNotifactionLoginSuccess)
        }else{//重新登录
            TKLog(@"过期需要重新登录-->发送通知");
            kNotifactionFunPost(kNotifactionReLogin)
        }
    } fail:^(NSError *error) {
        TKLog(@"过期需要重新登录-->发送通知");
        kNotifactionFunPost(kNotifactionReLogin)
    }];
}

@end
