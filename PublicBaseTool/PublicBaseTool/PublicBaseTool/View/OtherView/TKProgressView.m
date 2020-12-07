//
//  TKProgressView.m
//  Evaluate
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKProgressView.h"

@interface TKProgressView ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layProgressViewWidth;

@end

@implementation TKProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)instanceSubView
{
    _progress = 0.0;
    self.xibChildViewColor = kColorAlpha;
    [self.trackView setLayerCornerRadiusWith:4.0];
    [self.progressView setLayerCornerRadiusWith:4.0];
    self.trackView.backgroundColor = kHEXColor(@"#E6E6E6");
    self.progressView.backgroundColor = kColorTheme;
    self.layProgressViewWidth.constant = 0.0;
}

- (void)setProgress:(CGFloat)progress
{
    if (progress<0) {
        _progress = 0.0;
    }else if (progress>1.0){
        _progress = 1.0;
    }else{
        _progress = progress;
    }
//    self.layProgressViewWidth.constant = _progress*self.bounds.size.width;
    [self setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layProgressViewWidth.constant = _progress*self.bounds.size.width;
}

@end
