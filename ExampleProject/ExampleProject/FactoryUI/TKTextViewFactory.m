//
//  TKTextViewFactory.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "TKTextViewFactory.h"

@implementation TKTextViewFactory

+ (UITextView *)defaultStyle
{
    UITextView *textView = [[UITextView alloc] init];
    [self setDefaultStyleWith:textView];
    return textView;
}

+ (void)setDefaultStyleWith:(UITextView *)textView
{
    textView.font = kFont15;
    textView.textColor = kColorTextView;
}
@end
