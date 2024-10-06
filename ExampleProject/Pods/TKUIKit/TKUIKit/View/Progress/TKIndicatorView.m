//
//  TKIndicatorView.m
//  table
//
//  Created by PC on 2022/1/5.
//

#import "TKIndicatorView.h"

@interface TKIndicatorView ()
@property(nonatomic, assign) CGFloat fixedWidth;
@property(nonatomic, assign) CGRect lastBounds;
@property(nonatomic, assign) CGPoint arcCenter;
@property(nonatomic, assign) CGFloat arcRadius;
@property(nonatomic, strong) CAShapeLayer *firstShapeLayer;
@property(nonatomic, strong) CAShapeLayer *twoShapeLayer;
@property(nonatomic, strong) CAGradientLayer *firstGradientLayer;
@property(nonatomic, strong) CAGradientLayer *twoGradientLayer;
@end

@implementation TKIndicatorView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initConfig];
        [self setupIndicatorUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(TKIndicatorViewStyle)style
{
    if (self = [super initWithFrame:frame]) {
        [self initConfig];
        _style = style;
        [self setupIndicatorUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self initConfig];
        [self setupIndicatorUI];
    }
    return self;
}


- (void)initConfig
{
    _lineWidth = 6;
    _lineColor = UIColor.whiteColor;
    _style = TKIndicatorViewDefaultStyle;
    self.userInteractionEnabled = NO;
}

- (void)setStyle:(TKIndicatorViewStyle)style
{
    if (style != _style) {
        _style = style;
        [self setupIndicatorUI];
    }
}

- (CGFloat)fixedWidth
{
    return MIN(self.frame.size.width, self.frame.size.height);
}

- (CGPoint)arcCenter
{
    return CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
}

- (CGFloat)arcRadius
{
    return self.fixedWidth/2.0 - self.lineWidth/2.0;
}

- (CAGradientLayer *)firstGradientLayer
{
    if (!_firstGradientLayer) {
        _firstGradientLayer = [CAGradientLayer layer];
    }
    return _firstGradientLayer;
}

- (CAGradientLayer*)twoGradientLayer
{
    if (!_twoGradientLayer) {
        _twoGradientLayer = [CAGradientLayer layer];
    }
    return _twoGradientLayer;
}

- (CAShapeLayer *)firstShapeLayer
{
    if (!_firstShapeLayer) {
        _firstShapeLayer = [CAShapeLayer layer];
    }
    return _firstShapeLayer;
}

- (CAShapeLayer *)twoShapeLayer
{
    if (!_twoShapeLayer) {
        _twoShapeLayer = [CAShapeLayer layer];
    }
    return _twoShapeLayer;
}

#pragma mark setter begin
- (void)setLineWidth:(CGFloat)lineWidth
{
    if (lineWidth != _lineWidth) {
        _lineWidth = lineWidth;
        [self needsUpdateIndicator];
    }
}

- (void)setLineColor:(UIColor *)lineColor
{
    if (!CGColorEqualToColor(lineColor.CGColor, _lineColor.CGColor)) {
        _lineColor = lineColor;
        [self needsUpdateIndicator];
    }
}

- (void)setPatternColor:(NSArray *)patternColor
{
    if (![patternColor isEqualToArray:_patternColor]) {
        _patternColor = patternColor;
        [self needsUpdateIndicator];
    }
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    CGRect currentBounds = bounds;
    [self compareChangeWith:currentBounds];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGRect currentBounds = frame;
    currentBounds.origin = CGPointZero;
    [self compareChangeWith:currentBounds];
}

- (void)compareChangeWith:(CGRect)currentBounds
{
    if (!CGRectEqualToRect(currentBounds, self.lastBounds)) {
        [self needsUpdateIndicator];
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    [self needsUpdateIndicator];
}



#pragma mark setupUI,needsUpdate

- (void)setupIndicatorUI
{
    self.layer.mask = nil;
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.layer removeAllAnimations];
    self.lastBounds = self.bounds;
    _firstShapeLayer = nil;
    _twoShapeLayer = nil;
    _firstGradientLayer = nil;
    _twoGradientLayer = nil;


    switch (_style) {
        case TKIndicatorViewGradientStyle:
        {
            [self addColorGradientIndicator];
        }
            break;
        case TKIndicatorViewLinearStyle:
        {
            [self addLinearIndicator];
        }
            break;
        case TKIndicatorViewLinearSegmentStyle:
        {
            [self addLinearSegmentIndicator];
        }
            break;
        case TKIndicatorViewDefaultStyle:
        {
//            [self addDefaultIndicator];
            [self addDefaultIndicatorV2];
        }
            break;
        default:
            break;
    }
}

//update
- (void)needsUpdateIndicator
{
    switch (_style) {
        case TKIndicatorViewGradientStyle:
        {
            [self updateColorGradientIndicator];
        }
            break;

        case TKIndicatorViewLinearStyle:
        {
            [self updateLinearIndicator];
        }
            break;
        case TKIndicatorViewLinearSegmentStyle:
        {
            [self updateLinearSegmentIndicator];
        }
            break;
        case TKIndicatorViewDefaultStyle:
        {
//            [self updateDefaultIndicator];
            [self updateDefaultIndicatorV2];
        }
            break;
        default:
            break;
    }
}


#pragma mark 默认样式
- (void)addDefaultIndicator
{
    CGRect frame = self.bounds;
    
    self.firstShapeLayer.frame = frame;
    UIImage *image = [self contextImage];
    self.firstShapeLayer.contents = (__bridge id)image.CGImage;

    CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAni.removedOnCompletion = NO;
    rotateAni.fromValue = @0;
    rotateAni.toValue = @(2*M_PI);
    rotateAni.repeatCount = HUGE_VALF;
    rotateAni.duration = 1.5f;
    [self.firstShapeLayer addAnimation:rotateAni forKey:nil];
    [self.layer addSublayer:self.firstShapeLayer];
}


- (void)updateDefaultIndicator
{
    if (!_firstShapeLayer) {
        return;
    }
    self.lastBounds = self.bounds;
    CGRect frame = self.bounds;

    self.firstShapeLayer.frame = frame;
    UIImage *image = [self contextImage];
    self.firstShapeLayer.contents = (__bridge id)image.CGImage;
}

- (void)addDefaultIndicatorV2
{
    CGRect frame = self.bounds;

    CGRect frame1 = CGRectMake(0, 0, frame.size.width, frame.size.height/2.0);
    CGRect frame2 = CGRectMake(0, frame.size.height/2.0, frame.size.width, frame.size.height/2.0);
    UIColor *color1,*color2,*color3;
    color1 = self.lineColor;
    color2 = [self.lineColor colorWithAlphaComponent:0.5];
    color3 = [UIColor.whiteColor colorWithAlphaComponent:0.01];

    self.firstGradientLayer.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor];
//    self.firstGradientLayer.startPoint = CGPointMake(1, 0.5);
//    self.firstGradientLayer.endPoint = CGPointMake(0, 0.5);
    self.firstGradientLayer.startPoint = CGPointMake(1, 0);
    self.firstGradientLayer.endPoint = CGPointMake(0, 0);
    self.firstGradientLayer.frame = frame1;

    self.twoGradientLayer.colors = @[(__bridge id)color2.CGColor, (__bridge id)color3.CGColor];
//    self.twoGradientLayer.startPoint = CGPointMake(0, 0.5);
//    self.twoGradientLayer.endPoint = CGPointMake(1, 0.5);
    self.twoGradientLayer.startPoint = CGPointMake(0, 0);
    self.twoGradientLayer.endPoint = CGPointMake(1, 0);
    self.twoGradientLayer.frame = frame2;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:self.arcRadius startAngle:0 endAngle: 2*M_PI clockwise:NO];
    self.firstShapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.firstShapeLayer.lineWidth = self.lineWidth;
    self.firstShapeLayer.strokeColor = UIColor.redColor.CGColor;
    self.firstShapeLayer.lineCap = kCALineCapRound;
    self.firstShapeLayer.path = path.CGPath;
    self.firstShapeLayer.frame = frame;

    self.twoShapeLayer.frame = frame;
    [self.twoShapeLayer addSublayer:self.firstGradientLayer];
    [self.twoShapeLayer addSublayer:self.twoGradientLayer];
    self.twoShapeLayer.mask = self.firstShapeLayer;
    [self.layer addSublayer:self.twoShapeLayer];

    CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAni.removedOnCompletion = NO;
    rotateAni.fromValue = @0;
    rotateAni.toValue = @(2*M_PI);
    rotateAni.repeatCount = HUGE_VALF;
    rotateAni.duration = 1.5f;
    [self.twoShapeLayer addAnimation:rotateAni forKey:nil];
}

