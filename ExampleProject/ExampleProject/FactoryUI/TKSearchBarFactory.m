//
//  TKSearchBarFactory.m
//  ExampleProject
//
//  Created by PC on 2022/7/31.
//

#import "TKSearchBarFactory.h"

@implementation TKSearchBarFactory

+ (UISearchBar *)defaultStyle
{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    [self setDefaultStyleWith:searchBar];
    return searchBar;;
}

+ (void)setDefaultStyleWith:(UISearchBar *)searchBar
{
    searchBar.tintColor = TKColorManage.systemRed;
    searchBar.barTintColor = TKColorManage.systemYellow;

    UITextField *textfield = [self textFieldWith:searchBar];
    if (@available(iOS 11.0, *)) {
        [TKTextFieldFactory setSearchBarStyleWith:textfield];
        [TKTextFieldFactory setSearchBarStyleWith:textfield];
        textfield.backgroundColor = TKColorManage.systemGray6;
    }else{
        UIView* backgroundView = [self textFieldBackgroundViewWith:searchBar];
        backgroundView.layer.cornerRadius = 12.0f;
        backgroundView.clipsToBounds = YES;
        textfield.backgroundColor = TKColorManage.systemGray6;
    }
    searchBar.textField.font = kFont14;
    textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索家居美图、商品、专贴和讨论帖" attributes:@{
        NSFontAttributeName:kFont14,
        NSForegroundColorAttributeName:TKColorManage.systemGray3
    }];


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"defalus:%@",searchBar.subViewsMark);
    });
}

+ (UISearchBar *)defaultStyle2
{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    [self setDefaultStyle2With:searchBar];
    return searchBar;;
}

+ (void)setDefaultStyle2With:(UISearchBar *)searchBar
{
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.tintColor = TKColorManage.systemYellow;
    searchBar.placeholder = @"搜索家居美图、商品、专贴和讨论帖";

    UITextField *textfield = [self textFieldWith:searchBar];
    if (@available(iOS 11.0, *)) {
        [TKTextFieldFactory setSearchBarStyleWith:textfield];
        [TKTextFieldFactory setSearchBarStyleWith:textfield];
        textfield.backgroundColor = TKColorManage.systemGray6;
    }else{
        UIView* backgroundView = [self textFieldBackgroundViewWith:searchBar];
        backgroundView.layer.cornerRadius = 12.0f;
        backgroundView.clipsToBounds = YES;
    //    //UISearchBarStyleMinimal模式下背景颜色修改
//        backgroundView.backgroundColor = TKColorManage.systemGray6;

        textfield.clipsToBounds = YES;
        textfield.layer.borderWidth = 0.5;
        textfield.layer.borderColor = [[TKColorManage systemOrange] CGColor];
        textfield.borderStyle = UITextBorderStyleNone;
        textfield.layer.cornerRadius = 12.0f;
        textfield.backgroundColor = TKColorManage.systemGray6;
    }
    textfield.font =kFont14;
}




/**
 设置UISearchBar右边取消按钮样式与是否显示。
 注意:一般需要在UISearchBar的代理中动态修改样式
 */
+ (void)setCancelButtonStyleWith:(UISearchBar *)searchBar show:(BOOL)isShow
{
    if (isShow != searchBar.showsCancelButton) {
        [searchBar setShowsCancelButton:isShow animated:YES];
        if (isShow) {
            UIButton *btnCancel = (UIButton *)[searchBar subViewOfClassName:@"UINavigationButton"];
            btnCancel.titleLabel.font = kFont15;
            btnCancel.titleLabel.text = @"取消";
            [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
            [btnCancel setTitleColor:UIColor.greenColor forState:UIControlStateNormal];
        }
    }
}

/**
 获取textField的背景图片
 */
+ (UIView *)textFieldBackgroundViewWith:(UISearchBar *)searchBar
{
    UIView* backgroundView = [searchBar subViewOfClassName:@"_UISearchBarSearchFieldBackgroundView"];
    return  backgroundView;
}

/**
 获取textField
 */
+ (UITextField *)textFieldWith:(UISearchBar *)searchBar
{
    UITextField *textfield = (UITextField *)[searchBar subViewOfClassName:@"UISearchBarTextField"];
    return  textfield;
}

@end
