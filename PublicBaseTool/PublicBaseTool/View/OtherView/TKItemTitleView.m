//
//  TKItemTitleView.m
//  LianCard
//
//  Created by Mac on 2019/3/30.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKItemTitleView.h"

@implementation TKItemTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)instanceSubView
{
    self.backgroundColor = kColorAlpha;
    self.xibChildViewColor = kColorAlpha;
    self.vView.hidden = YES;

    [self.btnMask addTarget:self action:@selector(btnMaskAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnMaskAction:(UIButton *)btn
{
    [btn setViewUserInteractionEnabledCancel];
    if ([self.delegate respondsToSelector:@selector(TKItemTitleViewClick:)]) {
        [self.delegate TKItemTitleViewClick:self];
    }
}

@end
