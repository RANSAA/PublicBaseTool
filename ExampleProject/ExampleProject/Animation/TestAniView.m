//
//  TestAniView.m
//  ExampleProject
//
//  Created by PC on 2022/8/6.
//

#import "TestAniView.h"

@implementation TestAniView

- (void)drawRect:(CGRect)rect {
     //新建动画数组
    CALayer *animationLayer = [CALayer layer];
    CAAnimationGroup *animationGroup = [self animationGroupAnimations:[self animationArray]];
    CALayer *pulsingLayer = [self pulsingLayer:rect animationGroup:animationGroup];
    //将动画 Layer 添加到 animationLayer
    [animationLayer addSublayer:pulsingLayer];

    // 新建缩放动画
    CABasicAnimation *animationTwo = [self oppositeScaleAnimation];
    // 新建一个动画 Layer，将动画添加上去
    CALayer *pulsingLayerTwo = [self pulsingLayer:rect animation:animationTwo];
    //将动画 Layer 添加到 animationLayer
    [animationLayer addSublayer:pulsingLayerTwo];
    [self.layer addSublayer:animationLayer];
}

- (CALayer *)pulsingLayer:(CGRect)rect animation:(CABasicAnimation *)animation {
    CALayer *pulsingLayer = [CALayer layer];
    pulsingLayer.borderWidth = 0.5;
    pulsingLayer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.4].CGColor;
    pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    pulsingLayer.cornerRadius = rect.size.height / 2;
    [pulsingLayer addAnimation:animation forKey:@"plulsing"];
    return pulsingLayer;
}

- (CALayer *)pulsingLayer:(CGRect)rect animationGroup:(CAAnimationGroup *)animationGroup {
    CALayer *pulsingLayer = [CALayer layer];
    pulsingLayer.borderWidth = 1;
    pulsingLayer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.4].CGColor;
    pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    pulsingLayer.cornerRadius = rect.size.height / 2;
    [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];

    return pulsingLayer;
}

- (CAAnimationGroup *)animationGroupAnimations:(NSArray *)array {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.beginTime = CACurrentMediaTime();
    animationGroup.duration = 2;
    animationGroup.repeatCount = 2;
    animationGroup.autoreverses = YES;//动画结束时是否执行逆动画
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];//设置动画的速度变化:淡出
    animationGroup.removedOnCompletion = NO;
    return animationGroup;
}


- (NSArray *)animationArray {
    NSArray *animationArray = nil;
    CABasicAnimation *scaleAnimation = [self scaleAnimation];
    CAKeyframeAnimation *borderColorAnimation = [self borderColorAnimation];
    animationArray = @[scaleAnimation, borderColorAnimation];
    return animationArray;
}

- (CABasicAnimation *)scaleAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];

    scaleAnimation.fromValue = @1;
    scaleAnimation.toValue = @3;
    return scaleAnimation;
}

- (CABasicAnimation *)oppositeScaleAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1;
    scaleAnimation.toValue = @0.7;
    scaleAnimation.beginTime = CACurrentMediaTime();
    scaleAnimation.duration = 2;
    scaleAnimation.repeatCount = CGFLOAT_MAX;
    scaleAnimation.autoreverses = YES;//动画结束时是否执行逆动画
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的速度变化:淡出
    return scaleAnimation;
}

- (CAKeyframeAnimation *)borderColorAnimation {
    CAKeyframeAnimation *borderColorAnimation = [CAKeyframeAnimation animation];
    borderColorAnimation.keyPath = @"borderColor";
    borderColorAnimation.values = @[
        (__bridge id)[[UIColor whiteColor]colorWithAlphaComponent:0.4].CGColor,
        (__bridge id)[[UIColor whiteColor]colorWithAlphaComponent:0.3].CGColor,
        (__bridge id)[[UIColor whiteColor]colorWithAlphaComponent:0.2].CGColor,
        (__bridge id)[[UIColor whiteColor]colorWithAlphaComponent:0.1].CGColor,
        (__bridge id)[[UIColor whiteColor]colorWithAlphaComponent:0.0].CGColor];
    borderColorAnimation.keyTimes = @[@0.2,@0.4,@0.6,@0.8,@1
    ];
    return borderColorAnimation;
}

@end
