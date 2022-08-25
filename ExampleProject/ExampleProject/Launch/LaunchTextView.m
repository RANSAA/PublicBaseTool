//
//  LaunchTextView.m
//  ExampleProject
//
//  Created by PC on 2022/8/11.
//

#import "LaunchTextView.h"

@implementation LaunchTextView


- (BOOL)canBecomeFirstResponder
{
    return NO;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self disabledLongGesture];
}


/**
 禁用长按手势
 */
- (void)disabledLongGesture
{
    for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
      if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]]){
        recognizer.enabled = NO;
      }
    }
}


// MARK: - UITextViewDelegate
// 点击富文本区域，长按不会弹出3d网页浏览页面
//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
//{
//    NSString *scheme = URL.scheme;
//    if ([scheme isEqualToString:@"lauch1"]) {
//        [self toUserAgreeAction];
//        return NO;
//    }else if ([scheme isEqualToString:@"lauch2"]){
//        [self toPrivateAction];
//        return NO;
//    }
//    return YES;
//}

@end
