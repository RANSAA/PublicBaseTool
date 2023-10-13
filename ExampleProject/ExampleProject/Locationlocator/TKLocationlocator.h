//
//  TKLocationlocator.h
//  ExampleProject
//
//  Created by kimi on 2023/10/13.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


NS_ASSUME_NONNULL_BEGIN
/**
 简单的定位与地址编码器
 */
@interface TKLocationlocator : NSObject
@property(nonatomic, copy, nullable) void(^blockAddress)(NSString  * _Nullable addr);//获取地址信息时回调 -> 时机：位置编码，获取到定位信息
@property(nonatomic, copy, nullable) void(^blockLocation)(CLLocation * _Nullable location);//获取到位置坐标是回调 -> 时机：位置编码，获取到定位信息


// 地址编码（从地址到坐标）PS: 获取第一个地址编码的坐标信息 -> 可失败
- (void)geocodeAddress:(NSString *)address;
// 反地址编码（从坐标到地址）-> 可失败
- (void)reverseGeocodeLocation:(CLLocation *)location;



@end

NS_ASSUME_NONNULL_END
