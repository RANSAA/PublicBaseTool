//
//  TKAnimation.m
//  XiaoMiFeng-Client
//
//  Created by Apple on 2017/9/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TKAnimation.h"


@implementation TKAnimation

#pragma mark fade
/** 浅入浅出动画效果-duration动画时间*/
+(CAAnimation *)TKAnimationGetFadeDuration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.type     = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animation;
}

/** 浅入浅出动画效果*/
 +(CAAnimation *)TKAnimationGetFade
{
    return [self TKAnimationGetFadeDuration:0.3];
}

#pragma mark push
/** push 动画方向type 0:上  1:左  2:下  3:右 */
+ (CAAnimation *)TKAnimationGetPushWithType:(NSInteger)type duration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.type     = kCATransitionPush;
    switch (type) {
        case 0:
            [animation setSubtype:kCATransitionFromTop];
            break;
        case 1:
            [animation setSubtype:kCATransitionFromLeft];
            break;
        case 2:
            [animation setSubtype:kCATransitionFromBottom];
            break;
        case 3:
            [animation setSubtype:kCATransitionFromRight];
            break;
        default:
        {
            [animation setSubtype:kCATransitionFromRight];
        }
    }
    return animation;
}

/** push 动画方向type 0:上  1:左  2:下  3:右,默认时间0.3 */
+ (CAAnimation *)TKAnimationGetPushWithType:(NSInteger)type
{
    return [self TKAnimationGetPushWithType:type duration:0.3];
}


@end
