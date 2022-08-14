//
//  UITextFieldCustom.m
//  ExampleProject
//
//  Created by PC on 2022/8/1.
//

#import "UITextFieldCustom.h"

@implementation UITextFieldCustom

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// 未编辑状态下的起始位置
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect newBounds = bounds;
    newBounds.origin.x += self.offsetText;
    newBounds.size.width -= self.offsetText;
    return [super textRectForBounds:newBounds];
}

// 编辑状态下的起始位置
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect newBounds = bounds;
    newBounds.origin.x += self.offsetText;
    newBounds.size.width -= self.offsetText;
    return [super editingRectForBounds:newBounds];
}

// placeholder起始位置
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect newBounds = bounds;
    newBounds.origin.x += self.offsetPlaceholder;
    newBounds.size.width -= self.offsetPlaceholder;
    return [super placeholderRectForBounds:newBounds];
}

// leftView起始位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect newBounds = bounds;
    newBounds.origin.x += self.offsetLeftView;
//    newBounds.size.width -= self.offsetLeftView;
    return [super leftViewRectForBounds:newBounds];
}

// rightView起始位置
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGRect newBounds = bounds;
    newBounds.origin.x += self.offsetRightView;
//    newBounds.size.width -= self.offsetRightView;
    return [super rightViewRectForBounds:newBounds];
}




@end
