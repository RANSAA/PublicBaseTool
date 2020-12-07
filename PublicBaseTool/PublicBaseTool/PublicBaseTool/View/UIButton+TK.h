//
//  UIButton+TK.h
//  AdultLP
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TK)
/** 定时器 */
@property (nonatomic, strong, nullable) NSTimer *authCodeTimer;

#pragma mark ---------通用设置------------
/**  为btn设置通用背景图片 */
- (void)setPublicBackgroundImage;

/**
 设置标题的样式颜色与theme保持一致
 面前为蓝色
 **/
- (void)setThemeBlueStyle;
/**
 btn样式：白底，蓝字，圆角
 **/
- (void)setBtnStyleWithWBC;
/**
 btn样式：蓝底，白字，圆角，白边框
 **/
- (void)setBtnStyleWithBWCW;
/**
 btn样式：背景透明，白字，圆角，白边框
 **/
- (void)setBtnStyleWithAWCW;
/**
 btn样式：蓝底，白字，圆角
 **/
- (void)setBtnStyleWithBWC;




#pragma mark --统一处理验证码定时器--
/**
 开启倒计时，并立即执行
 获取验证码倒计时
 */
- (void)timerAutoCodeStart;

/**
 验证码定时器复原
 **/
- (void)timerAutoCodeReset;



@end

NS_ASSUME_NONNULL_END
