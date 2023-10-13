//
//  TKQRCodeTool.h
//  ExampleProject
//
//  Created by kimi on 2023/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 二维码生成与扫描器
 */
@interface TKQRCodeTool : NSObject

/**
 生成二维码
 string: 二维码信息
 centerImage: 二维码中心图片，可选
 width: 指定生成二维码的宽，只有当width>0时才有效。
 PS:如果未指定二维码生成的宽度时，生成二维码的原始大小与被编码的数据长度有关。
 */
+ (nullable UIImage *)qrGenerateQRCodeWith:(NSString *)string centerImage:(nullable UIImage *)centerImage width:(CGFloat)width;
+ (nullable UIImage *)qrGenerateQRCodeWith:(NSString *)string centerImage:(nullable UIImage *)centerImage;



/**
 识别图像中的二维码
 PS:该方法只解码图片中识别到的第一个二维码，因为同一图片中可能有多个二维码信息
 */
+ (nullable NSString *)qrRecognizeFromImage:(UIImage *)image;
/**
 识别图片中所有的二维码信息。
 return: 返回所有识别到的二维码信息。
 */
+ (nullable NSArray *)qrRecognizeAllFromImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
