//
//  TKAlertView.m
//  Orchid
//
//  Created by Mac on 2019/1/30.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKAlertView.h"



@interface TKAlertView ()
@property (strong, nonatomic) IBOutlet UIView *showView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layShowViewLeftSpace;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layShowViewRigthSpace;

@end

@implementation TKAlertView


- (void)instanceSubView
{
    CGFloat space = 38*Screen_Width/375.0;
    self.layShowViewLeftSpace.constant = space;
    self.layShowViewRigthSpace.constant = space;
    [self.showView setLayerCornerRadiusWith:10];
    [self.btnDone addTarget:self action:@selector(btnDoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnOK addTarget:self action:@selector(btnDoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCancel addTarget:self action:@selector(btnCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    //背景颜色配置
    UIColor *bgColor = [UIColor TKLightColor:kRGBColor(68, 68, 70) darkColor:kRGBColor(54, 54, 56)];
    bgColor = [UIColor TKLightColor:UIColor.whiteColor darkColor:kRGBColor(36, 36, 38)];
    UIColor *lineColor = [UIColor TKLightColor:kHEXColor(@"E9E9E9") darkColor:kRGBColor(68, 68, 70)];
    self.showView.backgroundColor   = bgColor;
    self.bottomView.backgroundColor = lineColor;
    self.btnDone.backgroundColor    = bgColor;
    self.btnCancel.backgroundColor  = bgColor;
    self.btnOK.backgroundColor      = bgColor;
    UIColor *titleColor  = [UIColor TKLightColor:UIColor.blackColor darkColor:kRGBColor(188, 188, 192)];
    UIColor *msgColor    = [UIColor TKLightColor:UIColor.blackColor darkColor:UIColor.whiteColor];
    UIColor *doneColor   = [UIColor TKLightColor:kRGBColor(68, 68, 70) darkColor:kRGBColor(188, 188, 192)];
    UIColor *cancelColor = [UIColor TKLightColor:kRGBColor(68, 68, 70) darkColor:kRGBColor(188, 188, 192)];
    self.labTitle.textColor = titleColor;
    self.labMsg.textColor   = msgColor;
    [self.btnDone setTitleColor:doneColor];
    [self.btnCancel setTitleColor:cancelColor];
    [self.btnOK setTitleColor:doneColor];
    
    
    self.btnOK.titleLabel.font = [UIFont systemFontOfSize:12.5];
    self.btnDone.titleLabel.font = [UIFont systemFontOfSize:12.5];
    self.btnCancel.titleLabel.font = [UIFont systemFontOfSize:12.5];
    self.labTitle.font = [UIFont systemFontOfSize:13];
}

- (void)show
{
    UIView *fromView = appWin;
    self.frame = Screen_Bounds;
    [fromView addSubview:self];
//    [fromView.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
}


- (void)hidden
{
//    [self.superview.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
    [self removeFromSuperview];
}

- (void)btnDoneAction
{

    if (!self.isAlwaysShowClickDone) {
        [self hidden];
    }
    if(self.blockDone){
        self.blockDone();
    }
}

- (void)btnCancelAction
{
    if (!self.isAlwaysShowClickCancel) {
        [self hidden];
    }
    if (self.blockCancel) {
        self.blockCancel();
    }
}

/**
 只创建，不显示
 **/
+ (TKAlertView *)createViewWithStyle:(TKAlertViewStyle)style title:(NSString *)title msg:(id)msg
{
    TKAlertView *alertView = [[TKAlertView alloc] init];
    if (style == TKAlertViewStyleAlert) {
        alertView.btnOK.hidden = YES;
    }else{
        alertView.btnDone.hidden = YES;
        alertView.btnCancel.hidden = YES;
    }
    alertView.labTitle.text = title;
    if ([msg isKindOfClass:[NSAttributedString class]]) {
        alertView.labMsg.attributedText = msg;
    }else{
        alertView.labMsg.text   = msg;
    }
    return alertView;
}

+ (TKAlertView *)instanViewWithStyle:(TKAlertViewStyle)style title:(NSString *)title msg:(id)msg
{
    TKAlertView *alertView = [self createViewWithStyle:style title:title msg:msg];
    [alertView show];
    return alertView;
}


/**
 *有两个按钮: OK , Cancel
 *创建并添加到 view 上
 **/
+ (TKAlertView *)TKAlertViewWithTitle:(NSString *)title text:(id)msg
{
    TKAlertView *alertView = [TKAlertView instanViewWithStyle:TKAlertViewStyleAlert title:title msg:msg];
    return alertView;
}

/**
 *只有一个 OK 按钮
 *创建并添加到 view 上*
 */
+ (TKAlertView *)TKAlertViewDialogWithTitle:(NSString *)title text:(id)msg
{
    TKAlertView *alertView = [TKAlertView instanViewWithStyle:TKAlertViewStyleDialog title:title msg:msg];
    return alertView;
}



#pragma mark ----------设置-------------
/** 设置提示标题的文字  */
- (void)setTipsTitle:(NSString *)text
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.labTitle.text = text;
    });
}

/** 设置提示内容的文字  */
- (void)setTipsMsg:(NSString *)text
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.labMsg.text = text;
    });
}

/** 设置确认按钮的文字  */
- (void)setTextDone:(NSString *)text
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.btnOK setTitle:text forState:UIControlStateNormal];
        [weakSelf.btnDone setTitle:text forState:UIControlStateNormal];
    });
}

/** 设置取消按钮文字  */
- (void)setTextCancel:(NSString *)text
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.btnCancel setTitle:text forState:UIControlStateNormal];
    });
}

#pragma mark ----------直接显示提示文字-------------

/** 提示退出登录 */
+ (TKAlertView *)showTipsLoginOut
{
    return [TKAlertView TKAlertViewWithTitle:@"提示" text:@"退出登录"];
}

/** 登录异常，请重新登录 */
+ (TKAlertView *)showTipsRelogin
{
    return [TKAlertView TKAlertViewWithTitle:@"提示" text:@"身份已过期，请重新登录"];
}

/** 提示-交卷  **/
+ (TKAlertView *)showTipsExamSubmit
{
    return [TKAlertView TKAlertViewWithTitle:@"提示" text:@"是否确认提交试卷？"];
}

/** 提示-考试时间到-交卷  **/
+ (TKAlertView *)showTipsExamTimeOut
{
    return [TKAlertView TKAlertViewDialogWithTitle:@"提示" text:@"时间到，请交卷！"];
}

@end
