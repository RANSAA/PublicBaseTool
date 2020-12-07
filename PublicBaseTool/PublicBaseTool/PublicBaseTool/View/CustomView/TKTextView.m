//
//  TKTextView.m
//  AdultLP
//
//  Created by mac on 2019/7/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKTextView.h"

@interface TKTextView ()
@property(nonatomic, copy  ) NSString *tmpText;//用于缓存UITextView的属性
@property(nonatomic, strong) UIColor  *tmpTextColor;
@property(nonatomic, strong) UIFont   *tmpFont;
@end

@implementation TKTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)init
{
    if (self = [super init]) {
        [self addPlaceholder];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addPlaceholder];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
        [self addPlaceholder];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self addPlaceholder];
    }
    return self;
}

/**
 初始化占位提示文字相关操作
 **/
- (void)addPlaceholder
{
    self.tmpText = self.text;
    self.tmpTextColor = self.textColor;
    self.tmpFont = self.font;
    
    _placeholderColor = kHEXColor(@"#B3B3B3");
    _placeholderFont  = [UIFont systemFontOfSize:14.0];
    _placeholder = nil;

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(textBeginEditAction) name:UITextViewTextDidBeginEditingNotification object:self];
    [center addObserver:self selector:@selector(textEndEditAction) name:UITextViewTextDidEndEditingNotification object:self];
    [center addObserver:self selector:@selector(textChangeEditAction) name:UITextViewTextDidChangeNotification object:self];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *)textInput
{
    return self.tmpText;
}

- (void)setText:(NSString *)text
{
//        self.tmpText = text;
//        [self refreshText];
    if (text) {
        self.tmpText = text;
        [self refreshText];
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    self.tmpTextColor = textColor;
    [self refreshText];
}

- (void)setFont:(UIFont *)font
{
    self.tmpFont = font;
    [self refreshText];
}

/**
 设置
 **/
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self refreshPlaceholder];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self refreshPlaceholder];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    [self refreshPlaceholder];
}

/** 刷新Placeholder */
- (void)refreshPlaceholder
{
    if (_tmpText.length<1) {
        [super setText:_placeholder];
        [super setTextColor:_placeholderColor];
        [super setFont:_placeholderFont];
    }
}

/** 刷新text  */
- (void)refreshText
{
    [super setText:_tmpText];
    [super setTextColor:_tmpTextColor];
    [super setFont:_tmpFont];
}

- (void)textBeginEditAction
{
    [self refreshText];
}

- (void)textEndEditAction
{
    if (_tmpText.length<1) {
        [self refreshPlaceholder];
    }
}

- (void)textChangeEditAction
{
    _tmpText = self.text;
}


@end
