//
//  TKSlider.m
//  TKUIKitDemo
//
//  Created by PC on 2020/12/31.
//  Copyright © 2020 芮淼一线. All rights reserved.
//

#import "TKSlider.h"


@implementation TKSlider{
    BOOL _isThumbImage ;//标记是否是使用image设置thumb
}


#pragma mark 添加缓冲条
- (UIView *)bufferView
{
    if (!_bufferView) {
        _bufferView = [[UIView alloc] init];
        _bufferView.userInteractionEnabled = NO;
        _bufferView.layer.cornerRadius = 1.5;
        if (@available(iOS 13.0, *)) {
            _bufferView.backgroundColor = UIColor.systemGray2Color;
        } else {
            _bufferView.backgroundColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:178/255.0 alpha:1.0];
        }
        BOOL isElement = YES;
        for (UIView *vi in self.subviews) {
            if ([vi isKindOfClass:NSClassFromString(@"_UISlideriOSVisualElement")]) {
                [vi insertSubview:_bufferView atIndex:0];
                isElement = NO;
                break;
            }
        }
        if (isElement) {
            [self insertSubview:_bufferView atIndex:0];
        }
    }
    return _bufferView;;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_bufferView) {
        [self fixedBufferViewLevel];
        [self updateBufferProgress];
    }
}

- (void)setBufferValue:(CGFloat)bufferValue
{
    _bufferValue = bufferValue<0?0:(bufferValue>1?1.0:bufferValue);
    [self updateBufferProgress];
}

//更新缓存进度
- (void)updateBufferProgress
{
    CGRect frame = [self trackRectForBounds: self.bounds];
    frame.size.width *= _bufferValue;
    self.bufferView.frame = frame;
}

//固定bufferView的层级
- (void)fixedBufferViewLevel
{
    UIView *prentView = self.bufferView.superview;
    NSArray *views = prentView.subviews;
    views = [[views reverseObjectEnumerator] allObjects];
    NSInteger index= 0;
    for (id obj in views) {
        index++;
        if ([obj isKindOfClass:UIImageView.class]) {
            break;
        }
    }
    index = views.count-1-index-1;
    index = index<0?0:index;
    [prentView insertSubview:self.bufferView atIndex:index];
}


/** 创建带阴影的圆形/椭圆图片 */
+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color
{
    CGFloat shadowWidth = 6;
    CGRect rect = (CGRect){{0,0},{size.width+shadowWidth,size.height+shadowWidth}};

    UIGraphicsBeginImageContextWithOptions(rect.size, NO, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextAddEllipseInRect(context, rect);
    UIColor *shawodColor = [UIColor.grayColor colorWithAlphaComponent:0.1];
    CGContextSetFillColorWithColor(context, shawodColor.CGColor);
    CGContextDrawPath(context, kCGPathEOFill);
    CGContextAddEllipseInRect(context, CGRectMake((rect.size.width-size.width)/2.0,(rect.size.height-size.height)/2.0 , size.width, size.height));
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextDrawPath(context, kCGPathEOFill);

//    CGContextFillRect(context, rect);
//    CGContextFillEllipseInRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}


#pragma mark 状态设置


- (void)setThumbImage:(UIImage *)thumbImage
{
    _thumbImage = thumbImage;
    [self setThumbImage:thumbImage forState:UIControlStateNormal];
    [self setThumbImage:thumbImage forState:UIControlStateHighlighted];
}

- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state
{
    [super setThumbImage:image forState:state];
    _isThumbImage = YES;
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor
{
    [super setThumbTintColor:thumbTintColor];
    _isThumbImage = NO;
}

/**
 实现thumb滑动到首尾时thumb中心点与首尾位置对齐
 */
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    CGFloat offX = 4;
    CGFloat offY = 30;

    if (_centerThumb) {
        if (_isThumbImage) {
            offX = self.currentThumbImage.size.width-4;
            offY = self.currentThumbImage.size.height;
        }else{
            offX = 30-4;
            offY = 30;
        }
    }else{
        if (_isThumbImage) {
            offX = -4;//0
            offY = self.currentThumbImage.size.height;
        }else{
            offX = 0;//4
            offY = 30;
        }
    }

    rect.origin.x = rect.origin.x - offX/2.0 ;
    rect.size.width = rect.size.width + offX;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], offX/2.0 , offY/2.0);
}



#pragma mark 点击区域
- (void)setDelegate:(id<TKSilderDelegate>)delegate
{
    _delegate = delegate;
    if (delegate) {
        [self addTargetEvents];
    }
}

- (void)setIsClick:(BOOL)isClick
{
    _isClick = isClick;
    if (_isClick) {
        [self addTapGestureRecognizer];
    }
}


- (void)addTargetEvents
{
    [self addTarget:self action:@selector(changeValueAction) forControlEvents:UIControlEventValueChanged];
    [self addTarget:self action:@selector(touchUpAction) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchUpAction) forControlEvents:UIControlEventTouchUpOutside];
}

- (void)addTapGestureRecognizer
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
    [self addGestureRecognizer:tap];
}

- (void)clickAction:(UITapGestureRecognizer *)gesture
{
    if (!_isClick) {
        return;
    }

    CGPoint point = [gesture locationInView:self];
    //进度条的frame
    CGRect trackRect = [self trackRectForBounds:self.bounds];

    CGFloat maxWidth = trackRect.size.width;
    CGFloat minX = trackRect.origin.x;
    //转换到进度条实际有效宽度
    CGFloat clickWidth = point.x<minX?0:(point.x>(maxWidth+minX)?maxWidth:(point.x-minX));
    CGFloat scale = clickWidth/maxWidth;
    CGFloat v  = scale*((self.maximumValue-self.minimumValue)) + self.minimumValue;
    [self setValue:v];

//    NSLog(@"TKSlider -> t:%@",NSStringFromCGRect(trackRect));
//    NSLog(@"TKSlider -> point.x:%f",point.x);
//    NSLog(@"TKSlider -> clickWidth:%f",clickWidth);


    [self changeValueAction];
    [self end];
}

- (void)touchUpAction
{
    [self end];
}

- (void)changeValueAction
{
    if ([self.delegate respondsToSelector:@selector(TKSlider:changedValue:)]) {
        [self.delegate TKSlider:self changedValue:self.value];
    }
}

- (void)end
{
    if ([self.delegate respondsToSelector:@selector(TKSlider:endValue:)]) {
        [self.delegate TKSlider:self endValue:self.value];
    }
}



@end
