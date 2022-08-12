//
//  TKAlertController.h
//  TKUIKitDemo
//
//  Created by PC on 2021/1/4.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKUIImportSDK.h"
#import "UIAlertAction+Mark.h"

/**
功能：封装系统 UIAlertController
    注意：UIAlertController.style使用 UIAlertControllerStyleActionSheet并在iPad上使用时需要：
        //ipad
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover)
        {
            popover.sourceView = self.tragetVC.view;
            popover.sourceRect = CGRectMake(Screen_Width/2.0, Screen_Height/2.0-64, 0, 0);
            popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //        popover.barButtonItem = showBtn;
        }
*/

NS_ASSUME_NONNULL_BEGIN

@interface TKAlertController : NSObject
@property (nonatomic, strong) UIAlertController *alertController;
/** 点击回调，传入的类型为UIAlertAction， 可以根据action.tag获取是第几个*/
@property (nonatomic, copy) BlockValue blockDone;


/// 创建UIAlertController并在toView.controller上显示
/// @param actions UIAlertAction数组
/// @param style UIAlertController样式
/// @param toView 加载到toView所在的controller上
/// @param title 标题
/// @param msg 信息文本
+ (UIAlertController *)createAlertControllerWithActions:(NSArray<UIAlertAction *>*)actions style:(UIAlertControllerStyle)style toView:(UIView *)toView title:(nullable NSString *)title msg:(nullable NSString *)msg;

/*
 *有两个按钮: OK , Cancel
 *创建并添加到 view 上
 **/
+ (TKAlertController *)TKAlertViewShow:(UIView *)toView Title:(nullable NSString *)title text:(nullable NSString *)msg;

/// 创建包含"确定" 的UIAlertController
/// @param toView 加载到toView所在的controller上
/// @param title 标题
/// @param msg 信息文本
+ (TKAlertController *)TKAlertViewDialogShow:(UIView *)toView Title:(nullable NSString *)title text:(nullable NSString *)msg;





@end

NS_ASSUME_NONNULL_END
