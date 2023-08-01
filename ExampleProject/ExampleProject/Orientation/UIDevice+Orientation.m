//
//  UIDevice+Orientation.m
//  TKSDKXibView
//
//  Created by kimi on 2023/8/1.
//

#import "UIDevice+Orientation.h"

@implementation UIDevice (Orientation)

- (void)setOrientationIOS16:(UIInterfaceOrientationMask)orientation
{
    [self setOrientationIOS16:orientation errorHandler:nil];
}

- (void)setOrientationIOS16:(UIInterfaceOrientationMask)orientation errorHandler:(nullable void (^)(NSError *error))errorHandler
{
    if(@available(iOS 16.0,*)){
        UIWindowScene *scene = (UIWindowScene *)UIApplication.sharedApplication.connectedScenes.allObjects.firstObject;
        UIWindowSceneGeometryPreferencesIOS *geometryPreferences = [[UIWindowSceneGeometryPreferencesIOS alloc] init];
        geometryPreferences.interfaceOrientations = orientation;
        if(errorHandler){
            [scene requestGeometryUpdateWithPreferences:geometryPreferences errorHandler:errorHandler];
        }else{
            [scene requestGeometryUpdateWithPreferences:geometryPreferences errorHandler:^(NSError * _Nonnull error) {
                NSLog(@"屏幕旋转失败: %@",error);
            }];
        }
    }
}

@end
