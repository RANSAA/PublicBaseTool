//
//  UISearchBar+Factory.m
//  ExampleProject
//
//  Created by PC on 2022/8/1.
//

#import "UISearchBar+Factory.h"

@implementation UISearchBar (Factory)

- (UITextField *)textField
{
    UITextField *textField = (UITextField *)[self subViewOfClassName:@"UISearchBarTextField"];
    return textField;
}

- (UIView *)backgroundView
{
    UIView* backgroundView = [self subViewOfClassName:@"_UISearchBarSearchFieldBackgroundView"];
    return  backgroundView;
}

@end
