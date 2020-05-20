//
//  TKSearchBar.m
//  Orchid
//
//  Created by Mac on 2019/1/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKSearchBar.h"

@interface TKSearchBar ()<UITextFieldDelegate>


@end

@implementation TKSearchBar

- (void)instanceSubView
{
    self.xibChildViewColor = kColorWhite;
    self.showView.backgroundColor = kHEXColor(@"F2F2F2");
    [self.showView setLayerCornerRadiusWith:12.0];
    self.btnSearch.titleLabel.font = [UIFont systemFontOfSize:13.0];
    self.inputTextField.font = [UIFont systemFontOfSize:13.0];
    self.inputTextField.delegate = self;
    
    [self setSearchBarStyleWithType:0];
}

- (void)setText:(NSString *)text
{
    self.inputTextField.text = text;
}

- (NSString *)text
{
    return self.inputTextField.text;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    self.inputTextField.placeholder = placeholder;
}

- (NSString *)placeholder
{
    return self.inputTextField.placeholder;
}

#pragma mark 搜索按钮click
- (IBAction)btnSearchAction:(UIButton *)sender
{
    kHiddenKeyboard;
    if ([self.delegate respondsToSelector:@selector(TKSearchBarWith:clickBtn:)]) {
        [self.delegate TKSearchBarWith:self clickBtn:self.btnSearch];
    }else if ([self.delegate respondsToSelector:@selector(TKSearchBarWith:searchText:)]){
        [self.delegate TKSearchBarWith:self searchText:self.inputTextField.text];
    }
}

#pragma mark 键盘上的搜索按钮click
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    kHiddenKeyboard;
    if ([self.delegate respondsToSelector:@selector(TKSearchBarWith:searchText:)]) {
        [self.delegate TKSearchBarWith:self searchText:self.inputTextField.text];
    }
    return YES;
}
//textField删除按钮代理
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = nil;
    if ([self.delegate respondsToSelector:@selector(TKSearchBarDidClearWith:)]) {
        [self.delegate TKSearchBarDidClearWith:self];
    }
    return YES;
}


/**
 设置搜索按钮是否隐藏
 **/
- (void)setSearchButtonIsHidden:(BOOL)isHidden
{
    self.btnSearch.hidden = isHidden;
    if (isHidden) {//隐藏
        self.layShowViewRight.constant = 10;
    }else{//显示
        self.layShowViewRight.constant = 45;
    }
}

/**
 设置搜索框样式
 0:默认样式，搜索按钮显示，左边距10
 1:不显示搜索按钮，左右边距为0
 **/
- (void)setSearchBarStyleWithType:(NSInteger)type
{
    switch (type) {
        case 0:
        {
            [self setSearchButtonIsHidden:NO];
        }
            break;
        case 1:
        {
            self.btnSearch.hidden = YES;
            self.layShowViewLeft.constant = 0;
            self.layShowViewRight.constant= 0;
        }
            break;
    }
}



@end
