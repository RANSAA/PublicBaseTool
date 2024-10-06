//
//  JumpToAppStore.m
//  BaseTool
//
//  Created by PC on 2020/4/26.
//  Copyright © 2020 PC. All rights reserved.
//

#import "JumpToAppStore.h"
#import <StoreKit/StoreKit.h>
#import <UIKit/UIKit.h>



// Apple iteuns 中该App对应的ID，用于更新跳转到APP Store
//#define AppleAppID @"1436002627"

@interface JumpToAppStore ()<SKStoreProductViewControllerDelegate>

@end

@implementation JumpToAppStore{
    NSString* _AppleAppID;
}

/** 设置需要跳转应用的Apple ID */
- (void)setAppleAppID:(NSString *)appID
{
    _AppleAppID = appID;
}


/**
 不离开本应用，应用内跳转到App Store
 presentVC:跳转Appstore需要依托的控制器
 */
- (void)jumpWithPresentVC:(UIViewController *)presentVC
{
    NSString *appID = _AppleAppID;
    NSDictionary *dic = [NSDictionary dictionaryWithObject:appID forKey:SKStoreProductParameterITunesItemIdentifier];
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    [storeProductVC loadProductWithParameters:dic completionBlock:^(BOOL result, NSError * _Nullable error) {
    }];
    [presentVC  presentViewController:storeProductVC animated:YES completion:nil];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}


/**
 离开本应用,直接跳转到App Store
 */
- (void)jump
{
    NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/app/apple-store/id%@?mt=8",_AppleAppID];
    NSURL *url = [NSURL URLWithString:str];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {

            }];
        }else{
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
