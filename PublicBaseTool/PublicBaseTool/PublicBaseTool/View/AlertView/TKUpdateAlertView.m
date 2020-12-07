//
//  TKUpdateAlertView.m
//  LianCard
//
//  Created by Mac on 2019/4/24.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKUpdateAlertView.h"

@interface TKUpdateAlertView ()
@property (strong, nonatomic) IBOutlet UIView *showView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layShowViewLeftSpace;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layShowViewRigthSpace;
@end

@implementation TKUpdateAlertView

- (void)instanceSubView
{
    CGFloat space = 38*Screen_Width/375.0;
    self.layShowViewLeftSpace.constant = space;
    self.layShowViewRigthSpace.constant = space;
    [self.showView setLayerCornerRadiusWith:15];
    [self.btnDone addTarget:self action:@selector(btnDoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnOK addTarget:self action:@selector(btnDoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCancel addTarget:self action:@selector(btnCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.labTitle.textColor = kColorTheme;
    [self.btnDone setTitleColor:kColorTheme];
    [self.btnOK setTitleColor:kColorTheme];
}


/** 设置提示信息
 type  0：显示两个按钮 1：显示一个按钮
 */
- (void)setTitle:(NSString *)title version:(NSString *)version remark:(NSString *)remark type:(NSInteger)type
{
    self.btnDone.hidden = YES;
    self.btnCancel.hidden = YES;
    self.btnOK.hidden = YES;
    if (type == 1) {
        self.btnOK.hidden = NO;
    }else{
        self.btnDone.hidden = NO;
        self.btnCancel.hidden = NO;
    }
    self.labTitle.text = title;
    self.labVersion.text = version;
    self.textViewRemark.text = remark;
    self.type = type;
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
//    [self hidden];
    if(self.blockDone){
        self.blockDone();
    }
}

- (void)btnCancelAction
{
//    [self hidden];
    if (self.blockCancel) {
        self.blockCancel();
    }
}

@end
