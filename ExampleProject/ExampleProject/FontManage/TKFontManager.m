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

#pragma mark - 字体管理及其相关设置
@implementation TKFontManager{
    NSString * _customFontName;
    BOOL _isApply;
}

+ (instancetype)shared
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        obj = [[self.class alloc] init];
        obj = [super allocWithZone:NULL];
        [obj restoreFontManageConfig];
    });
    return obj;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return self.shared;
}



/**
 动态加载字体文件
 fontData:字体文件data数据
 fontName:字体真实名称
 PS:必须在使用自定义字体之前加载
 */
- (void)dynamicLoadFontData:(NSData *)fontData checkFontName:(nullable NSString *)fontName
{
    if (fontData) {
        if ([TKFontManager.shared isExistFontName:fontName]) {
            NSLog(@"字体：%@ 已加载，不需要重复加载！",fontName);
            return;
        }
        CFErrorRef error;
        CGDataProviderRef providerRef = CGDataProviderCreateWithCFData((CFDataRef)fontData);
        CGFontRef font = CGFontCreateWithDataProvider(providerRef);
        if (!CTFontManagerRegisterGraphicsFont(font, &error))
        {
            //如果注册失败，则不使用
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"无法加载字体文件: %@", errorDescription);
            CFRelease(errorDescription);
        }else{
            NSLog(@"动态字体文件加载成功!");
            NSString *loadFontName = (__bridge NSString *)CGFontCopyFullName(font);
            NSLog(@"动态字体文件的字体名：%@",loadFontName);
        }
        CFRelease(font);
        CFRelease(providerRef);
    }else{
        NSLog(@"字体文件不存在，fontData:%@",fontData);
    }
}



/**
 动态加载字体文件
 fontPath:字体文件的路径
 fontName:字体真实名称
 PS:必须在使用自定义字体之前加载
 */
- (void)dynamicLoadFontPath:(NSString *)fontPath checkFontName:(nullable NSString *)fontName
{
    if ([NSFileManager.defaultManager fileExistsAtPath:fontPath]) {
        if ([TKFontManager.shared isExistFontName:fontName]) {
            NSLog(@"字体：%@ 已加载，不需要重复加载！",fontName);
            return;
        }
        CFErrorRef error;
        CGDataProviderRef providerRef = CGDataProviderCreateWithFilename([fontPath UTF8String]);
        CGFontRef font = CGFontCreateWithDataProvider(providerRef);
        if (!CTFontManagerRegisterGraphicsFont(font, &error))
        {
            //如果注册失败，则不使用
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"无法加载字体文件: %@", errorDescription);
            CFRelease(errorDescription);
            CFRelease(error);
        }else{
            NSLog(@"动态字体文件加载成功!");
            CFStringRef cfstr = CGFontCopyFullName(font);
            NSString *loadFontName = (__bridge NSString *)cfstr;
            NSLog(@"动态字体文件的字体名：%@",loadFontName);
            CFRelease(cfstr);
        }
        CFRelease(font);
        CFRelease(providerRef);
    }else{
        NSLog(@"字体文件不存在，path:%@",fontPath);
    }
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
//    NSLog(@"fontName:%@",fontName);

//    if ([UIFont fontWithName:fontName size:12]) {
//        return YES;
//    }
//    return NO;

    UIFont *aFont = [UIFont fontWithName:fontName size:12];
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame ||
                  [aFont.familyName compare:fontName] == NSOrderedSame)) {
        return YES;
    }
    return NO;
}


/**
 设置自定义字体
 fontName：字体名称
 isApply：是否生效，NO直接使用系统默认字体
 */
- (void)setFontName:(NSString *)fontName isApply:(BOOL)isApply
{
    _customFontName = fontName;
    _isApply = isApply;
    [self saveFontManageConfig];
    [self postFontNotification];
}

/**
 字体生成工厂
 */
