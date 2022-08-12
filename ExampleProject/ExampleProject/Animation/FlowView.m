//
//  FlowView.m
//  ExampleProject
//
//  Created by PC on 2022/8/10.
//

#import "FlowView.h"

@interface  FlowView ()
@property(nonatomic, strong) UIImageView *imgView0;
@property(nonatomic, strong) UIImageView *imgView1;
@property(nonatomic, strong) CADisplayLink *link;
@end

@implementation FlowView
@synthesize fixed = _fixed;


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return  self;
}

- (void)setupUI
{
    self.clipsToBounds = YES;
    self.direction = FlowViewDirectionVertical;
    self.distance = 0.25;

    self.imgView0 = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imgView0.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView0.clipsToBounds = YES;
    [self addSubview:self.imgView0];

    self.imgView1 = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imgView1.contentMode =  UIViewContentModeScaleAspectFill;
    self.imgView1.clipsToBounds = YES;
    [self addSubview:self.imgView1];


    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

//    //TEST
//    self.imgView0.image = [UIImage imageNamed:@"LaunchImage1"];
//    self.imgView1.image = [UIImage imageNamed:@"LaunchImage2"];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imgView0.image = image;
    self.imgView1.image = image;
}


- (CGFloat)fixed
{
    if (_fixed < 1) {
        if (_direction == FlowViewDirectionVertical) {
            return self.bounds.size.height;
        }else{
            return self.bounds.size.width;
        }
    }
    return _fixed;
}

- (void)setFixed:(CGFloat)fixed
{
    if (fixed>self.fixed) {
        _fixed = fixed;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self fixImageViewsFrame];
}

- (void)fixImageViewsFrame
{
    CGRect frame0 = self.bounds;
    CGRect frame1 = self.bounds;
    BOOL forward = _distance>0?YES:NO;

    if (_direction == FlowViewDirectionVertical) {
        frame0.origin.y = 0;
        frame0.size.height = self.fixed;
        if (forward) {
            frame1.origin.y = self.fixed;
        }else{
            frame1.origin.y = -self.fixed;
        }
        frame1.size.height = self.fixed;
    }else{
        frame0.origin.x = 0;
        frame0.size.width = self.fixed;
        if (forward) {
            frame1.origin.x = self.fixed;
        }else{
            frame1.origin.x -= self.fixed;
        }
        frame1.size.width = self.fixed;
    }
    self.imgView0.frame = frame0;
    self.imgView1.frame = frame1;
}

- (CADisplayLink *)link
{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkUpdate)];
        if (@available(iOS 10.0, *)) {
            _link.preferredFramesPerSecond = 60;
        }else{
//            _link.frameInterval = 1;
        }
    }
    return _link;
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    if (_link) {
        [_link invalidate];
        _link = nil;
    }
}

- (void)displayLinkUpdate
{
    BOOL forward = _distance>0?YES:NO;
    CGRect frame0 = self.imgView0.frame;
    CGRect frame1 = self.imgView1.frame;
    if (_direction == FlowViewDirectionVertical) {
        frame0.origin.y -= self.distance;
        frame1.origin.y -= self.distance;
        if (forward) {
            if (frame0.origin.y < -self.fixed) {
                frame0.origin.y = CGRectGetMaxY(frame1);
            }
            if (frame1.origin.y < -self.fixed) {
                frame1.origin.y = CGRectGetMaxY(frame0);
            }
        }else{
            if (frame0.origin.y > self.fixed) {
                frame0.origin.y = frame1.origin.y-self.fixed;
            }
            if (frame1.origin.y > self.fixed) {
                frame1.origin.y = frame0.origin.y-self.fixed;
            }
        }

    }else{
        frame0.origin.x -= self.distance;
        frame1.origin.x -= self.distance;
        if (forward) {
            if (frame0.origin.x < -self.fixed) {
                frame0.origin.x = CGRectGetMaxX(frame1);
            }
            if (frame1.origin.x < -self.fixed) {
                frame1.origin.x = CGRectGetMaxX(frame0);
            }
        }else{
            if (frame0.origin.x > self.fixed) {
                frame0.origin.x = frame1.origin.x-self.fixed;
            }
            if (frame1.origin.x > self.fixed) {
                frame1.origin.x = frame0.origin.x-self.fixed;
            }
        }

    }
    self.imgView0.frame = frame0;
    self.imgView1.frame = frame1;
}


@end
