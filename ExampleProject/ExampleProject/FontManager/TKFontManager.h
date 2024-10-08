//
//  TKFontManager.h
//  TKFontManager
//
//  Created by PC on 2022/7/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 自定义字体使用方法：
    1. 准备好字体包，导入的字体格式可以是ttf、otf、ttc
    2. 将字体包拖入项目中
    3. 在info.plist文件里增加Fonts provided by application项，并设置相应的ttf文件进去
    4. 可以通过fontList方法找到具体的字体名称。可以将字体安装在电脑上，然后通过『字体册』查看具体的：familyName,fontName
    5. 使用自定义的字体：
          [UIFont fontWithName:@"fontName" size:17];
    6. 切换字体后刷新最简单的方法是重启应用，或者使用通知直接刷新所有的控件


 PS: 也可以动态加载字体文件(App下载的字体),直接使用下列两种方式即可动态加载字体文件：
     dynamicLoadFontData:checkFontName:
     dynamicLoadFontPath:checkFontName:

 注意事项：
    要想自定义字体效果的控件，必须使用该类创建的字体，否则会出现动态修改字体后当时字体效果正常，重启APP后某些控件的字体效果会丢失，出现这种情况需要检测对应控件的font属性是否使用了该类进行赋值。

    如果连续切换多种自定义字体后，可能会出现文字显示不完全（对应的UI控件足够展示font），可以先设置一次默认系统再切换多种自定义字体即可
 */

NS_ASSUME_NONNULL_BEGIN


#define kFont4 TKFontManager.shared.font4
#define kFont5 TKFontManager.shared.font5
#define kFont6 TKFontManager.shared.font6
#define kFont7 TKFontManager.shared.font7
#define kFont8 TKFontManager.shared.font8
#define kFont9 TKFontManager.shared.font9
#define kFont10 TKFontManager.shared.font10
#define kFont11 TKFontManager.shared.font11
#define kFont12 TKFontManager.shared.font12
#define kFont13 TKFontManager.shared.font13
#define kFont14 TKFontManager.shared.font14
#define kFont15 TKFontManager.shared.font15
#define kFont16 TKFontManager.shared.font16
#define kFont17 TKFontManager.shared.font17
#define kFont18 TKFontManager.shared.font18
#define kFont19 TKFontManager.shared.font19
#define kFont20 TKFontManager.shared.font20
#define kFont21 TKFontManager.shared.font21
#define kFont22 TKFontManager.shared.font22
#define kFont23 TKFontManager.shared.font23
#define kFont24 TKFontManager.shared.font24
#define kFont25 TKFontManager.shared.font25
#define kFont26 TKFontManager.shared.font26


@interface TKFontManager : NSObject
#pragma mark - 字体管理及其相关设置

+ (instancetype)shared;


/**
 动态加载字体文件
 fontData:字体文件data数据
 fontName:字体真实名称
 PS:必须在使用自定义字体之前加载
 */
- (void)dynamicLoadFontData:(NSData *)fontData checkFontName:(nullable NSString *)fontName;

/**
 动态加载字体文件
 fontPath:字体文件的路径
 fontName:字体真实名称
 PS:必须在使用自定义字体之前加载
 */
- (void)dynamicLoadFontPath:(NSString *)fontPath checkFontName:(nullable NSString *)fontName;

/**
 familyName列表
 */
- (void)familyName;

/**
 系统字体列表
 */
- (void)fontNames;

/**
 当前使用的字体类型名称
 */
- (NSString *)currentFontName;

/**
 是否使用了自定义字体
 */
- (BOOL)isCustomFont;

/**
 检查字体是否存在
 */
- (BOOL)isExistFontName:(NSString *)fontName;

/**
 设置自定义字体
 fontName：字体名称
 isApply：是否生效，NO直接使用系统默认字体
 */
- (void)setFontName:(NSString *)fontName isApply:(BOOL)isApply;

/**
 字体生成工厂
 */
- (UIFont *)fontFactoryOfSize:(CGFloat)size;


/**
 字体大小的增量，即在所用通过TKFontManager管理的字体大小的值为:设定值+增量值，默认为0.
 */
@property(nonatomic, assign) CGFloat increaseSize;

/**
 是否使用UIFontDescriptor详细描述创建UIFont，默认NO
 场景：有些字体文件中有多重样式，使用fontWithName方法可能无法正确加载字体，则需要使用UIFontDescriptor方法加载。
 */
@property(nonatomic, assign) BOOL isDescriptorFont;

@end

@interface TKFontManager (Fast)
#pragma mark - 快捷字体设置
- (UIFont *)font4;
- (UIFont *)font5;
- (UIFont *)font6;
- (UIFont *)font7;
- (UIFont *)font8;
- (UIFont *)font9;
- (UIFont *)font10;
- (UIFont *)font11;
- (UIFont *)font12;
- (UIFont *)font13;
- (UIFont *)font14;
- (UIFont *)font15;
- (UIFont *)font16;
- (UIFont *)font17;
- (UIFont *)font18;
- (UIFont *)font19;
- (UIFont *)font20;
- (UIFont *)font21;
- (UIFont *)font22;
- (UIFont *)font23;
- (UIFont *)font24;
- (UIFont *)font25;
- (UIFont *)font26;
@end


#pragma mark - 自动刷新字体
@interface TKFontManager (RefreshFont)

/**
 开启自动刷新字体，即修改字体后自动刷新所有页面字体显示，默认不开启
 PS:如果不开启，重启软件即可刷新
 */
- (void)turnOnAutoRefreshFonts;

/**
 通过旧的font获取新的font
 */
-(UIFont *)getNewFontWithOld:(UIFont *)font;

@end




#pragma mark - UILable扩展
@interface UILabel (RefreshFont)
//是否主动设置富文本
@property (nonatomic,assign)BOOL isSetAttributedText;
@end


#pragma mark - UIButton扩展
@interface UIButton (RefreshFont)
@end


#pragma mark - UITextField扩展
@interface UITextField (RefreshFont)
//是否主动设置富文本
@property (nonatomic,assign)BOOL isSetAttributedText;
@end


#pragma mark - UITextView扩展
@interface UITextView (RefreshFont)
//是否主动设置富文本
@property (nonatomic,assign)BOOL isSetAttributedText;
@end


NS_ASSUME_NONNULL_END
