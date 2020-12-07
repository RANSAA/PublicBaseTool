//
//  TKItemView.m
//  LianCard
//
//  Created by Mac on 2019/3/27.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKItemView.h"

@implementation TKItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)instanceSubView
{
    self.xibChildView.backgroundColor = kColorAlpha;
    self.backgroundColor = kColorAlpha;
    self.vView.hidden = YES;
    [self.btnMask addTarget:self action:@selector(btnMaskAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnMaskAction:(UIButton *)btn
{
    [btn setViewUserInteractionEnabledCancel];
    if ([self.delegate respondsToSelector:@selector(TKItemViewClickViewView:)]) {
        [self.delegate TKItemViewClickViewView:self];
    }
}

@end
