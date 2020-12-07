//
//  UIButton+TK.m
//  AdultLP
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIButton+TK.h"

static const void *authCodeTimerKey = &authCodeTimerKey;

@implementation UIButton (TK)


- (void)setAuthCodeTimer:(NSTimer *)authCodeTimer
{
    objc_setAssociatedObject(self, authCodeTimerKey, authCodeTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)authCodeTimer
{
    return objc_getAssociatedObject(self, authCodeTimerKey);
}


#pragma mark ---------通用设置------------
/**  为btn设置通用背景图片 */
- (void)setPublicBackgroundImage
{
    [self setBackgroundImage:kImageName(@"public-btn-bg") forState:UIControlStateNormal];
}


/**
 设置标题的样式颜色与theme保持一致
 面前为蓝色
 **/
- (void)setThemeBlueStyle
{
    [self setBackgroundColor:kColorTheme];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self setTitleColor:kColorWhite];
    [self setLayerCornerRadiusWith:4];
}

/**
 btn样式：白底，蓝字，圆角
 **/
- (void)setBtnStyleWithWBC
{
    [self setBackgroundColor:kColorWhite];
    [self setTitleColor:kColorTheme];
    [self setLayerCornerRadiusWithFive];
}

/**
 btn样式：蓝底，白字，圆角，白边框
 **/
- (void)setBtnStyleWithBWCW
{
    [self setBackgroundColor:kColorTheme];
    [self setTitleColor:kColorWhite];
    [self setLayerCornerRadiusWithFive];
    [self setLayerBorderColor:kColorWhite borderWidth:1.0];
}

/**
 btn样式：背景透明，白字，圆角，白边框
 **/
- (void)setBtnStyleWithAWCW
{
    [self setBackgroundColor:kColorAlpha];
    [self setTitleColor:kColorWhite];
    [self setLayerCornerRadiusWithFive];
    [self setLayerBorderColor:kColorWhite borderWidth:1.0];
}

/**
 btn样式：蓝底，白字，圆角
 **/
- (void)setBtnStyleWithBWC
{
    [self setBackgroundColor:kColorTheme];
    [self setTitleColor:kColorWhite];
    [self setLayerCornerRadiusWithFive];
    self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}




#pragma mark --------验证码相关-------
NSInteger authCodeTimeCount = 59;//定时器总时长
NSInteger authCodeTimeSpace = 1 ;//定时器间隔
//static NSTimer  *authCodeTimer = nil;//定时器
/**
 开启倒计时，并立即执行
 获取验证码倒计时
 */
- (void)timerAutoCodeStart
{
    authCodeTimeSpace = 1;
    authCodeTimeCount = 59;
    
    if (self.authCodeTimer) {
        [self timerAutoCodeRelease];
        [self setTitle:@"获取验证码"];
    }
    self.authCodeTimer = [NSTimer timerWithTimeInterval:authCodeTimeSpace target:self selector:@selector(timerAutoCodeAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.authCodeTimer forMode:NSRunLoopCommonModes];
    [self.authCodeTimer setFireDate:[NSDate distantPast]];
}

/**
 验证码，定时器执行acion
 **/
- (void)timerAutoCodeAction:(NSTimer *)timer
{
    if (authCodeTimeCount == 0) {
        [timer setFireDate:[NSDate distantFuture]];
        self.userInteractionEnabled = YES;
        [self setTitle:@"获取验证码"];
    }else{
        self.userInteractionEnabled = NO;
        NSString *tips = [NSString stringWithFormat:@"%lus后重试",authCodeTimeCount--];
        [self setTitle:tips];
    }
}

/**
 验证码定时器复原
 **/
- (void)timerAutoCodeReset
{
    [self setTitle:@"获取验证码"];
    [self timerAutoCodeRelease];
}

/**
 验证码释放并且复原设置
 **/
- (void)timerAutoCodeRelease
{
    if (self.authCodeTimer) {
        [self.authCodeTimer setFireDate:[NSDate distantFuture]];
        [self.authCodeTimer invalidate];
        self.authCodeTimer = nil;
    }
}

- (void)dealloc
{
    [self timerAutoCodeRelease];
}

@end
