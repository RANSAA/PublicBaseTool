//
//  UIImage+Extension.h
//  CreaditCard
//
//  Created by Mac on 2018/1/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  取消系统对图片的渲染
 *
 *  @param imageName 图片
 *
 *  @return 原始无渲染图片
 */
+ (UIImage *)imageModeAlwaysOriginal:(NSString *)imageName;
/**
 *  重新设置图片尺寸
 *
 *  @param name 图片名称
 *  @param size 新尺寸
 *
 *  @return 图片
 */
+ (UIImage *)imageResizableWithImage:(NSString *)name size:(CGFloat)size;
/**
 *  取消系统对图片的渲染并且重设尺寸
 *
 *  @param imageName 图片名称
 *  @param size      新的尺寸
 *
 *  @return 新的图片
 */
+ (UIImage *)imageModeAlwaysOriginalWithResizableImage:(NSString *)imageName size:(CGFloat)size;
/**
 *  通过颜色创建图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)imageCreateImageWithColor:(UIColor *)color;
/**
 *  压缩原图片尺寸
 *
 *  @param image 原图片
 *  @param size  新尺寸
 *
 *  @return 新图片
 */
-(UIImage*)imageWithOriginImage:(UIImage *)image scaleToSize:(CGSize)size;

/**
 *  设置图片拉伸位置
 *
 *  @param image        原始图片
 *  @param leftCapWidth 左端盖宽度
 *  @param topCapHeight 顶端盖宽度
 *
 *  @return 新图片
 */
+ (UIImage *)imageWithImage:(UIImage *)image leftCapWidth:(NSInteger)leftCapWidth andTopCapHeight:(NSInteger)topCapHeight;

/**
 *  设置图片只拉伸中间区域
 *
 *  @param imageName 原始图片名称
 *
 *  @return 新图片
 */
+ (UIImage *)getImageWithImageName:(NSString *)imageName;
/**
 *  获取压缩图片 图片尺寸压缩至640*480 或者 480*640
 *
 *  @param image 原始图片
 *
 *  @return 新的图片
 */
+ (UIImage *)resizeImageWithOriginalImage:(UIImage *)image;


+ (UIImage *)imageCompressForOriginalImage:(UIImage *)sourceImage targetSize:(CGSize)size;

/**
 图片旋转,
 radians: 旋转的弧度。
 */
+ (UIImage *)imageRotatedByRadinasWithImage:(UIImage *)image radina:(CGFloat)radians;

@end