- (void)updateDefaultIndicatorV2
{
    if (!_firstShapeLayer) {
        return;
    }
    self.lastBounds = self.bounds;
    CGRect frame = self.bounds;

    CGRect frame1 = CGRectMake(0, 0, frame.size.width, frame.size.height/2.0);
    CGRect frame2 = CGRectMake(0, frame.size.height/2.0, frame.size.width, frame.size.height/2.0);
    UIColor *color1,*color2,*color3;
    color1 = self.lineColor;
    color2 = [self.lineColor colorWithAlphaComponent:0.5];
    color3 = [UIColor.whiteColor colorWithAlphaComponent:0.01];


    self.firstGradientLayer.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor];
    self.firstGradientLayer.frame = frame1;

    self.twoGradientLayer.colors = @[(__bridge id)color2.CGColor, (__bridge id)color3.CGColor];
    self.twoGradientLayer.frame = frame2;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:self.arcRadius startAngle:-0.1 endAngle: 0.1*M_PI clockwise:NO];
    self.firstShapeLayer.path = path.CGPath;
//    self.firstShapeLayer.frame = frame;

    self.twoShapeLayer.frame = frame;
    self.firstShapeLayer.frame = self.twoShapeLayer.bounds;
}

- (UIImage *)contextImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSUInteger count = 48;
    NSUInteger endCount = count -4;
    for (NSInteger i=0; i<endCount; i++) {
        CGFloat w = 2*M_PI/count;
        CGFloat startAngle = w*i;
        CGFloat endAngle = startAngle+w;
        UIColor *storkColor = [self.lineColor colorWithAlphaComponent:i*1.0/count+0.0];
        CGContextAddArc(context, self.arcCenter.x, self.arcCenter.y, self.arcRadius, startAngle, endAngle, NO);
        CGContextSetStrokeColorWithColor(context, storkColor.CGColor);
        CGContextSetLineWidth(context, self.lineWidth);
        if (i==0) {
            CGContextSetLineCap(context, kCGLineCapRound);
        }
        CGContextStrokePath(context);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark 线性
- (void)addLinearIndicator
{
    CGRect frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:self.arcRadius startAngle:0 endAngle: 2.0*M_PI clockwise:YES];
    self.firstShapeLayer.strokeColor = self.lineColor.CGColor;
    self.firstShapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.firstShapeLayer.lineWidth = self.lineWidth;
    self.firstShapeLayer.lineCap = kCALineCapSquare;
    self.firstShapeLayer.path = path.CGPath;
    self.firstShapeLayer.frame = frame;
    [self.layer addSublayer:self.firstShapeLayer];


    CAKeyframeAnimation *keyAni1 = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    keyAni1.duration = 2;
    keyAni1.values = @[@(0.0),@(0.9),@(1.0)];
    keyAni1.keyTimes = @[@(0),@(0.6),@(1.0)];
    keyAni1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyAni1.fillMode = kCAFillModeForwards;
    keyAni1.removedOnCompletion = NO;
    keyAni1.repeatCount = HUGE_VALF;

    CAKeyframeAnimation *keyAni2 = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    keyAni2.duration = 2;
    keyAni2.values = @[@(0.0),@(0),@(1)];
    keyAni2.keyTimes = @[@(0),@(0.5),@(1)];
    keyAni2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyAni2.fillMode = kCAFillModeForwards;
    keyAni2.removedOnCompletion = NO;
    keyAni2.repeatCount = HUGE_VALF;

    CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAni.removedOnCompletion = NO;
    rotateAni.fromValue = [NSNumber numberWithFloat:0];
    rotateAni.toValue = [NSNumber numberWithFloat:2*M_PI];
    rotateAni.repeatCount = HUGE_VALF;
    rotateAni.duration = 3;

    [self.firstShapeLayer addAnimation:keyAni1 forKey:@"keyAni1"];
    [self.firstShapeLayer addAnimation:keyAni2 forKey:@"keyAni2"];
    [self.firstShapeLayer addAnimation:rotateAni forKey:@"rotateAni"];
}