- (UIFont *)fontFactoryOfSize:(CGFloat)size
{
    if (_isApply) {
        UIFont *font = nil;
        if (_isDescriptorFont) {
            font = [UIFont fontWithDescriptor:[UIFontDescriptor fontDescriptorWithName:_customFontName size:size] size:size];
        }else{
            font = [UIFont fontWithName:_customFontName size:size];
        }
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


- (void)saveFontManageConfig
{
    NSUserDefaults *user = NSUserDefaults.standardUserDefaults;
    [user setValue:_customFontName forKey:@"TKFontManage-fontName"];
    [user setValue:@(_isApply) forKey:@"TKFontManage-isApply"];
    [user setValue:@(_isDescriptorFont) forKey:@"TKFontManage-isDescriptorFont"];
    [user setValue:@(_scaleSize) forKey:@"TKFontManage-scaleSize"];
    [user synchronize];
}


- (void)restoreFontManageConfig
{
    NSUserDefaults *user = NSUserDefaults.standardUserDefaults;
    _customFontName = [user valueForKey:@"TKFontManage-fontName"];
    _isApply = [[user valueForKey:@"TKFontManage-isApply"] boolValue];
    _isDescriptorFont = [[user valueForKey:@"TKFontManage-isDescriptorFont"] boolValue];
    _scaleSize = [[user valueForKey:@"TKFontManage-scaleSize"] floatValue];
    NSLog(@"恢复字体配置信息.....");

}

- (void)setScaleSize:(CGFloat)scaleSize
{
    _scaleSize = scaleSize;
    [self postFontNotification];
}


- (void)postFontNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameFontChangeKey object:nil];
}

@end


#pragma mark - 快捷字体设置
@implementation TKFontManager (Fast)

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



#pragma mark - 自动刷新字体
@implementation TKFontManager (RefreshFont)


/**
 开启自动刷新字体，即修改字体后自动刷新所有页面字体显示，默认不开启
 PS:如果不开启，重启软件即可刷新
 */
- (void)turnOnAutoRefreshFonts
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sel = NSSelectorFromString(@"swapMethodInRefreshFont");
        
        if ([UILabel respondsToSelector:sel]) {
            [UILabel performSelector:sel];
        }
        if ([UIButton respondsToSelector:sel]) {
            [UIButton performSelector:sel];
        }
        if ([UITextField respondsToSelector:sel]) {
            [UITextField performSelector:sel];
        }
        if ([UITextView respondsToSelector:sel]) {
            [UITextView performSelector:sel];
        }
    });
}

/**
 通过旧的font获取新的font
 */
-(UIFont *)getNewFontWithOld:(UIFont *)font
{
    UIFont *newFont = nil;
    if (self.isCustomFont) {
        newFont = [UIFont fontWithName:self.currentFontName size:font.pointSize];
        if (!newFont) {
            NSLog(@"字体: %@ 不存在，使用系统默认字体", self.currentFontName);
            newFont = [UIFont systemFontOfSize:font.pointSize];
        }
    }else{
        newFont = [UIFont systemFontOfSize:font.pointSize];
    }
    return newFont;
}


@end

#pragma mark - UILable扩展
@implementation UILabel (RefreshFont)

+ (void)swapMethodInRefreshFont
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = self.class;
        [TKMethodSwap swizzleMethod:cls originSel:@selector(didMoveToSuperview) swizzSel:@selector(tk_didMoveToSuperview)];
        [TKMethodSwap swizzleMethod:cls originSel:@selector(removeFromSuperview) swizzSel:@selector(tk_removeFromSuperview)];
        [TKMethodSwap swizzleMethod:cls originSel:@selector(setAttributedText:) swizzSel:@selector(tk_setAttributedText:)];
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
                                      [mutString addAttribute:NSFontAttributeName value:[TKFontManager.shared getNewFontWithOld:value] range:range];

                                  }else{
                                      [mutString addAttribute:NSFontAttributeName value:[TKFontManager.shared getNewFontWithOld:self.font] range:range];
                                  }
                              }];
        self.attributedText = mutString;
    }else{
        self.font = [TKFontManager.shared getNewFontWithOld:self.font];
    }
}

