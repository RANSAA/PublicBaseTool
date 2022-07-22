//
//  TKFontManager.m
//  TKFontManager
//
//  Created by PC on 2022/7/22.
//

#import "TKFontManager.h"
#import <CoreText/CoreText.h>
#import <objc/runtime.h>


NSString * kNotificationNameFontChangeKey = @"kNotificationNameFontChangeKey";


@implementation TKFontManager{
    NSString * _customFontName;
    BOOL _isApply;
}

+ (instancetype)shared
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self.class alloc] init];
    });
    return obj;
}


/**
 动态加载，注册字体文件
 */
- (void)dynamicLoadFontData:(NSData *)fontData
{
    if (!fontData){
        NSLog(@"动态加载的字体文件不存在");
        return;
    }

     CFErrorRef error;
     CGDataProviderRef providerRef = CGDataProviderCreateWithCFData((CFDataRef)fontData);
     CGFontRef font = CGFontCreateWithDataProvider(providerRef);
     if (! CTFontManagerRegisterGraphicsFont(font, &error))
     {
         //如果注册失败，则不使用
         CFStringRef errorDescription = CFErrorCopyDescription(error);
         NSLog(@"无法加载字体文件: %@", errorDescription);
         CFRelease(errorDescription);
     }else{
         NSLog(@"动态字体文件加载成功");
     }
     CFRelease(font);
     CFRelease(providerRef);
}


/**
 familyName列表
 */
- (void)familyName
{
    for (NSString *familyName in [UIFont familyNames]) {
        NSLog(@"familyName = %@",familyName);
    }
}

/**
 系统字体列表
 */
- (void)fontNames
{
    for (NSString *familyName in [UIFont familyNames]) {
        NSLog(@"familyName = %@",familyName);
        NSLog(@"fontName:");
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"         %@",fontName);
        }
        NSLog(@"-----------------------");
    }
}


/**
 检查字体是否存在
 */
- (BOOL)isExistFontName:(NSString *)fontName
{
    if ([UIFont fontWithName:fontName size:12]) {
        return YES;
    }
    return NO;
}


/**
 设置自定义字体
 fontName：字体名称
 isApply：是否生效
 */
- (void)setFontName:(NSString *)fontName isApply:(BOOL)isApply
{
    _customFontName = fontName;
    _isApply = isApply;
    [NSNotificationCenter.defaultCenter postNotificationName:kNotificationNameFontChangeKey object:nil];
}

/**
 字体生成工厂
 */
- (UIFont *)fontFactoryOfSize:(CGFloat)size
{
    if (_isApply) {
        UIFont *font = [UIFont fontWithName:_customFontName size:size];
        if (!font) {
            NSLog(@"字体: %@ 不存在，使用系统默认字体", _customFontName);
            font = [UIFont systemFontOfSize:size];
        }
        return font;
    }else{
        return [UIFont systemFontOfSize:size];
    }
}

/**
 当前使用的字体类型名称
 */
- (NSString *)currentFontName
{
    NSString *fontName;
    if (_isApply) {
        fontName = _customFontName;
    }else{
        static NSString *systemFontName = nil;
        if (systemFontName != nil) {
            UIFont *font = [UIFont systemFontOfSize:12];
            systemFontName = font.fontName;
        }
        fontName = systemFontName;
    }
    return  fontName;
}

/**
 是否使用了自定义字体
 */
- (BOOL)isCustomFont
{
    return _isApply;
}



# pragma mark 快捷字体设置
- (UIFont *)font4
{
    return [self fontFactoryOfSize:4];
}

- (UIFont *)font5
{
    return [self fontFactoryOfSize:5];
}

- (UIFont *)font6
{
    return [self fontFactoryOfSize:6];
}

- (UIFont *)font7
{
    return [self fontFactoryOfSize:7];
}

- (UIFont *)font8
{
    return [self fontFactoryOfSize:8];
}

- (UIFont *)font9
{
    return [self fontFactoryOfSize:9];
}

- (UIFont *)font10
{
    return [self fontFactoryOfSize:10];
}

- (UIFont *)font11
{
    return [self fontFactoryOfSize:11];
}

- (UIFont *)font12
{
    return [self fontFactoryOfSize:12];
}

- (UIFont *)font13
{
    return [self fontFactoryOfSize:13];
}

- (UIFont *)font14
{
    return [self fontFactoryOfSize:14];
}

- (UIFont *)font15
{
    return [self fontFactoryOfSize:15];
}

- (UIFont *)font16
{
    return [self fontFactoryOfSize:16];
}

- (UIFont *)font17
{
    return [self fontFactoryOfSize:17];
}

- (UIFont *)font18
{
    return [self fontFactoryOfSize:18];
}

- (UIFont *)font19
{
    return [self fontFactoryOfSize:19];
}

- (UIFont *)font20
{
    return [self fontFactoryOfSize:20];
}

- (UIFont *)font21
{
    return [self fontFactoryOfSize:21];
}

- (UIFont *)font22
{
    return [self fontFactoryOfSize:22];
}

- (UIFont *)font23
{
    return [self fontFactoryOfSize:23];
}

