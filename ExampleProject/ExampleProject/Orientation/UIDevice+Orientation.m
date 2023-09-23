//
//  UIDevice+Orientation.m
//  TKSDKXibView
//
//  Created by kimi on 2023/8/1.
//

#import "UIDevice+Orientation.h"



//@implementation UIDevice (Orientation)
//
//- (void)setOrientationIOS16:(UIInterfaceOrientationMask)orientation
//{
//    [self setOrientationIOS16:orientation errorHandler:nil];
//}
//
//- (void)setOrientationIOS16:(UIInterfaceOrientationMask)orientation errorHandler:(nullable void (^)(NSError *error))errorHandler
//{
//    if(@available(iOS 16.0,*)){
//        UIWindowScene *scene = (UIWindowScene *)UIApplication.sharedApplication.connectedScenes.allObjects.firstObject;
//        UIWindowSceneGeometryPreferencesIOS *geometryPreferences = [[UIWindowSceneGeometryPreferencesIOS alloc] init];
//        geometryPreferences.interfaceOrientations = orientation;
//        if(errorHandler){
//            [scene requestGeometryUpdateWithPreferences:geometryPreferences errorHandler:errorHandler];
//        }else{
//            [scene requestGeometryUpdateWithPreferences:geometryPreferences errorHandler:^(NSError * _Nonnull error) {
//                NSLog(@"屏幕旋转失败: %@",error);
//            }];
//        }
//    }
//}
//
//@end





@interface UIDevice ()
/**
 功能：设置屏幕方向，小于iOS16(手动旋转)
 说明: 直接使用扩展来访问是有方法，即只声明不实现。
 注意: 如果出现上架错误请直接使用以前的老方法实现。
 */
- (void)setOrientation:(UIInterfaceOrientation)orientation API_DEPRECATED("iOS16+使用setOrientationIOS16:", ios(2.0, 16.0));
@end

@implementation UIDevice (Orientation)

- (void)setUIOrientation:(TKInterfaceOrientation)orientation
{
    [self setUIOrientation:orientation errorHandler:nil];
}

- (void)setUIOrientation:(TKInterfaceOrientation)orientation errorHandler:(nullable void (^)(NSError *error))errorHandler
{
    NSInteger realOrientation = [self obtainOrientationRealValueWith:orientation];
    if(@available(iOS 16.0,*)){
        UIWindowScene *scene = (UIWindowScene *)UIApplication.sharedApplication.connectedScenes.allObjects.firstObject;
        UIWindowSceneGeometryPreferencesIOS *geometryPreferences = [[UIWindowSceneGeometryPreferencesIOS alloc] init];
        geometryPreferences.interfaceOrientations = realOrientation;
        if(errorHandler){
            [scene requestGeometryUpdateWithPreferences:geometryPreferences errorHandler:errorHandler];
        }else{
            [scene requestGeometryUpdateWithPreferences:geometryPreferences errorHandler:^(NSError * _Nonnull error) {
                NSLog(@"屏幕旋转失败: %@",error);
            }];
        }
    }else{
        ///首先设置UIInterfaceOrientationUnknown欺骗系统，避免可能出现直接设置无效的情况
        [self setOrientation:UIInterfaceOrientationUnknown];
        
        [self setOrientation:realOrientation];
    }
}

/**
 根据不同的系统版本获取TKInterfaceOrientation枚举对应的真实值
 */
- (NSInteger)obtainOrientationRealValueWith:(TKInterfaceOrientation)orientation
{
    NSInteger real = 0;
    if(@available(iOS 16.0,*)){
        switch (orientation) {
            case TKInterfaceOrientationPortrait:
                real = UIInterfaceOrientationMaskPortrait;
                break;
            case TKInterfaceOrientationPortraitUpsideDown:
                real = UIInterfaceOrientationMaskPortraitUpsideDown;
                break;
            case TKInterfaceOrientationLandscapeLeft:
                real = UIInterfaceOrientationMaskLandscapeLeft;
                break;
            case TKInterfaceOrientationLandscapeRight:
                real = UIInterfaceOrientationMaskLandscapeRight;
                break;
        }
    }else{
        switch (orientation) {
            case TKInterfaceOrientationPortrait:
                real = UIInterfaceOrientationPortrait;
                break;
            case TKInterfaceOrientationPortraitUpsideDown:
                real = UIInterfaceOrientationPortraitUpsideDown;
                break;
            case TKInterfaceOrientationLandscapeLeft:
                real = UIInterfaceOrientationLandscapeLeft;
                break;
            case TKInterfaceOrientationLandscapeRight:
                real = UIInterfaceOrientationLandscapeRight;
                break;
        }
    }
    return real;
}

@end
