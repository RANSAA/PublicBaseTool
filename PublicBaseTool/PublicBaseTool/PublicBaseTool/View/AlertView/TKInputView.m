//
//  TKInputView.m
//  Orchid
//
//  Created by Mac on 2019/3/14.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKInputView.h"

typedef NS_ENUM(NSUInteger,TKInputViewStyle){
    TKInputViewStyleAlert = 0,
    TKInputViewStyleDialog = 1
};

@interface TKInputView ()
@property (strong, nonatomic) IBOutlet UIView *showView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layShowViewLeftSpace;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layShowViewRigthSpace;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layScrollVIewSpaceHeigth;

@end


@implementation TKInputView

- (void)instanceSubView
{
    CGFloat space = 38*Screen_Width/375.0;
    self.layShowViewLeftSpace.constant = space;
    self.layShowViewRigthSpace.constant = space;
    self.layScrollVIewSpaceHeigth.constant = Screen_Height;
    [self.showView setLayerCornerRadiusWith:15];
    [self.btnDone addTarget:self action:@selector(btnDoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnOK addTarget:self action:@selector(btnDoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCancel addTarget:self action:@selector(btnCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.labTitle.textColor = kColorTheme;
    [self.btnDone setTitleColor:kColorTheme];
    [self.btnOK setTitleColor:kColorTheme];
}

- (void)show
{
    UIView *fromView = appWin;
    self.frame = Screen_Bounds;
    [fromView addSubview:self];
    [fromView.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
}

- (void)hidden
{
    [self.superview.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
    [self removeFromSuperview];
}

- (void)btnDoneAction
{
    [self hidden];
    if(self.blockDone){
        self.blockDone(self.textField.text);
    }
}

- (void)btnCancelAction
{
    [self hidden];
    if (self.blockCancel) {
        self.blockCancel();
    }
}

+ (TKInputView *)instanViewWithStyle:(TKInputViewStyle)style
{
    TKInputView *alertView = [[TKInputView alloc] init];
    if (style == TKInputViewStyleAlert) {
        alertView.btnOK.hidden = YES;
    }else{
        alertView.btnDone.hidden = YES;
        alertView.btnCancel.hidden = YES;
    }
    return alertView;
}

/**
 *有两个按钮: OK , Cancel
 *创建并添加到 view 上
 **/
+ (TKInputView *)TKInputViewWithTitle:(NSString *)title
{
    TKInputView *alertView = [TKInputView instanViewWithStyle:TKInputViewStyleAlert];
    alertView.labTitle.text = title;
    [alertView show];
    return alertView;
}

/**
 *只有一个 OK 按钮
 *创建并添加到 view 上*
 */
+ (TKInputView *)TKInputViewDialogWithTitle:(NSString *)title
{
    TKInputView *alertView = [TKInputView instanViewWithStyle:TKInputViewStyleAlert];
    alertView.labTitle.text = title;
    [alertView show];
    return alertView;
}

@end
