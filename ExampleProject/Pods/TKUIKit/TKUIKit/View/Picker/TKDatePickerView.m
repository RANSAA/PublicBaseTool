//
//  TKDatePickerView.m
//  Orchid
//
//  Created by Mac on 2019/2/23.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKDatePickerView.h"

@interface TKDatePickerView ()


@end

@implementation TKDatePickerView

- (void)instanceSubView
{
    self.labTitle.text = nil;
    self.labTitle.font = [UIFont systemFontOfSize:16];
    
    UIColor *titleColor  = [UIColor colorWithLight:UIColor.blackColor dark:kRGBColor(188, 188, 192)];
    UIColor *backColor   = [UIColor colorWithLight:kRGBColor(68, 68, 70) dark:kRGBColor(188, 188, 192)];
    UIColor *toolColor = [UIColor colorWithLight:kRGBColor(245, 245, 245) dark:kRGBColor(58, 58, 60)];
    UIColor *pickerColor   = [UIColor colorWithLight:UIColor.whiteColor dark:kRGBColor(72, 72, 74)];
    self.datePicker.backgroundColor = pickerColor;
    self.toolView.backgroundColor = toolColor;
    self.labTitle.textColor = titleColor;
    [self.btnDone setTitleColor:backColor];
    [self.btnCancel setTitleColor:backColor];
}

- (void)show
{
    [self showWithView:appWin];
}

- (void)showWithView:(UIView *)view
{
    self.frame = kScreenBounds;
    [view addSubview:self];
    [view.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
}

- (void)hiddenView
{
    [self.superview.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
    [self removeFromSuperview];
}

- (IBAction)btnCancelAction:(UIButton *)sender {
    [sender setAfterUserInteractionEnabled];
    [self hiddenView];
}

- (IBAction)btnDoneAction:(UIButton *)sender {
    [sender setAfterUserInteractionEnabled];
    [self hiddenView];
    
    NSDate *date = self.datePicker.date;
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormat stringFromDate:date];
    if([self.delegate respondsToSelector:@selector(TKDatePickerViewWith:date:dateStr:)]){
        [self.delegate TKDatePickerViewWith:self date:date dateStr:dateStr];
    }
    if (self.blockDate) {
        self.blockDate(date);
    }
    if (self.blockDateStr) {
        self.blockDateStr(dateStr);
    }
}

@end
