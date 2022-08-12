//
//  UIImage+TKSDK.h
//  Review
//
//  Created by PC on 2020/9/17.
//  Copyright © 2020 PC. All rights reserved.
//

/**
图片处理相关三方库:YYImage,CPUImage

PS:
1.处理之后的UIimage都会变大，如果需要存储，传输。可以使用YYImage中的编码器对图片进行压缩。
  注意YYImage编码器会将图片的透明区域编程白色

2.UIImage对应图片的实际大小为 picture.size = image.size * image.scale

3.如果生成的UIImage需要压缩请使用YYImage中的图片编码器，YYImage图片编码器会吧透明区域编码成白色，如果

 :https://blog.csdn.net/larryluoshuai/article/details/78200434
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (TKSDK)
/**
 *功能：添加高斯模糊效果，推荐使用该方法进行高斯模糊处理
 *image:是图片
 *blur:模糊程度，有效值 0.0~2.0
 */
+(UIImage *)TKBlurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

/**
 *功能：高斯模糊，使用CoreImage实现，速度比较块，但是生成的图片比较大（相对于TKBlurryGaussianSpeedMinImage：）
 *image:输入的图片
 *blur:模糊度，默认8
 */
+(UIImage*)TKBlurryGaussianSpeedMaxImage:(UIImage*)image withBlurLevel:(CGFloat)blur;

/**
 *功能：高斯模糊，使用CoreImage实现，速度很慢,生成的图片相对比较小(相对于TKBlurryGaussianSpeedMaxImage：)
 *image:输入的图片
 *blur:模糊度，默认8
 */
+(UIImage*)TKBlurryGaussianSpeedMinImage:(UIImage*)image withBlurLevel:(CGFloat)blur;

/**
 * 根据颜色-创建矩形图片
 * color:颜色
 * size: 矩形大小
 * alpha:透明度
 */
+(UIImage*)TKCreateSquareWithColor:(UIColor*)color size:(CGSize)size alpha:(CGFloat)alpha;

/**
 * 根据颜色－创建圆形/椭圆
 * color:颜色
 * size:圆形/椭圆的大小
 * alpha:透明度
 */

+(UIImage*)TKCreateCircularWithColor:(UIColor*)color size:(CGSize)size alpha:(CGFloat)alpha;

/**
 功能：创建一个圆环
 color：颜色
 radius:圆环外径的长度
 width: 圆环的宽度
 alpha: 生成图片透明度
 */
+ (UIImage*)TKCreateCircularRingWithColor:(UIColor*)color radius:(CGFloat)radius  width:(CGFloat)width alpha:(CGFloat)alpha;


/**
 功能：根据颜色数组创建等宽度的同心圆
 colors:颜色数组
 radius:圆的半径
 alpha：透明度
 fromCenter:是否是从圆心向外绘制
 */
+ (UIImage *)TKCreateConcentricCirclesWithColors:(NSArray <UIColor*> *)colors radius:(CGFloat)radius alpha:(CGFloat)alpha fromCenter:(BOOL)fromCenter;

/**
 功能：根据图片数组与对应的比例数组创建同心圆环，每个圆环的宽度由proportions决定
 colors:颜色数组
 proportions:每一个圆环宽度占比数组,每个item的值必须大于等于0
 radius:圆的半径
 alpha：透明度
 fromCenter:是否是从圆心向外绘制
 注意：colors.count == proportions.count
 */
+ (nullable UIImage *)TKCreateConcentricCirclesWithColors:(NSArray <UIColor*> *)colors  proportions:(NSArray<NSNumber *> *)proportions radius:(CGFloat)radius alpha:(CGFloat)alpha fromCenter:(BOOL)fromCenter;

/**
 UIImage 转 Base64字符串
 */
+ (NSString *)TKBase64ConvertToStringWithImage:(UIImage *)image;

/**
 Base64字符串 转 UIImage
 */
+ (UIImage *)TKBase64ConvertToImageWithString:(NSString *)str;


/**
 将图片大小进行等比例缩放
 image:原始图片
 scale：缩放比例
 PS:处理之后的图片占用内存不会变大，如果需要网络传输请进行压缩一下,例如：YYImage, UIImageJPEGRepresentation()
 */
+ (UIImage *)TKImageCompressScaleWith:(UIImage *)image scale:(CGFloat)scale;

/**
 指定图片的宽或者高进行等比例缩放
 image:原始图片
 widthOrHeight:图片的宽或者高的大小
 type：缩放类型  1：按照宽度进行缩放  0:按照高度进行缩放
 PS:处理之后的图片占用内存不会变大，如果需要网络传输请进行压缩一下,例如：YYImage, UIImageJPEGRepresentation()
 */
+ (UIImage *)TKImageCompressTragetWidthOrHeightWith:(UIImage *)image widthOrHeight:(CGFloat)widthOrHeight type:(NSInteger)type;

/**
 将图片以最小的一边为标准，自动裁剪为正方形
 PS:处理之后的图片占用内存不会变大，如果需要网络传输请进行压缩一下,例如：YYImage, UIImageJPEGRepresentation()
 */
+ (UIImage *)TKImageTailoringToSquareWithImage:(UIImage *)image;

/**
 对图片指定区域进行裁剪
 tragetFrame:目标区域
 PS:tragetFrame的大小以图片的实际尺寸为参考，如果超出区域剪切的图片会有空白
 */
+ (UIImage *)TKImageTailoringToSquareWithImage:(UIImage *)image tragetFrame:(CGRect)tragetFrame;

/**
 从指定位置对图片进行剪裁，包括：左上角，左下角，右下角，右上角，中心。
 tragetSize:剪裁区域大小，如果对应的高宽大于图片的实际高宽，则取值对应图片的实际高宽
 type:位置类型
    0：左上角
    1：左下角
    2：右下角
    3：右上角
    4：中心
 */
+ (UIImage *)TKImageTailoringToSquareWithImage:(UIImage *)image tragetSize:(CGSize)tragetSize  type:(NSInteger)type;

/**
* 将图片旋转按顺时针方向进行旋转，旋转点是以左上角为原点进行的
* image:待旋转的图
* angle:旋转角度，有效值为0~360
* isExpand:是否扩展，如果不扩展，那么生成的图像大小不变(和原图片相同)，但被截掉一部分
*/
+ (UIImage *)TKImageRotationWithImage:(UIImage *)image angle:(NSInteger)angle isExpand:(BOOL)isExpand;


/**
 获取UIimage的大小(kb，其实是内存中所占的大小),转化成NSData对象进行计算的
 如果是高清大图，可直接通过NSFileManager获取
 */
+ (NSInteger)TKImageMemorySizeWithImage:(UIImage *)image;

/**
 获取图片的实际类型
 如：jpeg,png,gif,tiff
 */
+ (NSString *)TKImageTypeWithImageData:(NSData *)imageData;


/**
* 将UIImage图片,分解成UIImage帧数组
* data： 图片对应的NSData数据
* scale：缩放倍率
* 开源库: https://github.com/liyong03/YLGIFImage
* See:  http://nullsleep.tumblr.com/post/16524517190/animated-gif-minimum-frame-delay-browser-compatibility
* Also: http://blogs.msdn.com/b/ieinternals/archive/2010/06/08/animated-gifs-slow-down-to-under-20-frames-per-second.
**/
+ (NSArray *)TKImageDecoderImgAryWithData:(NSData *)data scale:(CGFloat)scale;

/**
 获取gif图片每帧播放时间
 */
+ (NSTimeInterval)TKImageGifFramePlayTimeWithData:(NSData *)gifData;


@end

NS_ASSUME_NONNULL_END
