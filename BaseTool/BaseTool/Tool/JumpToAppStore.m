//
//  JumpToAppStore.m
//  BaseTool
//
//  Created by PC on 2020/4/26.
//  Copyright © 2020 PC. All rights reserved.
//

#import "JumpToAppStore.h"
#import <StoreKit/StoreKit.h>


// Apple iteuns 中该App对应的ID，用于更新跳转到APP Store
#define AppleAppID @"1436002627"

@interface JumpToAppStore ()<SKStoreProductViewControllerDelegate>

@end

@implementation JumpToAppStore

/**
 跳转到App Store
 presentVC:跳转Appstore需要依托的控制器
 */
- (void)jumpWithPresentVC:(UIViewController *)presentVC
{
    NSString *appID = AppleAppID;
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

@end
