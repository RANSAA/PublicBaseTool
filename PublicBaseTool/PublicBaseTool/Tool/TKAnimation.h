//
//  TKAnimation.h
//  XiaoMiFeng-Client
//
//  Created by Apple on 2017/9/13.
//  Copyright © 2017年 apple. All rights reserved.
//
/**
 *  封装的一些常用的动画
 **/


#import <Foundation/Foundation.h>

@interface TKAnimation : NSObject

/** 浅入浅出动画效果-默认时间0.3*/
+(CAAnimation *)TKAnimationGetFade;
/** 浅入浅出动画效果-duration动画时间*/
+(CAAnimation *)TKAnimationGetFadeDuration:(CFTimeInterval)duration;

/** push 动画方向type 0:上  1:左  2:下  3:右,默认时间0.3 */
+ (CAAnimation *)TKAnimationGetPushWithType:(NSInteger)type;
/** push 动画方向type 0:上  1:左  2:下  3:右 */
+ (CAAnimation *)TKAnimationGetPushWithType:(NSInteger)type duration:(CFTimeInterval)duration;


@end
