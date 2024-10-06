//
//  LaunchTextView.m
//  ExampleProject
//
//  Created by PC on 2022/8/11.
//

#import "LaunchTextView.h"

@interface LaunchTextView () <UITextViewDelegate>
@property(nonatomic, strong) NSMutableSet *links;
@end

@implementation LaunchTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return  self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
        [self config];
    }
    return self;
}


- (void)config{
    self.links = [[NSMutableSet alloc] init];
    self.editable = NO;
    self.delegate = self;
    [self disabledLongGesture];
}

/**
 添加NSLinkAttributeName协议链接
 */
- (void)addLinkAttributeName:(NSURL *)url
{
    [self.links addObject:url];
}

/**
 添加NSLinkAttributeName协议链接
 */
- (void)addLinkAttributeNames:(NSArray <NSURL *> *)urls
{
    [self.links addObjectsFromArray:urls];
}


// MARK: - 处理长按不出现菜单
- (BOOL)canBecomeFirstResponder
{
    return NO;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
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
    if (@available(iOS 13.0,*)) {
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
          if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]]){
            recognizer.enabled = NO;
          }
        }
    }
}



// MARK: - 点击富文本区域，长按不会弹出3d网页浏览页面
//UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    NSLog(@"shouldInteractWithURL URL:%@",URL);

    if (self.clickLinkCompletion) {
        self.clickLinkCompletion(URL);
    }

    if (self.clickLinkAttrCompletion) {
        if ([self.links containsObject:URL]) {
            self.clickLinkAttrCompletion(URL);
            return NO;
        }
    }

    return YES;
}

@end
