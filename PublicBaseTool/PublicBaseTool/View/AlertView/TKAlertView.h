//
//  TKAlertView.h
//  Orchid
//
//  Created by Mac on 2019/1/30.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseXibView.h"

/**
 PS:apple暗夜模式各种默认颜色：https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/dark-mode/
 */



typedef NS_ENUM(NSUInteger,TKAlertViewStyle){
    TKAlertViewStyleAlert = 0,
    TKAlertViewStyleDialog = 1
};

@interface TKAlertView : BaseXibView
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnOK;
@property (strong, nonatomic) IBOutlet UILabel *labTitle;
@property (strong, nonatomic) IBOutlet UILabel *labMsg;
@property (nonatomic, copy) Block blockDone;
@property (nonatomic, copy) Block blockCancel;
@property (nonatomic, assign) BOOL isAlwaysShowClickDone;//点击确认按钮是否不隐藏alert
@property (nonatomic, assign) BOOL isAlwaysShowClickCancel;//点击取消按钮是否不隐藏alert

/**
 只创建，不显示
 **/
+ (TKAlertView *)createViewWithStyle:(TKAlertViewStyle)style title:(NSString *)title msg:(id)msg;

/**
 *有两个按钮: OK , Cancel
 *创建并添加到 view 上
 **/
+ (TKAlertView *)TKAlertViewWithTitle:(NSString *)title text:(id)msg;

/**
 *只有一个 OK 按钮
 *创建并添加到 view 上*
 */
+ (TKAlertView *)TKAlertViewDialogWithTitle:(NSString *)title text:(id)msg;

/** 设置确认按钮的文字  */
- (void)setTextDone:(NSString *)text;
/** 设置取消按钮文字  */
- (void)setTextCancel:(NSString *)text;
/** 设置提示标题的文字  */
- (void)setTipsTitle:(NSString *)text;
/** 设置提示内容的文字  */
- (void)setTipsMsg:(NSString *)text;




#pragma mark ----------直接显示提示文字-------------
/** 提示退出登录 */
+ (TKAlertView *)showTipsLoginOut;
/** 登录异常，请重新登录 */
+ (TKAlertView *)showTipsRelogin;
/** 提示-交卷  **/
+ (TKAlertView *)showTipsExamSubmit;
/** 提示-考试时间到-交卷  **/
+ (TKAlertView *)showTipsExamTimeOut;




@end
