//
//  AppIconManage.h
//  ExampleProject
//
//  Created by PC on 2022/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 app icon 管理
 包括：
    1. 动态更换APP图标

 参考：
 https://mp.weixin.qq.com/s/I0ssoHh0wiI1OHSuiVaqDQ
 https://www.jianshu.com/p/83a67cf68c9c
 https://www.jianshu.com/p/e34b9805b424
 */

@interface AppIconManage : NSObject
@property(nonatomic, assign) BOOL showAlert;//更换成功后是否显示弹窗提示， 默认显示

+ (instancetype)shared;

/**
 APP图标替换
 iconName: Icon files (iOS 5) -> CFBundleAlternateIcons -> iconName ; 如果为nil则使用默认icon
 */
- (void)changeAppIconWithName:(NSString *)iconName;

@end




// MARK: - 为UIViewController添加扩展，实现去掉更换icon时的弹框
@interface UIViewController (AppIconDynamic)
/**
 开启函数交换实现更换icon时去掉弹出
 */
+ (void)appIconDynamicSwap;
@end



NS_ASSUME_NONNULL_END
