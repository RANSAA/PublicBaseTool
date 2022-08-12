//
//  TKSimplePickerView.m
//  Orchid
//
//  Created by Mac on 2019/2/13.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKSimplePickerView.h"

@interface TKSimplePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic, assign) NSInteger selectedRow;//默认选中行数
@end

@implementation TKSimplePickerView

- (void)instanceSubView
{
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.selectedRow = 0;
        
    self.labTitle.text = nil;
    self.labTitle.font = [UIFont systemFontOfSize:16];
    
    UIColor *titleColor  = [UIColor colorWithLight:UIColor.blackColor dark:kRGBColor(188, 188, 192)];
    UIColor *backColor   = [UIColor colorWithLight:kRGBColor(68, 68, 70) dark:kRGBColor(188, 188, 192)];
    UIColor *toolColor = [UIColor colorWithLight:kRGBColor(245, 245, 245) dark:kRGBColor(58, 58, 60)];
    UIColor *pickerColor   = [UIColor colorWithLight:UIColor.whiteColor dark:kRGBColor(72, 72, 74)];
    self.pickerView.backgroundColor = pickerColor;
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
//    view.frame = Screen_Bounds;
    [view addSubview:self];
    [self addEdgeConstraintsToView:view];
    [view.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
}

- (void)hiddenView
{
    [self.superview.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
    [self removeFromSuperview];

//    [UIView animateWithDuration:0.3 animations:^{
//        self.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
}

- (IBAction)btnCancelAction:(UIButton *)sender {
    [sender setAfterUserInteractionEnabled];
    [self hiddenView];
}

- (IBAction)btnDoneAction:(UIButton *)sender {
    [sender setAfterUserInteractionEnabled];
    [self hiddenView];
    if (self.selectedRow != -1 && self.selectedRow < self.dataAry.count) {
        NSString *title = self.dataAry[self.selectedRow];
        if ([self.delegate respondsToSelector:@selector(TKSimplePickerView:didAtRow:)]) {
            [self.delegate TKSimplePickerView:self didAtRow:self.selectedRow];
        }
        if ([self.delegate respondsToSelector:@selector(TKSimplePickerView:didAtRow:title:)]) {
            [self.delegate TKSimplePickerView:self didAtRow:self.selectedRow title:title];
        }
        
        if (self.blockRow) {
            self.blockRow(@(self.selectedRow));
        }
        if (self.blockTitle) {
            self.blockTitle(title);
        }
    }
}

- (void)setDataAry:(NSArray *)dataAry
{
    _dataAry = dataAry;
    [self.pickerView reloadAllComponents];
}

- (void)setDefaultIndex:(NSInteger)defaultIndex
{
    if (defaultIndex >= 0) {
        _defaultIndex = defaultIndex;
    }
}

//默认选中row
- (void)showDefaultRow
{
    if (self.superview) {
        if (_defaultIndex>0 && _defaultIndex < _dataAry.count) {
            _selectedRow = _defaultIndex;
            [self.pickerView selectRow:_selectedRow inComponent:0 animated:NO];
        }
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self showDefaultRow];
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
    return kScreenWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
//    return 145/3;
    return 158/4.5;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *labTitle = (UILabel *)view;
    if (!labTitle) {
        labTitle = [[UILabel alloc] init];
        labTitle.textAlignment = NSTextAlignmentCenter;
        labTitle.font = [UIFont systemFontOfSize:15];
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