- (void)updateLinearIndicator
{
    if (!_firstShapeLayer) {
        return;
    }

    self.lastBounds = self.bounds;
    CGRect frame = self.bounds;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:self.arcRadius startAngle:0 endAngle: 2.0*M_PI clockwise:YES];
    self.firstShapeLayer.path = path.CGPath;
    self.firstShapeLayer.strokeColor = self.lineColor.CGColor;
    self.firstShapeLayer.lineWidth = self.lineWidth;
    self.firstShapeLayer.frame = frame;
    self.firstShapeLayer.lineCap = kCALineCapRound;
}


#pragma mark LinearSegment
- (void)addLinearSegmentIndicator
{
    CGRect frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:self.arcRadius startAngle:0 endAngle: 2.0*M_PI clockwise:YES];
    self.firstShapeLayer.strokeColor = [[UIColor.whiteColor colorWithAlphaComponent:0.15] CGColor];
    self.firstShapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.firstShapeLayer.lineWidth = self.lineWidth;
    self.firstShapeLayer.lineCap = kCALineCapRound;
    self.firstShapeLayer.path = path.CGPath;
    self.firstShapeLayer.frame = frame;
    [self.layer addSublayer:self.firstShapeLayer];


    path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:self.arcRadius startAngle:0 endAngle: 0.25*M_PI clockwise:YES];
    self.twoShapeLayer.strokeColor = self.lineColor.CGColor;
    self.twoShapeLayer.fillColor = UIColor.clearColor.CGColor;
    self.twoShapeLayer.lineWidth = self.lineWidth;
    self.twoShapeLayer.lineCap = kCALineCapRound;
    self.twoShapeLayer.path = path.CGPath;
    self.twoShapeLayer.frame = frame;
    [self.firstShapeLayer addSublayer:self.twoShapeLayer];


    CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAni.removedOnCompletion = NO;
    rotateAni.fromValue = [NSNumber numberWithFloat:0];
    rotateAni.toValue = [NSNumber numberWithFloat:2*M_PI];
    rotateAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAni.repeatCount = HUGE_VALF;
    rotateAni.duration = 1.3;
    [self.twoShapeLayer addAnimation:rotateAni forKey:@"rotateAni"];
}

