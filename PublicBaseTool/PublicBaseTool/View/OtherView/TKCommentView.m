//
//  TKCommentView.m
//  Evaluate
//
//  Created by mac on 2019/8/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKCommentView.h"

@implementation TKCommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)instanceSubView
{
    [self.btnSubmit setTitle:@"发布"];
    [self.btnSubmit setTintColor:kColorTheme];
    [self.btnSubmit addTarget:self action:@selector(btnSubmitAction:) forControlEvents:UIControlEventTouchUpInside];
    self.textFieldInput.backgroundColor = kColorViewBg;
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
    vi.backgroundColor = UIColor.clearColor;
    self.textFieldInput.leftView = vi;
    self.textFieldInput.leftViewMode = UITextFieldViewModeAlways;
    [self.textFieldInput setLayerCornerRadiusWith:2];
}

- (void)btnSubmitAction:(UIButton *)btn
{
    [btn setViewUserInteractionEnabledCancel];
    kHiddenKeyboard
    if (self.blockSubmit) {
        self.blockSubmit(self.textFieldInput.text);
    }
}

@end
