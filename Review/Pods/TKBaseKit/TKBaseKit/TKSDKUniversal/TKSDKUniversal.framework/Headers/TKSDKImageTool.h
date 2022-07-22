//
//  TKSDKImageTool.h
//  yunDaoProject
//
//  Created by PC on 16/2/16.
//  Copyright © 2016年 yunDaoTravel. All rights reserved.
//

/**
 PS:有几个方法好像有bug，目前没有修改
 图片处理相关三方库:YYImage
 **/

#import <Foundation/Foundation.h>
#import <Accelerate/Accelerate.h>
#import <UIKit/UIKit.h>

@interface TKSDKImageTool : UIImage

/**加模糊效果，
 *image是图片(png)，-- 不能是在内存中画出来的－－原因不详
 *blur是模糊度
 */
+ (UIImage *)TKBlurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

/** 根据颜色－创建矩形图片
 * color:导颜色
 * alpha:透明度
 * rect: 创建的图片大小
 */
+ (UIImage*)TKCreateImageWithColor:(UIColor*)color rect:(CGRect)frame alpha:(CGFloat)alpha;

/** 根据颜色－创建圆形图片
 * color:导颜色
 * alpha:透明度
 * rect: 创建的图片大小
 */

+ (UIImage*)TKCreateShapeImageWithColor:(UIColor*) color rect:(CGRect)frame alpha:(CGFloat)alpha;

/**
 *创建一个圆环
 **/
+ (UIImage*)TKCreateDonutImageWithColor:(UIColor*) color rect:(CGRect)frame  width:(CGFloat) width alpha:(CGFloat)alpha;

/**图片模糊处理
 *image:输入的图片
 *value:模糊度
 */
+ (UIImage*)TKCreateFuzzyImage:(UIImage*) image Alpha:(CGFloat)value;

/**
 * UIImage 转 Base64字符串
 */
+ (NSString *)TKBase64StringWithImage:(UIImage *)image;

/**
 * Base64字符串转UIImage 对象
 **/
+ (UIImage *)TKImageWithBase64String:(NSString *)str;

/**
 将图片缩放到指定的尺寸-并且不失真
 **/
+ (UIImage *)TKImageCompressBaseSalceWith:(UIImage *)image rect:(CGRect)tragetRect;

/**
 *指定图片的宽度,将图片按比例缩放
 **/
+ (UIImage *)TKImageCompressForWidthWithImage:(UIImage *) image targetWidth:(CGFloat) fixedWidth;

/**
 指定图片的高度，将图片按比例缩放
 **/
+ (UIImage *)TKImageCompressForHeightWithImage:(UIImage *) image targetHeight:(CGFloat) fixedHeight;

/**
 * 将图片按比例缩放
 * scale:图片缩放比例
 */
+ (UIImage *)TKImageCompressForScaleWithImage:(UIImage *) image scale:(CGFloat) scale;
/**
 剪裁图片，即剪裁获取图片指定区域的图片
 image：      目标图片
 tailorRect:  裁剪的区域
 如果裁剪的区域大于图片实际的size，那么有效最大宽，高就为目标图片的实际对应的宽高
 tailorRect.origin默认为Point(0,0);
 **/
+ (UIImage *)TKImageCompressTailoringWithImage:(UIImage *)image  tailorRect:(CGRect)tailorRect;

/**
 剪裁图片，即剪裁获取图片指定区域的图片
 image：      目标图片
 tailorSize:    剪裁大小
 如果裁剪的区域大于图片实际的size，那么有效最大宽，高就为目标图片的实际对应的宽高
 剪裁位置是从图片的中心点向四周发散的
 **/
+ (UIImage *)TKImageCompressTailoringWithImage:(UIImage *)image  tailorSize:(CGSize)tailorSize;

/**
 将原图进行缩放，然后根据指定的尺寸获取到一个正方形的的图片,并且保持图片的某一边完全展示
 image:原始图片
 zoomSize：目标图片的高宽
 PS:推荐用于用户头像裁剪
 **/
+ (UIImage *)TKImageCompressZoomWithImage:(UIImage *)image zoomSize:(CGFloat)zoomSize;

/**
 * 将图片旋转
 **/
+ (UIImage *)TKImageRotationWithImage:(UIImage *)image rotation:(UIImageOrientation)orientation;

/**
 * 获取UIimage的大小(kb)
 * 其实是内存中所占的大小
 **/
+ (NSInteger)TKImageFileSizeWithImage:(UIImage *)image;

/**
 * 获取图片的文件类型
 * jpeg,png,gif,tiff
 **/
+ (NSString *)TKTypeForImageData:(NSData *)imageData;

/**
 获取bundle中对应目录中
 所有文件的文件名数组,并按升序排序
 返回文件名数组
 **/
+ (NSArray*)TKLoadBundleAllFilesPathWith:(NSString *)bundleName dirName:(NSString*)dirName;

/**
 加载bunde中，指定目录中的全部图片并返回UIImage Array
 bundleName:对应bundle的名称(不带扩展名称)
 dirName   :bundle中对应的字目录名称
 **/
+ (NSArray *)TKLoadBundleAllImagesWith:(NSString *)bundleName dirName:(NSString*)dirName;

/**
 *将gif图片,分解成UIImage数组
 * gifData： 对应GIF图片数据
 * scale：   缩放倍率
 *开源库: https://github.com/liyong03/YLGIFImage
 *See:  http://nullsleep.tumblr.com/post/16524517190/animated-gif-minimum-frame-delay-browser-compatibility
 *Also: http://blogs.msdn.com/b/ieinternals/archive/2010/06/08/animated-gifs-slow-down-to-under-20-frames-per-second.
 **/
+ (NSArray *)TKGifReleaseImageAryWithData:(NSData *)gifData scale:(CGFloat)scale;

/**
 将GIF图片分解成uiimage数组
 **/
+ (NSArray *)TKGifReleaseImageAryWithData:(NSData *)gifData;

/**
 获取gif图片每帧播放的时间
 **/
+ (NSTimeInterval)TKGifEachFramePlayTime:(NSData *)gifData;


@end