- (void)updateLinearSegmentIndicator
{
    if (!_firstShapeLayer) {
        return;
    }

    self.lastBounds = self.bounds;
    CGRect frame = self.bounds;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:self.arcRadius startAngle:0 endAngle: 2.0*M_PI clockwise:YES];
    self.firstShapeLayer.path = path.CGPath;
    self.firstShapeLayer.lineWidth = self.lineWidth;
    self.firstShapeLayer.frame = frame;

    path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:self.arcRadius startAngle:0 endAngle: 0.25*M_PI clockwise:YES];
    self.twoShapeLayer.lineWidth = self.lineWidth;
    self.twoShapeLayer.strokeColor = self.lineColor.CGColor;
    self.twoShapeLayer.path = path.CGPath;
    self.twoShapeLayer.frame = frame;
}


#pragma mark 多颜色渐变
- (void)addColorGradientIndicator
{
    CGRect frame = self.bounds;


    self.firstGradientLayer.frame = frame;
    if (_patternColor.count > 1) {
        NSMutableArray *cors = [[NSMutableArray alloc] initWithCapacity:_patternColor.count];
        for (UIColor *color in _patternColor) {
            [cors addObject:(__bridge id)color.CGColor];
        }
        self.firstGradientLayer.colors = cors;
    }else{
        self.firstGradientLayer.colors = @[(__bridge id)self.lineColor.CGColor, (__bridge id)[self.lineColor colorWithAlphaComponent:0.4].CGColor];
    }

//    self.firstGradientLayer.startPoint = CGPointMake(1, 1);
//    self.firstGradientLayer.endPoint = CGPointMake(0, 5);
//    self.firstGradientLayer.type = kCAGradientLayerRadial;

//    self.firstGradientLayer.startPoint = CGPointMake(1, 0.5);
//    self.firstGradientLayer.endPoint = CGPointMake(0, 0.5);
//    self.firstGradientLayer.type = kCAGradientLayerAxial;

    self.firstGradientLayer.startPoint = CGPointMake(0.0, 0.0);
    self.firstGradientLayer.endPoint = CGPointMake(1, 1);
    self.firstGradientLayer.type = kCAGradientLayerAxial;


    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:self.arcRadius startAngle:0 endAngle: 2*M_PI clockwise:YES];
    self.firstShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.firstShapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.firstShapeLayer.lineWidth = self.lineWidth;
    self.firstShapeLayer.lineCap = kCALineCapRound;
    self.firstShapeLayer.path = path.CGPath;

    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    ani.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    ani.duration = 1.5;
    ani.cumulative = YES;
    ani.removedOnCompletion = NO;
    ani.repeatCount = HUGE_VALF;
    [self.firstGradientLayer addAnimation:ani forKey:nil];
    self.firstGradientLayer.mask = self.firstShapeLayer;
    [self.layer addSublayer:self.firstGradientLayer];
}

- (void)updateColorGradientIndicator
{
    if (!_firstGradientLayer) {
        return;
    }
    self.lastBounds = self.bounds;
    CGRect frame = self.bounds;

    if (_patternColor.count > 1) {
        NSMutableArray *cors = [[NSMutableArray alloc] initWithCapacity:_patternColor.count];
        for (UIColor *color in _patternColor) {
            [cors addObject:(__bridge id)color.CGColor];
        }
        self.firstGradientLayer.colors = cors;
    }else{
        self.firstGradientLayer.colors = @[(__bridge id)self.lineColor.CGColor, (__bridge id)[self.lineColor colorWithAlphaComponent:0.4].CGColor];
    }

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.arcCenter radius:self.arcRadius startAngle:0 endAngle: 2*M_PI clockwise:YES];
    self.firstShapeLayer.lineWidth = self.lineWidth;
    self.firstShapeLayer.path = path.CGPath;
    self.firstGradientLayer.frame = frame;
}



@end
