//
//  TKSDKUniversal.h
//  TKSDKUniversal
//
//  Created by Mac on 2019/2/23.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


//! Project version number for TKSDKUniversal.
FOUNDATION_EXPORT double TKSDKUniversalVersionNumber;

//! Project version string for TKSDKUniversal.
FOUNDATION_EXPORT const unsigned char TKSDKUniversalVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <TKSDKUniversal/PublicHeader.h>

//定义的一些通用宏
#import "TKSDKUniversalMacro.h"

//扩展
#import "NSObject+TKSDK.h"
#import "NSString+TKSDK.h"
#import "UIButton+TKSDK.h"
#import "UIColor+TKSDK.h"
#import "UIImage+TKSDK.h"
#import "UIDevice+TKSDK.h"
#import "UIView+TKSDK.h"
#import "UIApplication+TKSDK.h"

//基础通用框架
#import "TKSDKXibView.h"
#import "TKSDKNavigationBar.h"
#import "TKSDKNavigationController.h"
#import "TKSDKViewController.h"
#import "TKSDKTableViewController.h"
#import "TKSDKCollectionViewController.h"
#import "TKSDKListViewController.h"
#import "TKSDKGridViewController.h"


//通用的一些基础工具类
#import "TKSDKClearManager.h"
#import "TKSDKUniversalBundle.h"
