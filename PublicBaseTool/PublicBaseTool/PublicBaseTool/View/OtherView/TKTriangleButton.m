//
//  TKTriangleButton.m
//  LianCard
//
//  Created by Mac on 2019/3/30.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKTriangleButton.h"

@implementation TKTriangleButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)instanceSubView
{
    self.imgIsTouch = YES;
    [self.btnTitle addTarget:self action:@selector(btnTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    self.imgTips.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgAction)];
    [self.imgTips addGestureRecognizer:tap];
}

- (void)btnTitleAction:(UIButton *)btn
{
    [btn setViewUserInteractionEnabledCancel];
    if ([self.delegate respondsToSelector:@selector(TKTriangleButtonClick:)]) {
        [self.delegate TKTriangleButtonClick:self];
    }
}

- (void)tapImgAction
{
    [self.imgTips setViewUserInteractionEnabledCancel];
    if (self.imgIsTouch) {
        if ([self.delegate respondsToSelector:@selector(TKTriangleButtonClick:)]) {
            [self.delegate TKTriangleButtonClick:self];
        }
    }
}




@end
