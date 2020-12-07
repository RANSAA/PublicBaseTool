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
 * 获取APP名称
 **/
+ (NSString *)TK_getAppProjectName;

/**
 * 获取APP的显示名称,Xcode11及其之后的版本创建的项目无法获取
 **/
+ (NSString *)TK_getAppName API_DEPRECATED_WITH_REPLACEMENT("TK_getAppProjectName", ios(2.0, 9.0));

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

/**
  获取设备的状态栏的高度(返回的是没有隐藏状态栏的时的高度，主要是用于适配留海相关)
  有刘海的高度为44，没有的为20
  PS:iPad UI上面的高度与iPhone上面的高度不一样
  推荐使用：TK_getSafeTopAreaHeight
*/
+ (CGFloat)TK_getDeviceStatusHeight;

/**
  获取设备底部下巴区域的高度(为适配留海屏下巴区域的操作)
  有留海下巴的填充高度为：34，没有的为：0
  PS:iPad UI上面的高度与iPhone上面的高度不一样
  推荐使用：TK_getSafeBottomAreaHeight
*/
+ (CGFloat)TK_getDeviceBottomSpaceHeight;

/**
 获取顶部状态栏安全区域的高度（ps：没有刘海的状态栏高度）
 */
+ (CGFloat)TK_getSafeTopAreaHeight;

/**
 获取底部下巴安全区域的高度
 */
+ (CGFloat)TK_getSafeBottomAreaHeight;


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
 获取设备类型：是iPhone还是iPad,其它。（不区分是否是模拟器）
 返回类型：
 0:未知
 1:iPhone
 2:iPad
 3:iPod touch
 4:Apple Watch
 5:iPad mini
 **/
+ (NSInteger)TK_getDeviceModelType;

/**
  获取设备类型：是iPhone还是iPad(PS:只区分设备类型，不区分是模拟器，还是真机)
  return： iPhone 或者 iPad 等
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
  已经更新到 iPhone x
  time: 2019-12-25
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
