//
//  TKAlertController.m
//  TKUIKitDemo
//
//  Created by PC on 2021/1/4.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import "TKAlertController.h"

@implementation TKAlertController

/// 创建UIAlertController并在toView.controller上显示
/// @param actions UIAlertAction数组
/// @param style UIAlertController样式
/// @param toView 加载到toView所在的controller上
/// @param title 标题
/// @param msg 信息文本
+ (UIAlertController *)createAlertControllerWithActions:(NSArray<UIAlertAction *>*)actions style:(UIAlertControllerStyle)style toView:(UIView *)toView title:(nullable NSString *)title msg:(nullable NSString *)msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:style];
    NSInteger i = 0;
    for (UIAlertAction *action in actions) {
        [alert addAction:action];
        action.tag = i++;
    }
    UIViewController *vc = [toView controllerFromController];
    [vc presentViewController:alert animated:YES completion:^{
       
    }];
    return alert;
}

/// 创建包含"确定"与"取消"两个按钮的UIAlertController
/// @param toView 加载到toView所在的controller上
/// @param title 标题
/// @param msg 信息文本
+ (TKAlertController *)TKAlertViewShow:(UIView *)toView Title:(nullable NSString *)title text:(nullable NSString *)msg
{
    TKAlertController *obj = [TKAlertController new];
    UIAlertAction *doneAction   = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        obj.blockDone(action);
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        obj.blockDone(action);
    }];
    NSArray *actions = @[doneAction,cancelAction];
    obj.alertController = [self createAlertControllerWithActions:actions style:UIAlertControllerStyleAlert toView:toView title:title msg:(id)msg];
    return obj;
}


/// 创建包含"确定" 的UIAlertController
/// @param toView 加载到toView所在的controller上
/// @param title 标题
/// @param msg 信息文本
+ (TKAlertController *)TKAlertViewDialogShow:(UIView *)toView Title:(nullable NSString *)title text:(nullable NSString *)msg
{
    TKAlertController *obj = [TKAlertController new];
    UIAlertAction *doneAction  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        obj.blockDone(action);
    }];
    NSArray *actions = @[doneAction];
    obj.alertController = [self createAlertControllerWithActions:actions style:UIAlertControllerStyleAlert toView:toView title:title msg:(id)msg];
    return obj;
}


@end