- (UIFont *)font24
{
    return [self fontFactoryOfSize:24];
}

- (UIFont *)font25
{
    return [self fontFactoryOfSize:25];
}

- (UIFont *)font26
{
    return [self fontFactoryOfSize:26];
}

@end


@implementation TKFontManager (RefreshFont)


/**
 修改字体后自动刷新所有页面控件字体显示
 */
+ (void)autoRefreshFont
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UILabel swapMethod];
        [UITextField swapMethod];
        [UITextView swapMethod];
    });
}

/** 交换对象中的方法*/
+ (BOOL)exchangeMethodWithClass:(Class)class original:(SEL)originSel swizzled:(SEL)swizzledSel
{
    Method originaMethod = class_getInstanceMethod(class, originSel);
    Method swizzleMethod = class_getInstanceMethod(class, swizzledSel);
    if (!originaMethod || !swizzleMethod) {
        return NO;
    }

//方式1：
    class_addMethod(class,
                    originSel,
                    class_getMethodImplementation(class, originSel),
                    method_getTypeEncoding(originaMethod));
    class_addMethod(class,
                    swizzledSel,
                    class_getMethodImplementation(class, swizzledSel),
                    method_getTypeEncoding(swizzleMethod));
    method_exchangeImplementations(class_getInstanceMethod(class, originSel),
                                   class_getInstanceMethod(class, swizzledSel));

    return YES;
}

@end

#pragma mark UILable扩展
@implementation UILabel (RefreshFont)

+ (void)swapMethod
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //obj class:    object_getClass((id)self)
        //class: self.class
        //Class cls0 = objc_getClass("__NSPlaceholderArray");

        Class labelCls = self.class;
        [TKFontManager exchangeMethodWithClass:labelCls original:@selector(didMoveToSuperview) swizzled:@selector(tk_didMoveToSuperview)];
        [TKFontManager exchangeMethodWithClass:labelCls original:@selector(removeFromSuperview) swizzled:@selector(tk_removeFromSuperview)];
        [TKFontManager exchangeMethodWithClass:labelCls original:@selector(setAttributedText:) swizzled:@selector(tk_setAttributedText:)];
    });
}

- (void)tk_didMoveToSuperview
{
    [self tk_didMoveToSuperview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontNotification:) name:kNotificationNameFontChangeKey object:nil];
}

- (void)tk_removeFromSuperview{
    [self tk_removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNameFontChangeKey object:nil];
}

- (void)tk_setAttributedText:(NSAttributedString *)attributedText
{
    [self tk_setAttributedText:attributedText];
    self.isSetAttributedText = attributedText != nil;
}

//isSetAttributedText
-(void)setIsSetAttributedText:(BOOL)isSetAttributedText
{
    objc_setAssociatedObject(self, @selector(isSetAttributedText), @(isSetAttributedText), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)isSetAttributedText
{
    return [objc_getAssociatedObject(self, @selector(isSetAttributedText)) boolValue];
}

// 通过老font 获取新font
-(UIFont *)getNewFontWithOld:(UIFont *)font{
    UIFont *newFont = nil;
    if (TKFontManager.shared.isCustomFont) {
        newFont = [UIFont fontWithName:TKFontManager.shared.currentFontName size:font.pointSize];
        if (!newFont) {
            NSLog(@"字体: %@ 不存在，使用系统默认字体", TKFontManager.shared.currentFontName);
            newFont = [UIFont systemFontOfSize:font.pointSize];
        }
    }else{
        newFont = [UIFont systemFontOfSize:font.pointSize];
    }
    return newFont;
}

- (void)changeFontNotification:(NSNotification *)noti
{
    if (self.isSetAttributedText) {
        NSRange range1 = NSMakeRange(0, self.attributedText.string.length);
        NSMutableAttributedString *mutString = [self.attributedText mutableCopy];
        [mutString enumerateAttribute:NSFontAttributeName
                              inRange:range1
                              options:(NSAttributedStringEnumerationReverse) usingBlock:^(UIFont *value, NSRange range, BOOL * _Nonnull stop){
                                  if (value) {
                                      *stop = YES;
                                      [mutString addAttribute:NSFontAttributeName value:[self getNewFontWithOld:value] range:range];

                                  }else{
                                      [mutString addAttribute:NSFontAttributeName value:[self getNewFontWithOld:self.font] range:range];
                                  }
                              }];
        self.attributedText = mutString;
    }else{
        self.font = [self getNewFontWithOld:self.font];
    }
}

@end


#pragma mark UITextField扩展
@implementation UITextField (RefreshFont)

+ (void)swapMethod
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //obj class:    object_getClass((id)self)
        //class: self.class
        //Class cls0 = objc_getClass("__NSPlaceholderArray");

        Class labelCls = self.class;
        [TKFontManager exchangeMethodWithClass:labelCls original:@selector(didMoveToSuperview) swizzled:@selector(tk_didMoveToSuperview)];
        [TKFontManager exchangeMethodWithClass:labelCls original:@selector(removeFromSuperview) swizzled:@selector(tk_removeFromSuperview)];
        [TKFontManager exchangeMethodWithClass:labelCls original:@selector(setAttributedText:) swizzled:@selector(tk_setAttributedText:)];
    });
}

