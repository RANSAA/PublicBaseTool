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

@end
