//
//  CheckAppVersion.m
//  Evaluate
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CheckAppVersion.h"
#import "AgreementResult.h"

@implementation CheckAppVersion{
    NSString *updateVer;//查询到的版本
}

/** 检查版本  **/
- (void)check
{
    WeakSelf
    NSDictionary *par = @{@"device_type":@"iOS"};
    [TKAFNetworkTool JSONGetWithUrl:URLCenterCheckUpdate par:par success:^(id json) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([BaseResult checkResultModelWithJson:json]) {
                AgreementResult *result = [AgreementResult yy_modelWithJSON:json];
                if (![result.data isKindOfClass:ItemModel.class]) {
                    weakSelf.isUpdate = NO;
                    if (weakSelf.blockNoUpdate) {
                        weakSelf.blockNoUpdate();
                    }
                    return ;
                }
                NSString *ver = [NSString stringWithFormat:@"版本:%@",result.data.version];
                NSString *msg = result.data.updateDescription;
                NSMutableString *str = [[NSMutableString alloc] init];
                [str appendFormat:@"%@\n\n",ver];
                [str appendFormat:@"%@",msg];
                weakSelf.msg = str;
                weakSelf.isUpdate = NO;
                weakSelf.isForceUpdate = 0;
                if (result.data.forceUpdate == 1) {
                    weakSelf.isForceUpdate = YES;
                }

                //版本比较
                NSString *version = [UIDevice TK_getAppVersionID];
                NSString *queryVer= result.data.version;
                self->updateVer = queryVer;
                NSComparisonResult v = [version compare:queryVer options:NSNumericSearch];
                if (v == NSOrderedAscending) {//新版本
                    if (result.data.forceUpdate) {//强制更新
                        weakSelf.isUpdate = YES;
                        if (weakSelf.blockUpdate) {
                            weakSelf.blockUpdate(weakSelf);
                        }
                    }else{
                        if (weakSelf.isIgnoreVer) {//忽略版本
                            NSString *cacheVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"isCheckAppVersionKey"];
                            if (cacheVersion.length<1) {//没有忽略记录
                                weakSelf.isUpdate = YES;
                                if (weakSelf.blockUpdate) {
                                    weakSelf.blockUpdate(weakSelf);
                                }
                            }else{//之前有被忽略的版本信息
                                NSComparisonResult ignoreV = [cacheVersion compare:queryVer options:NSNumericSearch];
                                if (ignoreV == NSOrderedAscending) {//检测到的版本高于被忽略的版本-可以提示更新
                                    weakSelf.isUpdate = YES;
                                    if (weakSelf.blockUpdate) {
                                        weakSelf.blockUpdate(weakSelf);
                                    }
                                }else{//没有高于被忽略的新版本，不更新
                                    weakSelf.isUpdate = NO;
                                    if (weakSelf.blockNoUpdate) {
                                        weakSelf.blockNoUpdate();
                                    }
                                }
                            }
                        }else{//直接弹出更新
                            weakSelf.isUpdate = YES;
                            if (weakSelf.blockUpdate) {
                                weakSelf.blockUpdate(weakSelf);
                            }
                        }
                    }
                }else{//没更新
                    weakSelf.isUpdate = NO;
                    if (weakSelf.blockNoUpdate) {
                        weakSelf.blockNoUpdate();
                    }
                }
            }else{//数据错误
                weakSelf.isUpdate = NO;
                if (weakSelf.blockNoUpdate) {
                    weakSelf.blockNoUpdate();
                }
            }
        });
    } fail:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.isUpdate = NO;
            if (weakSelf.blockNoUpdate) {
                weakSelf.blockNoUpdate();
            }
        });
    }];
}



/**  需要忽略当前版本的时候需要执行该方法 **/
- (void)cacheVersion
{
    [[NSUserDefaults standardUserDefaults] setObject:updateVer forKey:@"isCheckAppVersionKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end




/**
 拉起Appstore
 #import <StoreKit/StoreKit.h>

 <SKStoreProductViewControllerDelegate>

 // 跳转到App Store
- (void)jumpToAppStroe
{
    self.appID = @"1205952707";
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    NSDictionary *dic = [NSDictionary dictionaryWithObject:self.appID forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dic completionBlock:^(BOOL result, NSError * _Nullable error) {
    }];
    [self.presentVC  presentViewController:storeProductVC animated:YES completion:nil];
    TKLog(@"2222");
}


 //SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    TKLog(@"1111");
    [viewController dismissViewControllerAnimated:YES completion:^{

    }];
    [self.presentVC dismissViewControllerAnimated:YES completion:^{

    }];
}




 **/
