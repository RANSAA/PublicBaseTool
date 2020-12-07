//
//  TKDatePickerView.m
//  Orchid
//
//  Created by Mac on 2019/2/23.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKDatePickerView.h"

@interface TKDatePickerView ()
@property (strong, nonatomic) IBOutlet UIView *spaceView;
@property (strong, nonatomic) IBOutlet UIView *showView;
@property (strong, nonatomic) IBOutlet UIView *toolView;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;

@end

@implementation TKDatePickerView

- (void)instanceSubView
{
    [self sendSubviewToBack:self.spaceView];
    
    [self.btnCancel setTitleColor:kColorTheme];
    [self.btnDone setTitleColor:kColorTheme];
}

- (void)show
{
    [self showWithView:appWin];
}

- (void)showWithView:(UIView *)view
{
    self.frame = Screen_Bounds;
    [view addSubview:self];
    [view.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
}

- (void)hiddenView
{
    [self.superview.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
    [self removeFromSuperview];
}

- (IBAction)btnCancelAction:(UIButton *)sender {
    [sender setViewUserInteractionEnabledCancel];
    [self hiddenView];
}

- (IBAction)btnDoneAction:(UIButton *)sender {
    [sender setViewUserInteractionEnabledCancel];
    [self hiddenView];
    if([self.delegate respondsToSelector:@selector(TKDatePickerViewWith:date:dateStr:)]){
        NSDate *date = self.datePicker.date;
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormat stringFromDate:date];
        [self.delegate TKDatePickerViewWith:self date:date dateStr:dateStr];
    }
}

@end
