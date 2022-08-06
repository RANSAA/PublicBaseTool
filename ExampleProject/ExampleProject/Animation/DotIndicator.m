//
//  DotIndicator.m
//  ExampleProject
//
//  Created by PC on 2022/8/6.
//

#import "DotIndicator.h"

@interface DotIndicator ()
@property(nonatomic, strong) UIView *dot0;
@property(nonatomic, strong) UIView *dot1;
@end

@implementation DotIndicator

- (UIView*)dot0
{
    if (!_dot0) {
        _dot0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _dotSize, _dotSize)];
        _dot0.clipsToBounds = YES;
        _dot0.layer.cornerRadius = _dotSize/2.0;
        _dot0.backgroundColor = _color1;
    }
    return _dot0;
}

- (UIView *)dot1
{
    if (!_dot1) {
        _dot1 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, _dotSize, _dotSize)];
        _dot1.clipsToBounds = YES;
        _dot1.layer.cornerRadius = _dotSize/2.0;
        _dot1.backgroundColor = _color2;
    }
    return _dot1;
}

- (void)setColor1:(UIColor *)color1
{
    _color1 = color1;
    if (_dot0) {
        _dot0.backgroundColor = color1;
    }
}

- (void)setColor2:(UIColor *)color2
{
    _color2 = color2;
    if (_dot1) {
        _dot1.backgroundColor = color2;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _dotSize = 12;
    _dotSpace = 2.0;
    _duration = 2.0;
    _style = DotIndicatorStyleLTR;
    _color1 = UIColor.yellowColor;
    _color2 = UIColor.cyanColor;

    [self addSubview:self.dot1];
    [self addSubview:self.dot0];

 
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateSubviewFrame];
    [self startAnimation];
}

- (void)updateSubviewFrame
{
    switch (_style) {
        case DotIndicatorStyleLTR:
        {
            [self bringSubviewToFront:self.dot0];
            CGFloat x = self.bounds.size.width/2.0;
            CGFloat y = self.bounds.size.height/2.0;
            CGRect frame = self.dot0.frame;
            frame.origin.x = x - _dotSize - _dotSpace;
            frame.origin.y = y - _dotSize/2.0;
            self.dot0.frame = frame;
            frame.origin.x = x+_dotSpace;
            self.dot1.frame = frame;
        }
            break;
        case DotIndicatorStyleZoom:
        {

            [self bringSubviewToFront:self.dot1];
            CGFloat x = self.bounds.size.width/2.0;
            CGFloat y = self.bounds.size.height/2.0;
            self.dot0.center = CGPointMake(x, y);
            self.dot1.center = CGPointMake(x, y);
        }
            break;;

        default:
            break;
    }
}


- (void)removeAllAnimations
{
    [self.dot0.layer removeAllAnimations];
    [self.dot1.layer removeAllAnimations];
}

- (void)startAnimation
{
    [self removeAllAnimations];

    switch (_style) {
        case DotIndicatorStyleLTR:
            [self animationWithSwapLR];
            break;
        case DotIndicatorStyleZoom:
            [self animationWithReverseScale];
            break;

        default:
            break;
    }
}

/**
 左右交换animation
 */
- (void)animationWithSwapLR
{
    CFTimeInterval duration = _duration;
    CAKeyframeAnimation *aniScale1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    aniScale1.values = @[@(1.0),@(1.25),@(1.0),@(0.75),@(1.0)];

    CAKeyframeAnimation *aniPostion1 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    CGFloat offX1 = CGRectGetMidX(self.dot0.frame);
    aniPostion1.values = @[@(offX1),@(offX1 + _dotSize + _dotSpace*2),@(offX1)];

    CAAnimationGroup *group1 = [CAAnimationGroup animation];
    group1.duration = duration;
    group1.animations = @[aniPostion1,aniScale1];
    group1.repeatCount = HUGE;
    group1.removedOnCompletion = NO;
    [self.dot0.layer addAnimation:group1 forKey:@"group"];


    CAKeyframeAnimation *aniScale2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    aniScale2.values = @[@(1.0),@(0.75),@(1.0),@(1.25),@(1.0)];

    CAKeyframeAnimation *aniPostion2 = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    CGFloat offX2 = CGRectGetMidX(self.dot1.frame);
    aniPostion2.values = @[@(offX2),@(offX2 - _dotSize - _dotSpace*2),@(offX2)];

    CAAnimationGroup *group2 = [CAAnimationGroup animation];
    group2.duration = duration;
    group2.animations = @[aniPostion2,aniScale2];
    group2.repeatCount = HUGE;
    group2.removedOnCompletion = NO;
    [self.dot1.layer addAnimation:group2 forKey:@"group"];

}

- (void)animationWithReverseScale
{
    CFTimeInterval duration = _duration;
    CAKeyframeAnimation *aniScale1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    aniScale1.values = @[@(1.0),@(1.5),@(1.0)];
    aniScale1.duration = duration;
    aniScale1.repeatCount = HUGE;
    aniScale1.removedOnCompletion = NO;
    [self.dot0.layer addAnimation:aniScale1 forKey:@"scale"];

    CAKeyframeAnimation *aniScale2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    aniScale2.values = @[@(1.0),@(0.5),@(1.0)];
    aniScale2.duration = duration;
    aniScale2.repeatCount = HUGE;
    aniScale2.removedOnCompletion = NO;
    [self.dot1.layer addAnimation:aniScale2 forKey:@"scale"];
}

@end
