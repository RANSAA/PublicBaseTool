//
//  TKUIImportSDK.h
//  TKUIKitDemo
//
//  Created by PC on 2021/1/4.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#ifndef TKUIImportSDK_h
#define TKUIImportSDK_h

#import <TKSDKUniversal/TKSDKUniversal.h>
//#import <TKSDKTool/TKSDKTool.h>


#if __has_include(<MBProgressHUD/MBProgressHUD.h>)
#import <MBProgressHUD/MBProgressHUD.h>
#else
#import "MBProgressHUD.h"
#endif


#if __has_include(<TKPermissionKit/TKPermissionPhoto.h>)
#import <TKPermissionKit/TKPermissionPhoto.h>
#import <TKPermissionKit/TKPermissionCamera.h>
#else
#import "TKPermissionPhoto.h"
#import "TKPermissionCamera.h"
#endif



#endif /* TKUIImportSDK_h */
