//
//  UITextField+Factory.m
//  ExampleProject
//
//  Created by PC on 2022/7/31.
//

#import "UITextField+Factory.h"
#import <objc/runtime.h>

@implementation UITextField (Factory)

/**
 严重警告：这儿通过交换函数解决了UITextfFeild文本位置的偏移量，但是这回严重影响到UISearchBar中的Textfeild输入框与搜索图标的位置。
 最好解决方式就是自定义UITextFeild然后在这个子类中处理偏移位置。
 */
+ (void)load
{

//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL sel = NSSelectorFromString(@"factorySwap");
//        if ([UITextField respondsToSelector:sel]) {
//            [UITextField performSelector:sel];
//        }
//    });
    
}

+ (void)factorySwap
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = self.class;
        [TKMethodSwap swizzleMethod:cls originSel:@selector(textRectForBounds:) swizzSel:@selector(factory_textRectForBounds:)];
        [TKMethodSwap swizzleMethod:cls originSel:@selector(editingRectForBounds:) swizzSel:@selector(factory_editingRectForBounds:)];
        [TKMethodSwap swizzleMethod:cls originSel:@selector(placeholderRectForBounds:) swizzSel:@selector(factory_placeholderRectForBounds:)];

        [TKMethodSwap swizzleMethod:cls originSel:@selector(leftViewRectForBounds:) swizzSel:@selector(factory_leftViewRectForBounds:)];
        [TKMethodSwap swizzleMethod:cls originSel:@selector(rightViewRectForBounds:) swizzSel:@selector(factory_rightViewRectForBounds:)];
    });
}


// 未编辑状态下的起始位置
- (CGRect)factory_textRectForBounds:(CGRect)bounds {
    CGRect newBounds = bounds;
    newBounds.origin.x += self.offsetText;
    newBounds.size.width -= self.offsetText;
    return [self factory_textRectForBounds:newBounds];
}

// 编辑状态下的起始位置
- (CGRect)factory_editingRectForBounds:(CGRect)bounds {
    CGRect newBounds = bounds;
    newBounds.origin.x += self.offsetText;
    newBounds.size.width -= self.offsetText;
    return [self factory_editingRectForBounds:newBounds];
}

// placeholder起始位置
- (CGRect)factory_placeholderRectForBounds:(CGRect)bounds {
    CGRect newBounds = bounds;
    newBounds.origin.x += self.offsetPlaceholder;
    newBounds.size.width -= self.offsetPlaceholder;
    return [self factory_placeholderRectForBounds:newBounds];
}

// leftView起始位置
- (CGRect)factory_leftViewRectForBounds:(CGRect)bounds
{
    CGRect newBounds = bounds;
    newBounds.origin.x += self.offsetLeftView;
//    newBounds.size.width -= self.offsetLeftView;
    return [self factory_leftViewRectForBounds:newBounds];
}

// rightView起始位置
- (CGRect)factory_rightViewRectForBounds:(CGRect)bounds
{
    CGRect newBounds = bounds;
    newBounds.origin.x += self.offsetRightView;
//    newBounds.size.width -= self.offsetRightView;
    return [self factory_rightViewRectForBounds:newBounds];
}



// MARK: - text与placeholder X轴上的偏移量
- (void)setOffsetText:(CGFloat)offsetText
{
    objc_setAssociatedObject(self, @selector(offsetText), @(offsetText), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)offsetText
{
    return [objc_getAssociatedObject(self, @selector(offsetText)) floatValue];
}

- (void)setOffsetPlaceholder:(CGFloat)offsetPlaceholder
{
    objc_setAssociatedObject(self, @selector(offsetPlaceholder), @(offsetPlaceholder), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)offsetPlaceholder
{
    return [objc_getAssociatedObject(self, @selector(offsetPlaceholder)) floatValue];
}

- (void)setOffsetLeftView:(CGFloat)offsetLeftView
{
    objc_setAssociatedObject(self, @selector(offsetLeftView), @(offsetLeftView), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)offsetLeftView
{
    return [objc_getAssociatedObject(self, @selector(offsetLeftView)) floatValue];
}

- (void)setOffsetRightView:(CGFloat)offsetRightView
{
    objc_setAssociatedObject(self, @selector(offsetRightView), @(offsetRightView), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)offsetRightView
{
    return [objc_getAssociatedObject(self, @selector(offsetRightView)) floatValue];
}

@end
