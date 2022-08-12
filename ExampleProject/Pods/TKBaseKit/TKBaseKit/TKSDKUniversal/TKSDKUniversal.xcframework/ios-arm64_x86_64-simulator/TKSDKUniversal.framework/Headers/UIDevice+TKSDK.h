//
//  UIDevice+TKSDK.h
//  TKSDKUniversal
//
//  Created by Mac on 2019/3/22.
//  Copyright © 2019年 Mac. All rights reserved.
//
/** 用于处理ios Device 相关扩展 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (TKSDK)

#pragma mark 获取信息区域



/**
 获取APP名称。
 PS:即获取CFBundleDisplayName的值，如果没有就获取CFBundleName的值
 */
+ (NSString *)TK_getAppName;

/**
 * 获取APP的名称
 * PS:即获取CFBundleName的值
 **/
+ (NSString *)TK_getAppProjectName;

/**
 获取APP bundleID
 */
+ (NSString *)TK_getAppBundleID;

/**
 * 获取APP的包名
 **/
+ (NSString *)TK_getAppPackgeName;

/**
 *  获取APP的版本号
 */
+ (NSString *)TK_getAppVersionID;

/**
 *获取APP的构建号
 */
+ (NSString *)TK_getAppBuild;

/**
 * 获取设备的唯一标识号 UUID
 **/
+ (NSString *)TK_getUUID;

/** 获取infoDictionary  */
+ (NSDictionary *)TK_infoPlist;

/**
 读取info.plist文件中的UIStatusBarStyle信息
 */
+ (UIStatusBarStyle)TK_getInfoPlistStatusBarStyle;

/**
 读取info.plist文件中的UIStatusBarHidden信息
 */
+ (BOOL)TK_getInfoPlistStatusBarHidden;

/**
 获取顶部状态栏安全区域的高度（ps：没有刘海的状态栏高度）
 */
+ (CGFloat)TK_getSafeTopAreaHeight;

/**
 获取底部下巴安全区域的高度
 */
+ (CGFloat)TK_getSafeBottomAreaHeight;

/**
 获取状态栏的frame
 */
+ (CGRect)TK_getStatusBarFrame;


/**
 获取推送时的deviceToken；即将NSData格式的deviceToken转化为十六进制格式的字符串
 */
+ (NSString *)TK_getDeviceTokenWithRemoteNotification:(NSData *)deviceToken;


/**
 * 获取 iphone 名称
 **/
+ (NSString *)TK_getIphoneName;

/**
 获取CPU核心数
 */
+ (NSInteger)TK_getCpuCores;

/**
 * 获取电池电量
 **/
+ (CGFloat)TK_getBatteryLow;

/**
 *  获取精准电池电量
 **/
+ (CGFloat)TK_getBatteryHeight;

/**
 *  获取电池当前的状态，共有4种状态
 **/
+ (NSString *)TK_getBatteryState;

/**
 * 获取当前系统名称
 **/
+ (NSString*)TK_getSystemName;

/**
 * 获取当前系统版本号
 **/
+ (NSString *)TK_getSystemVersion;


///**
// * 获取设备广告ID
// *所有软件供应商相同的 一个值
// * 用于广告相关 - 如果使用了,那么必须提供广告
// * 使用了IDAF后会对苹果审核有影响，所以把广告ID获取取消掉
// **/
//+ (NSString *)TK_getAdvIdentifier;

/**
 * 获取当前设备 IP 地址
 * (这儿应该是局域网地址)
 */
+ (NSString *)TK_getIPAdress;

/**
 * 获取设备的物理内存大小
 **/
+ (long long) TK_getMemorySize;

/**
   获取设备当前语言类型
 */
+ (NSString *)TK_getDefaultLanguage;

/**
 获取设备类型
 返回:iPhone，iPad，iPod touch，Apple Watch，iPad mini等
 */
+ (NSString *)TK_getDeviceModel;

/**
 获取设备的具体Identifier
 例如："iPhone12,5","iPhone12,3" 等
 https://www.theiphonewiki.com/wiki/Models
 */
+ (NSString *)TK_getDeviceIdentifier;

/**
  获取设备的具体型号如iPhone5s,iPhone6s等(PS:如果是模拟器会直接返回Simulator)
  已经更新到 iPhone 12 Pro Max
  time: 2021-6-17
  ps:只有iPhone的类型是全的，其它的如果需要，直接到下列网址中w去添加
  https://www.theiphonewiki.com/wiki/Models
*/
+ (NSString *)TK_getDeviceDetailsType;



#pragma mark 检测判断区域
/**
判断当前设备是否是全面屏(PS:是否有刘海或者下吧)
即：iPhone X，iPhone XR，iPhone XS，iPhone XS Max,iPad Pro 等带刘海的屏幕
注意：当前判断是否是全面屏是以UI用户界面为标准的，
     比如在右下吧的iPad Pro上面以iPhone模式运行APP时，检测到的状态是没有刘海的
*/
+ (BOOL)TK_isFullScreen;

/**
 判断当前用户界面是否为横屏
 YES:横屏 NO：竖屏
 **/
+ (BOOL)TK_isInterfaceLandscape;

/**
 获取当前用户界面方向
 */
+ (UIInterfaceOrientation)TK_getInterfaceOrientation;

/**
 判断当前设备运行的UI模式是否时iPhone布局
 iPad设备上会根据项目是否勾选target iPad而右不用的结果
 主要用于UI上面区分iPhone与iPad
 YES:iPhone
 NO: iPad
*/
+ (BOOL)TK_isDeviceWithInterfaceIphone;

/**
 获取当前设备运行的模式，比如在iPad上面模拟运行返回的还是iPhone
 主要用于设计UI时区分iPad还是iPhone（如程序在iPad上是否是模拟iPhone运行）

 UIUserInterfaceIdiomUnspecified = -1,
 UIUserInterfaceIdiomPhone API_AVAILABLE(ios(3.2)), // iPhone and iPod touch style UI
 UIUserInterfaceIdiomPad API_AVAILABLE(ios(3.2)), // iPad style UI
 UIUserInterfaceIdiomTV API_AVAILABLE(ios(9.0)), // Apple TV style UI
 UIUserInterfaceIdiomCarPlay API_AVAILABLE(ios(9.0)), // CarPlay style UI
 
 */
+ (UIUserInterfaceIdiom)TK_isDeviceWithInterfaceIdiom;

/**
 * 检查当前设备是否是模拟器
 **/
+ (BOOL)TK_isSimulator;

/**
 * 检测设备是否越狱了
 **/
+ (BOOL)TK_isCydia;

/**
 * 动态检测当前是否是Debug模式
 **/
+ (BOOL)TK_isDebugger;



@end

NS_ASSUME_NONNULL_END
