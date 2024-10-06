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
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layTitleHeight;

@end

@implementation TKAlertView


- (void)instanceSubView
{
    self.showView.layer.masksToBounds = YES;
    [self.showView.layer setCornerRadius:15];
    [self.btnDone addTarget:self action:@selector(btnDoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnOK addTarget:self action:@selector(btnDoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCancel addTarget:self action:@selector(btnCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    //背景颜色配置
    UIColor *bgColor = [UIColor colorWithLight:kRGBColor(68, 68, 70) dark:kRGBColor(54, 54, 56)];
    bgColor = [UIColor colorWithLight:UIColor.whiteColor dark:kRGBColor(36, 36, 38)];
    UIColor *lineColor = [UIColor colorWithLight:kHEXColor(@"E9E9E9") dark:kRGBColor(68, 68, 70)];
    self.showView.backgroundColor   = bgColor;
    self.bottomView.backgroundColor = lineColor;
    self.btnDone.backgroundColor    = bgColor;
    self.btnCancel.backgroundColor  = bgColor;
    self.btnOK.backgroundColor      = bgColor;
    UIColor *titleColor  = [UIColor colorWithLight:UIColor.blackColor dark:kRGBColor(188, 188, 192)];
    UIColor *msgColor    = [UIColor colorWithLight:UIColor.blackColor dark:UIColor.whiteColor];
    UIColor *doneColor   = [UIColor colorWithLight:kRGBColor(68, 68, 70) dark:kRGBColor(188, 188, 192)];
    UIColor *cancelColor = [UIColor colorWithLight:kRGBColor(68, 68, 70) dark:kRGBColor(188, 188, 192)];
    self.labTitle.textColor = titleColor;
    self.labMsg.textColor   = msgColor;
    [self.btnDone setTitleColor:doneColor];
    [self.btnCancel setTitleColor:cancelColor];
    [self.btnOK setTitleColor:doneColor];
    
    
    self.btnOK.titleLabel.font = [UIFont systemFontOfSize:13.5];
    self.btnDone.titleLabel.font = [UIFont systemFontOfSize:13.5];
    self.btnCancel.titleLabel.font = [UIFont systemFontOfSize:13.5];
    self.labTitle.font = [UIFont systemFontOfSize:13+8];
    self.labMsg.font = [UIFont systemFontOfSize:13.0];
}

- (void)show
{
    UIView *fromView = appWin;
    self.frame = kScreenBounds;
    [fromView addSubview:self];
    [fromView.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *layTop = [self.topAnchor constraintEqualToAnchor:fromView.topAnchor];
    NSLayoutConstraint *layLeft = [self.leftAnchor constraintEqualToAnchor:fromView.leftAnchor];
    NSLayoutConstraint *layBottom = [self.bottomAnchor constraintEqualToAnchor:fromView.bottomAnchor];
    NSLayoutConstraint *layRight = [self.rightAnchor constraintEqualToAnchor:fromView.rightAnchor];
    layTop.active = YES;
    layLeft.active = YES;
    layBottom.active = YES;
    layRight.active = YES;

    [self updateTitleHeight];
}


- (void)hidden
{
    [self.superview.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
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

#pragma mark 更新title height
- (void)updateTitleHeight
{
    if (self.labTitle.text.length<1) {
        self.layTitleHeight.constant = 36-16-8;
    }else{
        self.layTitleHeight.constant = 36;
    }
}


- (void)updateShowMarginConstraints
{
//    CGFloat n = Screen_Width/375.0;
//    CGFloat space = 48*n;//46
//    if (![UIDevice TK_isDeviceWithInterfaceIphone]) {//iPad
//        space = 98*n;
//    }

    CGFloat min = [self min:kScreenWidth y:kScreenHeight];
    //计算show的宽度
    CGFloat width = min - 2*(48*min/375.0);//default margin 48
    width = min<375?226:284;
    CGFloat space = (kScreenWidth - width)/2.0;

    self.layShowViewLeftSpace.constant = space;
    self.layShowViewRigthSpace.constant = space;
}

- (CGFloat)min:(CGFloat)x y:(CGFloat)y
{
    return x<y?x:y;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateShowMarginConstraints];
}

#pragma mark ----------设置-------------
/** 设置提示标题的文字  */
- (void)setTipsTitle:(NSString *)text
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.labTitle.text = text;
        [weakSelf updateTitleHeight];
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


@end