- (void)tk_didMoveToSuperview
{
    [self tk_didMoveToSuperview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontNotification:) name:kNotificationNameFontChangeKey object:nil];
}

- (void)tk_removeFromSuperview{
    [self tk_removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNameFontChangeKey object:nil];
}

- (void)tk_setAttributedText:(NSAttributedString *)attributedText
{
    [self tk_setAttributedText:attributedText];
    self.isSetAttributedText = attributedText != nil;
}

// isSetAttributedText
-(void)setIsSetAttributedText:(BOOL)isSetAttributedText
{
    objc_setAssociatedObject(self, @selector(isSetAttributedText), @(isSetAttributedText), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)isSetAttributedText
{
    return [objc_getAssociatedObject(self, @selector(isSetAttributedText)) boolValue];
}

// 通过老font 获取新font
-(UIFont *)getNewFontWithOld:(UIFont *)font{
    UIFont *newFont = nil;
    if (TKFontManager.shared.isCustomFont) {
        newFont = [UIFont fontWithName:TKFontManager.shared.currentFontName size:font.pointSize];
    }else{
        newFont = [UIFont systemFontOfSize:font.pointSize];
    }
    return newFont;
}

- (void)changeFontNotification:(NSNotification *)noti
{
    if (self.isSetAttributedText) {
//        NSRange range1 = NSMakeRange(0, self.attributedText.string.length);
//        NSMutableAttributedString *mutString = [self.attributedText mutableCopy];
//        [mutString enumerateAttribute:NSFontAttributeName
//                              inRange:range1
//                              options:(NSAttributedStringEnumerationReverse) usingBlock:^(UIFont *value, NSRange range, BOOL * _Nonnull stop){
//                                  if (value) {
//                                      *stop = YES;
//                                      [mutString addAttribute:NSFontAttributeName value:[self getNewFontWithOld:value] range:range];
//
//                                  }else{
//                                      [mutString addAttribute:NSFontAttributeName value:[self getNewFontWithOld:self.font] range:range];
//                                  }
//                              }];
//        self.attributedText = mutString;
    }else{
        self.font = [self getNewFontWithOld:self.font];
    }
}

@end



#pragma mark UITextView扩展
@implementation UITextView (RefreshFont)

+ (void)swapMethod
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //obj class:    object_getClass((id)self)
        //class: self.class
        //Class cls0 = objc_getClass("__NSPlaceholderArray");

        Class labelCls = self.class;
        [TKFontManager exchangeMethodWithClass:labelCls original:@selector(didMoveToSuperview) swizzled:@selector(tk_didMoveToSuperview)];
        [TKFontManager exchangeMethodWithClass:labelCls original:@selector(removeFromSuperview) swizzled:@selector(tk_removeFromSuperview)];
        [TKFontManager exchangeMethodWithClass:labelCls original:@selector(setAttributedText:) swizzled:@selector(tk_setAttributedText:)];
    });
}

- (void)tk_didMoveToSuperview
{
    [self tk_didMoveToSuperview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontNotification:) name:kNotificationNameFontChangeKey object:nil];
}

- (void)tk_removeFromSuperview{
    [self tk_removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNameFontChangeKey object:nil];
}

- (void)tk_setAttributedText:(NSAttributedString *)attributedText
{
    [self tk_setAttributedText:attributedText];
    self.isSetAttributedText = attributedText != nil;
}

// isSetAttributedText
-(void)setIsSetAttributedText:(BOOL)isSetAttributedText
{
    objc_setAssociatedObject(self, @selector(isSetAttributedText), @(isSetAttributedText), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)isSetAttributedText
{
    return [objc_getAssociatedObject(self, @selector(isSetAttributedText)) boolValue];
}

// 通过老font 获取新font
-(UIFont *)getNewFontWithOld:(UIFont *)font{
    UIFont *newFont = nil;
    if (TKFontManager.shared.isCustomFont) {
        newFont = [UIFont fontWithName:TKFontManager.shared.currentFontName size:font.pointSize];
    }else{
        newFont = [UIFont systemFontOfSize:font.pointSize];
    }
    return newFont;
}

- (void)changeFontNotification:(NSNotification *)noti
{
    if (self.isSetAttributedText) {
//        NSRange range1 = NSMakeRange(0, self.attributedText.string.length);
//        NSMutableAttributedString *mutString = [self.attributedText mutableCopy];
//        [mutString enumerateAttribute:NSFontAttributeName
//                              inRange:range1
//                              options:(NSAttributedStringEnumerationReverse) usingBlock:^(UIFont *value, NSRange range, BOOL * _Nonnull stop){
//                                  if (value) {
//                                      *stop = YES;
//                                      [mutString addAttribute:NSFontAttributeName value:[self getNewFontWithOld:value] range:range];
//
//                                  }else{
//                                      [mutString addAttribute:NSFontAttributeName value:[self getNewFontWithOld:self.font] range:range];
//                                  }
//                              }];
//        self.attributedText = mutString;
    }else{
        self.font = [self getNewFontWithOld:self.font];
    }
}

@end

