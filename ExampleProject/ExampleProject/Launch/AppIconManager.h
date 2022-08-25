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


 弹窗显示中文方法：
    方法一： 直接将CFBundleDevelopmentRegion 属性设置为 China
    方法二： 添加CFBundleAllowMixedLocalizations键，值设置为YES

 参考：
 https://mp.weixin.qq.com/s/I0ssoHh0wiI1OHSuiVaqDQ
 https://www.jianshu.com/p/e34b9805b424
 https://www.jianshu.com/p/4e28bded6959


 Apple:
 https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html#//apple_ref/doc/uid/TP40009249-SW14
 */

@interface AppIconManage : NSObject
@property(nonatomic, assign) BOOL showAlert;//更换成功后是否显示弹窗提示， 默认显示
@property(nonatomic, copy, nullable) void(^completionHandler)(NSError * _Nullable error);//更换图标后回调

+ (instancetype)shared;

/**
 APP图标替换
 iconName: Icon files (iOS 5) -> CFBundleAlternateIcons -> iconName ; 如果为nil则使用默认icon
 */
- (void)changeAppIconWithName:(nullable NSString *)iconName;

@end




NS_ASSUME_NONNULL_END
