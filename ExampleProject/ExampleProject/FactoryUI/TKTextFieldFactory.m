//
//  TKTextFieldFactory.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "TKTextFieldFactory.h"


#define kUITextField UITextFieldCustom
//#define kUITextField UITextField


@implementation TKTextFieldFactory

+ (kUITextField *)factoryObj
{
    return [[kUITextField alloc] init];
}

+ (UITextField *)defaultStyle
{
    UITextField *textfield = self.factoryObj;
    [self setDefaultStyleWith:textfield];
    return textfield;
}

+ (void)setDefaultStyleWith:(UITextField *)textField
{
    textField.font = kFont15;
    textField.textColor = kColorTextField;
    textField.layer.cornerRadius = 17;
    textField.layer.borderWidth = 0.5;
    textField.layer.borderColor = [[TKColorManager systemGray] CGColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [TKColorManager systemOrange];
    textField.offsetText = 12;
    textField.borderStyle = UITextBorderStyleNone;
}

/** 左边带标题的输入框  */
+ (UITextField *)titleInput
{
    UITextField *textfield = self.factoryObj;
    [self setTitleInput:textfield];
    return textfield;
}

+ (void)setTitleInput:(UITextField *)textField
{
    textField.font = kFont15;
    textField.textColor = kColorTextField;
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 16;
    textField.layer.borderWidth = 0.5;
    textField.layer.borderColor = [[TKColorManager systemGray] CGColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.offsetText = 0;

    CGRect leftFrame = CGRectMake(0, 0, 34, 40);
    UILabel *lable = [[UILabel alloc] initWithFrame:leftFrame];
    lable.text = @"left";
    lable.textColor = kColorWhite;
    lable.textAlignment = NSTextAlignmentCenter;

    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    imgView.frame = leftFrame;
    imgView.contentMode = UIViewContentModeCenter;


    UIView *leftView = [[UIView alloc] initWithFrame:leftFrame];
    leftView.backgroundColor = [TKColorManager systemOrange];
    [leftView addSubview:lable];
    [leftView addSubview:imgView];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;

    UILabel *right = [[UILabel alloc] initWithFrame:leftFrame];
    right.text = @"right";
    right.textColor = kColorWhite;
    right.textAlignment = NSTextAlignmentCenter;
    UIView *rightView = [[UIView alloc] initWithFrame:leftFrame];
    rightView.backgroundColor = [TKColorManager systemOrange];
    [rightView addSubview:right];
}


+ (UITextField *)searchBarStyle
{
    UITextField *textfield = self.factoryObj;
    [self setSearchBarStyleWith:textfield];
    return textfield;
}

+ (void)setSearchBarStyleWith:(UITextField *)textField
{
    textField.font = kFont14;
    textField.textColor = kColorTextField;
    textField.clipsToBounds = YES;
    textField.layer.borderWidth = 0.5;
    textField.layer.borderColor = [[TKColorManager systemOrange] CGColor];
    textField.borderStyle = UITextBorderStyleNone;
    if (@available(iOS 11.0, *)) {
        textField.layer.cornerRadius = 18;
    }else{
        textField.layer.cornerRadius = 12;
    }

    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索家居美图、商品、专贴和讨论帖" attributes:@{
        NSFontAttributeName:kFont14,
        NSForegroundColorAttributeName:TKColorManager.systemGray3
    }];
    textField.backgroundColor = TKColorManager.systemGray6;
}

@end