@end



#pragma mark - UIButton扩展
@implementation UIButton (RefreshFont)

+ (void)swapMethodInRefreshFont
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = self.class;
        [TKMethodSwap swizzleMethod:cls originSel:@selector(didMoveToSuperview) swizzSel:@selector(tk_didMoveToSuperview)];
        [TKMethodSwap swizzleMethod:cls originSel:@selector(removeFromSuperview) swizzSel:@selector(tk_removeFromSuperview)];
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


//UIButton的AttributedTitle优先级高于title
- (void)changeFontNotification:(NSNotification *)noti
{
    if (self.currentAttributedTitle) {
        NSAttributedString *attr = [self attributedTitleForState:self.state];
        NSRange range1 = NSMakeRange(0, attr.string.length);
        NSMutableAttributedString *mutString = [attr mutableCopy];
        [mutString enumerateAttribute:NSFontAttributeName
                              inRange:range1
                              options:(NSAttributedStringEnumerationReverse) usingBlock:^(UIFont *value, NSRange range, BOOL * _Nonnull stop){
                                  if (value) {
                                      *stop = YES;
                                      [mutString addAttribute:NSFontAttributeName value:[TKFontManager.shared getNewFontWithOld:value] range:range];
                                  }else{
                                      [mutString addAttribute:NSFontAttributeName value:[TKFontManager.shared getNewFontWithOld:self.titleLabel.font] range:range];
                                  }
                              }];
        [self setAttributedTitle:mutString forState:self.state];
    }else{
        self.titleLabel.font = [TKFontManager.shared getNewFontWithOld:self.titleLabel.font];
    }
}

@end


#pragma mark - UITextField扩展
@implementation UITextField (RefreshFont)

+ (void)swapMethodInRefreshFont
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = self.class;
        [TKMethodSwap swizzleMethod:cls originSel:@selector(didMoveToSuperview) swizzSel:@selector(tk_didMoveToSuperview)];
        [TKMethodSwap swizzleMethod:cls originSel:@selector(removeFromSuperview) swizzSel:@selector(tk_removeFromSuperview)];
        [TKMethodSwap swizzleMethod:cls originSel:@selector(setAttributedText:) swizzSel:@selector(tk_setAttributedText:)];
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
                                      [mutString addAttribute:NSFontAttributeName value:[TKFontManager.shared getNewFontWithOld:value] range:range];
                                  }else{
                                      [mutString addAttribute:NSFontAttributeName value:[TKFontManager.shared getNewFontWithOld:self.font] range:range];
                                  }
                              }];
        self.attributedText = mutString;
    }else{
        self.font = [TKFontManager.shared getNewFontWithOld:self.font];
    }
}

@end



#pragma mark - UITextView扩展
@implementation UITextView (RefreshFont)

+ (void)swapMethodInRefreshFont
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = self.class;
        [TKMethodSwap swizzleMethod:cls originSel:@selector(didMoveToSuperview) swizzSel:@selector(tk_didMoveToSuperview)];
        [TKMethodSwap swizzleMethod:cls originSel:@selector(removeFromSuperview) swizzSel:@selector(tk_removeFromSuperview)];
        [TKMethodSwap swizzleMethod:cls originSel:@selector(setAttributedText:) swizzSel:@selector(tk_setAttributedText:)];
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
                                      [mutString addAttribute:NSFontAttributeName value:[TKFontManager.shared getNewFontWithOld:value] range:range];
                                  }else{
                                      [mutString addAttribute:NSFontAttributeName value:[TKFontManager.shared getNewFontWithOld:self.font] range:range];
                                  }
                              }];
        self.attributedText = mutString;
    }else{
        self.font = [TKFontManager.shared getNewFontWithOld:self.font];
    }
}

@end

