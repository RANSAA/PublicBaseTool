//
//  TKSimplePickerView.m
//  Orchid
//
//  Created by Mac on 2019/2/13.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKSimplePickerView.h"

@interface TKSimplePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *labTitle;
@property(nonatomic, assign) NSInteger selectedRow;
@end

@implementation TKSimplePickerView

- (void)instanceSubView
{
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.selectedRow = 0;

    self.labTitle.text = nil;
    self.labTitle.font = [UIFont systemFontOfSize:14];
    [self.btnDone setTitleColor:kColorTheme];
    [self.btnCancel setTitleColor:kColorTheme];
}

- (void)show
{
    [self showWithView:appWin];
}

- (void)showWithView:(UIView *)view
{
    self.labTitle.text = self.title;
    self.frame = Screen_Bounds;
    [view addSubview:self];
    [view.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
}

- (void)hiddenView
{
//    [self.superview.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
//    [self removeFromSuperview];

    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)btnCancelAction:(UIButton *)sender {
    [sender setViewUserInteractionEnabledCancel];
    [self hiddenView];
}

- (IBAction)btnDoneAction:(UIButton *)sender {
    [sender setViewUserInteractionEnabledCancel];
    [self hiddenView];
    if (self.selectedRow != -1) {
        NSString *title = self.dataAry[self.selectedRow];
        if ([self.delegate respondsToSelector:@selector(TKSimplePickerView:didAtRow:)]) {
            [self.delegate TKSimplePickerView:self didAtRow:self.selectedRow];
        }
        if ([self.delegate respondsToSelector:@selector(TKSimplePickerView:didAtRow:title:)]) {
            [self.delegate TKSimplePickerView:self didAtRow:self.selectedRow title:title];
        }
    }
}

- (void)setDataAry:(NSArray *)dataAry
{
    _dataAry = dataAry;
    [self.pickerView reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataAry.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return Screen_Width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 145/3.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *labTitle = (UILabel *)view;
    if (!labTitle) {
        labTitle = [[UILabel alloc] init];
        labTitle.textAlignment = NSTextAlignmentCenter;
        labTitle.font = [UIFont systemFontOfSize:16];
    }
    if (self.fontSize>0) {
        labTitle.font = [UIFont systemFontOfSize:self.fontSize];
    }
    labTitle.text = self.dataAry[row];
    return labTitle;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataAry[row];
}

//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *title = self.dataAry[row];
//    NSAttributedString *atr = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:kHEXColor(@"#AAAAAA"),
//                                                                                            NSFontAttributeName:[UIFont systemFontOfSize:22]
//                                                                                            }];
//    return atr;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedRow = row;
    [pickerView reloadAllComponents];
}




@end
