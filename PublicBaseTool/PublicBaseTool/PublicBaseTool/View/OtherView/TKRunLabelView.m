//
//  TKRunLabelView.m
//  HHRunLabelDemo
//
//  Created by chh on 2017/8/30.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "TKRunLabelView.h"

@interface TKRunLabelView()
@property (nonatomic, assign) CGFloat offsetX; //x偏移量
@property (nonatomic, strong) UILabel *moveLabel;
@property (nonatomic, assign) CGFloat labelWidth; //label的宽度
@property (nonatomic, strong) CADisplayLink * disTimer;
@end

@implementation TKRunLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        _speed = 0.2;//默认值
        [self initView];
        [self initTimer];
    }
    return self;
}

- (void)initView{
    _moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_moveLabel];
}

//初始化timer
- (void)initTimer{
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLabelAction)];
    timer.frameInterval = 2.0;
    [timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.disTimer = timer;
}

- (void)setTextColor:(UIColor *)textColor{
    _moveLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font{
    _moveLabel.font = font;
}

//设置速度
- (void)setSpeed:(CGFloat)speed{
    if (speed < 0) {
        speed = 0;
    }else if (speed > 1){
        speed = 1;
    }
    _speed = speed*5;
}

//赋值text
- (void)setText:(NSString *)text{
    _moveLabel.text = text;
    [_moveLabel sizeToFit];
    CGRect rect = _moveLabel.frame;
    rect.size.height = self.frame.size.height;
    _moveLabel.frame = rect;
    _offsetX = _moveLabel.frame.origin.x;
    self.clipsToBounds = YES;//设置了这个属性后才能局部显示
}

- (void)displayLabelAction{
    _labelWidth = self.moveLabel.frame.size.width;
    if (_labelWidth < self.frame.size.width){//如果字能显示全则不移动
        CGRect rect = self.moveLabel.frame;
        rect.origin.x = 10;
        self.moveLabel.frame = rect;
        [self endScrollIsMove:YES];
        return;
    }
    CGRect rect = self.moveLabel.frame;
    _offsetX -= self.speed;
    rect.origin.x = _offsetX;
    self.moveLabel.frame = rect;
    if (_offsetX < -_labelWidth){
        _offsetX = _labelWidth;
        [self endScrollIsMove:NO];
    }
}

//文字展示完成
- (void)endScrollIsMove:(BOOL)isMove
{
    if (isMove) {
        self.disTimer.paused = YES;
        CGFloat after = 4;//
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(after * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.disTimer.paused = NO;
            if([self.delegate respondsToSelector:@selector(TKRunLabelViewEndScrollWith:)]){
                [self.delegate TKRunLabelViewEndScrollWith:self];
            }
        });
    }else{
        if([self.delegate respondsToSelector:@selector(TKRunLabelViewEndScrollWith:)]){
            [self.delegate TKRunLabelViewEndScrollWith:self];
        }
    }
}

@end
