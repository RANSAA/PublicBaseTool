//
//  UIImage+TKSDK.m
//  Review
//
//  Created by PC on 2020/9/17.
//  Copyright © 2020 PC. All rights reserved.
//

#import "UIImage+TKSDK.h"
#import <Accelerate/Accelerate.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation UIImage (TKSDK)


/**
 *功能：添加高斯模糊效果，推荐使用该方法进行高斯模糊处理
 *image:是图片
 *blur:模糊程度，有效值 0.0~2.0
 */
+(UIImage *)TKBlurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
{
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }

    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
//    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */

    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;

    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);

    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);

    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));

    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);


    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);

    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);


    if (error) {
        NSLog(@"error from convolution %ld", error);
    }

    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));

    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);

    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);

    CGImageRelease(img);
    CGImageRelease(imageRef);

    return returnImage;
}


/**
 *功能：高斯模糊，使用CoreImage实现，速度比较块，但是生成的图片比较大（相对于TKBlurryGaussianSpeedMinImage：）
 *image:输入的图片
 *blur:模糊度，默认8
*/
+(UIImage*)TKBlurryGaussianSpeedMaxImage:(UIImage*)image withBlurLevel:(CGFloat)blur
{
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage ];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];//CIGaussianBlur  CIBokehBlur
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(blur) forKey:kCIInputRadiusKey];

    CIImage *outputImage = filter.outputImage;
    UIImage *resultImage = [UIImage imageWithCIImage:outputImage];
    return resultImage;

    //输出kCICategoryBlur中的所有滤镜
/**
    NSArray* filters =  [CIFilter filterNamesInCategory:kCICategoryBlur];
    for (NSString* filterName in filters) {
    NSLog(@"filter name:%@",filterName);
        // 我们可以通过filterName创建对应的滤镜对象
        CIFilter* filter = [CIFilter filterWithName:filterName];
        NSDictionary* attributes = [filter attributes];
        // 获取属性键/值对（在这个字典中我们可以看到滤镜的属性以及对应的key）
        NSLog(@"filter attributes:%@",attributes);
    }
*/
}


/**
 *功能：高斯模糊，使用CoreImage实现，速度很慢,生成的图片相对比较小(相对于TKBlurryGaussianSpeedMaxImage：而言)
 *image:输入的图片
 *blur:模糊度，默认8
 */
+(UIImage*)TKBlurryGaussianSpeedMinImage:(UIImage*)image withBlurLevel:(CGFloat)blur
{
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage ];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(blur) forKey:kCIInputRadiusKey];
    CIImage *outputImage = filter.outputImage;

    //创建CIContext对象
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:outImageRef];
    CGImageRelease(outImageRef);


    //输出kCICategoryBlur中的所有滤镜
/**
    NSArray* filters =  [CIFilter filterNamesInCategory:kCICategoryBlur];
    for (NSString* filterName in filters) {
    NSLog(@"filter name:%@",filterName);
        // 我们可以通过filterName创建对应的滤镜对象
        CIFilter* filter = [CIFilter filterWithName:filterName];
        NSDictionary* attributes = [filter attributes];
        // 获取属性键/值对（在这个字典中我们可以看到滤镜的属性以及对应的key）
        NSLog(@"filter attributes:%@",attributes);
    }
*/
    return resultImage;
}

/**
 * 根据颜色-创建矩形图片
 * color:颜色
 * size: 矩形大小
 * alpha:透明度
 */
+(UIImage*)TKCreateSquareWithColor:(UIColor*)color size:(CGSize)size alpha:(CGFloat)alpha
{
    alpha = alpha>1?1:(alpha<0?0:alpha);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){{0,0},size});

    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  resultImage;
}

/**
 * 根据颜色－创建圆形/椭圆
 * color:颜色
 * size:圆形/椭圆的大小
 * alpha:透明度
 */

+(UIImage*)TKCreateCircularWithColor:(UIColor*)color size:(CGSize)size alpha:(CGFloat)alpha
{
    alpha = alpha>1?1:(alpha<0?0:alpha);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillEllipseInRect(context, (CGRect){{0,0},size});

    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  resultImage;

}

/**
 功能：创建一个圆环
 color：颜色
 radius:圆环外径的长度
 width: 圆环的宽度
 alpha: 透明度
 */
+ (UIImage*)TKCreateCircularRingWithColor:(UIColor*)color radius:(CGFloat)radius  width:(CGFloat)width alpha:(CGFloat)alpha
{
    alpha = alpha>1?1:(alpha<0?0:alpha);

    CGSize size = CGSizeMake(radius*2, radius*2);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);

    CGContextSetStrokeColorWithColor(context, color.CGColor);//画笔线的颜色
    CGContextSetLineWidth(context, width);//线的宽度
    CGContextAddArc(context, radius, radius, radius-width/2.0, 0, 2* M_PI, 0); //添加一个圆
//    CGContextStrokePath(context);
    CGContextDrawPath(context, kCGPathStroke); //绘制圆环路径


//    CGContextSetFillColorWithColor(context, UIColor.redColor.CGColor);
////    CGContextSetLineWidth(context, radius-width);//线的宽度
//    CGContextAddArc(context, radius, radius, radius-width/2.0-width, 0, 2* M_PI, 0); //添加一个圆
//    CGContextFillPath(context);
////    CGContextDrawPath(context, kCGPathFill);//绘制填充内部实心圆


    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  resultImage;
}

/**
 功能：根据颜色数组创建等宽度的同心圆
 colors:颜色数组
 radius:圆的半径
 alpha：透明度
 */
+ (UIImage *)TKCreateConcentricCirclesWithColors:(NSArray <UIColor*> *)colors radius:(CGFloat)radius alpha:(CGFloat)alpha
{

    NSMutableArray *proportions = @[].mutableCopy;
    [colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [proportions addObject:@(1)];
    }];
    return  [self TKCreateConcentricCirclesWithColors:colors proportions:proportions radius:radius alpha:alpha];
}

/**
 功能：根据图片数组与对应的比例数组创建同心圆环，每个圆环的宽度由proportions决定
 colors:颜色数组
 proportions:每一个圆环宽度占比数组,每个item的值必须大于等于0
 radius:圆的半径
 alpha：透明度
 注意：colors.count == proportions.count
 */
+ (UIImage *)TKCreateConcentricCirclesWithColors:(NSArray <UIColor*> *)colors  proportions:(NSArray<NSNumber *> *)proportions radius:(CGFloat)radius alpha:(CGFloat)alpha
{
    if (colors.count != proportions.count) {
        NSLog(@"Error: TKCreateConcentricCirclesWithColors -> colors.count != proportions.count");
        return nil;
    }
    alpha = alpha>1?1:(alpha<0?0:alpha);
    CGFloat allNum = 0;
    for (NSNumber *num in proportions) {
        allNum += [num floatValue];
    }
    CGFloat itemWidthAry [proportions.count];
    NSInteger index = 0;
    for (NSNumber *num in proportions) {
        CGFloat width = num.floatValue/allNum*radius;
        itemWidthAry[index++] = width;
    }

    CGSize size = CGSizeMake(radius*2, radius*2);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);

    index = 0;
    CGFloat rWidth = itemWidthAry[index];
    CGFloat curRadius = radius-rWidth/2.0;
    CGFloat tmpsStrokeWidth = 0;//记录已经画了圆环的宽度
    for (UIColor *cor in colors) {//画圆环顺序，从外到内。
        CGContextSetStrokeColorWithColor(context, cor.CGColor);//画笔线的颜色
        CGContextSetLineWidth(context, rWidth);//线的宽度
        CGContextAddArc(context, radius, radius, curRadius, 0, 2* M_PI, 0); //添加一个圆
        CGContextStrokePath(context);

        tmpsStrokeWidth += rWidth;
        rWidth = itemWidthAry[++index];
        curRadius = radius-tmpsStrokeWidth-rWidth/2.0;
    }

    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  resultImage;
}

/**
 UIImage 转 Base64字符串
 */
+ (NSString *)TKBase64ConvertToStringWithImage:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    NSString *base64 = [data base64EncodedStringWithOptions:0];
    return base64;
}

/**
 Base64字符串 转 UIImage
 */
+ (UIImage *)TKBase64ConvertToImageWithString:(NSString *)str
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:str options:0];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

/**
 将图片大小进行等比例缩放
 image:原始图片
 scale：缩放比例
 PS:处理之后的图片占用内存不会变大，如果需要网络传输请进行压缩一下：UIImageJPEGRepresentation()
 */
+ (UIImage *)TKImageCompressScaleWith:(UIImage *)image scale:(CGFloat)scale
{
    scale = scale<0.1?1:scale;
    CGSize originalSize = image.size;
    originalSize.width *= image.scale;
    originalSize.height *= image.scale;
    CGSize scaleSize = originalSize;
    scaleSize.width *= scale;
    scaleSize.height *= scale;
    CGRect rect = (CGRect){CGPointZero,scaleSize};
    UIGraphicsBeginImageContext(scaleSize);
    [image drawInRect:rect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

/**
 指定图片的宽或者高进行等比例缩放
 image:原始图片
 widthOrHeight:图片的宽或者高的大小
 type：缩放类型  1：按照宽度进行缩放  0:按照高度进行缩放
 PS:处理之后的图片占用内存不会变大，如果需要网络传输请进行压缩一下：UIImageJPEGRepresentation()
 */
+ (UIImage *)TKImageCompressTragetWidthOrHeightWith:(UIImage *)image widthOrHeight:(CGFloat)widthOrHeight type:(NSInteger)type
{
    widthOrHeight = widthOrHeight>0?widthOrHeight:50;
    CGSize originalSize = image.size;
    originalSize.width *= image.scale;
    originalSize.height *= image.scale;
    CGFloat scale = 1.0;
    if (type == 1) {
        scale = widthOrHeight/originalSize.width;
    }else{
        scale = widthOrHeight/originalSize.height;
    }
    CGSize scaleSize = originalSize;
    scaleSize.width *= scale;
    scaleSize.height *= scale;
    CGRect rect = (CGRect){CGPointZero,scaleSize};
    UIGraphicsBeginImageContext(scaleSize);
    [image drawInRect:rect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

/**
 将图片以最小的一边为标准，自动裁剪为正方形
 PS:处理之后的图片占用内存不会变大，如果需要网络传输请进行压缩一下：UIImageJPEGRepresentation()
 */
+ (UIImage *)TKImageTailoringToSquareWithImage:(UIImage *)image
{
    CGSize originalSize = image.size;
    originalSize.width *= image.scale;
    originalSize.height *= image.scale;
    CGFloat width = 0;
    CGPoint point = CGPointZero;
    if (originalSize.width<originalSize.height) {
        width = originalSize.width;
        point.x = 0;
        point.y = (originalSize.height-originalSize.width)/2.0;
    }else{
        width = originalSize.height;
        point.y = 0;
        point.x = (originalSize.width-originalSize.height)/2.0;
    }
    CGSize scaleSize = CGSizeMake(width, width);
    CGRect rect = (CGRect){point,scaleSize};
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    //返回剪裁后的图片
    return newImage;
}

/**
 对图片指定区域进行裁剪
 tragetFrame:目标区域
 PS:tragetFrame的大小以图片的实际尺寸为参考，如果超出区域剪切的图片会有空白
 */
+ (UIImage *)TKImageTailoringToSquareWithImage:(UIImage *)image tragetFrame:(CGRect)tragetFrame
{
    CGSize originalSize = image.size;
    originalSize.width *= image.scale;
    originalSize.height *= image.scale;
    if ((tragetFrame.origin.x+tragetFrame.size.width > originalSize.width) || (tragetFrame.origin.y+tragetFrame.size.height > originalSize.height) )  {
        NSLog(@"⚠️⚠️:剪切的区域大于图片原始大小，会有空白区域被剪切，请注意修改");
    }
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, tragetFrame);
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    //返回剪裁后的图片
    return newImage;
}

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
+ (UIImage *)TKImageTailoringToSquareWithImage:(UIImage *)image tragetSize:(CGSize)tragetSize  type:(NSInteger)type
{
    type = type<0?0:(type>4?4:type);
    CGSize originalSize = image.size;
    originalSize.width *= image.scale;
    originalSize.height *= image.scale;
    //修正最大边长
    tragetSize.width = tragetSize.width>originalSize.width?originalSize.width:tragetSize.width;
    tragetSize.height = tragetSize.height>originalSize.height?originalSize.height:tragetSize.height;
    CGPoint point = CGPointZero;
    switch (type) {
        case 0:
            point.x = 0;
            point.y = 0;
            break;
        case 1:
            point.x = 0;
            point.y = originalSize.height-tragetSize.height;
            break;
        case 2:
            point.x = originalSize.width - tragetSize.width;
            point.y = originalSize.height-tragetSize.height;
            break;
        case 3:
            point.y = 0;
            point.x = originalSize.width-tragetSize.width;
            break;
        case 4:
            point.x = (originalSize.width-tragetSize.width)/2.0;
            point.y = (originalSize.height-tragetSize.height)/2.0;
            break;
        default:
            break;
    }

    CGRect rect = (CGRect){point,tragetSize};
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    //返回剪裁后的图片
    return newImage;
}

/**
 * 将图片旋转按顺时针方向进行旋转，旋转点是以左上角为原点进行的
 * image:待旋转的图
 * angle:旋转角度，有效值为0~360
 * isExpand:是否扩展，如果不扩展，那么生成的图像大小不变(和原图片相同)，但被截掉一部分
 */
+ (UIImage *)TKImageRotationWithImage:(UIImage *)image angle:(NSInteger)angle isExpand:(BOOL)isExpand
{
    angle %= 360;
    if (angle == 0) {
        return image;
    }
    CGSize imgSize = image.size;
    imgSize.width  *= image.scale;
    imgSize.height *= image.scale;
    CGSize outputSize = imgSize;
    if (isExpand) {
        CGRect rect = CGRectMake(0, 0, imgSize.width, imgSize.height);
        //旋转
        rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeRotation(angle*M_PI/180.0));
        outputSize = CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
    }
    UIGraphicsBeginImageContext(outputSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, outputSize.width / 2, outputSize.height / 2);
    CGContextRotateCTM(context, angle*M_PI/180.0);
    CGContextTranslateCTM(context, -imgSize.width / 2, -imgSize.height / 2);
    [image drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

/**
 获取UIimage的大小(kb，其实是内存中所占的大小),转化成NSData对象进行计算的
 如果是高清大图，可直接通过NSFileManager获取
 */
+ (NSInteger)TKImageMemorySizeWithImage:(UIImage *)image
{
    NSData * imageDate = UIImagePNGRepresentation(image);
    NSInteger fileSize = [imageDate length] /1024.0;
    return fileSize;
}

/**
 获取图片的实际类型
 如：jpeg,png,gif,tiff
 */
+ (NSString *)TKImageTypeWithImageData:(NSData *)imageData
{
    if (!imageData) {
        return nil;
    }
    NSString *type = @"unknown";
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)(imageData), NULL);
    CFStringRef fileType = CGImageSourceGetType(imageSource);//如kUTTypeGIF
    if (UTTypeConformsTo(fileType, kUTTypeGIF)) {
    }
    type = [NSString stringWithFormat:@"%@",fileType];
    CFRelease(fileType);
    CFRelease(imageSource);
    return type;

//    uint8_t c;
//    [imageData getBytes:&c length:1];
//    NSLog(@"图片类型:0x%x",c);
//    switch (c) {
//        case 0xFF:
//            return @"image/jpeg";
//        case 0x89:
//            return @"image/png";
//        case 0x47:
//            return @"image/gif";
//        case 0x49:
//        case 0x4D:
//            return @"image/tiff";
//    }
//    return nil;
}

/**
 * 将UIImage图片,分解成UIImage帧数组
 * data： 图片对应的NSData数据
 * scale：缩放倍率
 * 开源库: https://github.com/liyong03/YLGIFImage
 * See:  http://nullsleep.tumblr.com/post/16524517190/animated-gif-minimum-frame-delay-browser-compatibility
 * Also: http://blogs.msdn.com/b/ieinternals/archive/2010/06/08/animated-gifs-slow-down-to-under-20-frames-per-second.
 **/
+ (NSArray *)TKImageDecoderImgAryWithData:(NSData *)data scale:(CGFloat)scale
{
    if (!data) {
        return @[];
    }
    NSMutableArray *images = [[NSMutableArray alloc]initWithCapacity:0];
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)(data), NULL);
     //判断资源类型是否是gif类型
     BOOL isGifImage = imageSource && UTTypeConformsTo(CGImageSourceGetType(imageSource), kUTTypeGIF) && CGImageSourceGetCount(imageSource) > 1;
     if (isGifImage) {
         CFRetain(imageSource);
         //获取gif一共有多少帧
         NSUInteger numberOfFrames = CGImageSourceGetCount(imageSource);
         for (NSUInteger i=0; i<numberOfFrames; i++) {
             //获取对应帧
             CGImageRef image = CGImageSourceCreateImageAtIndex(imageSource, i, NULL);
             if (image != NULL) {
                 [images addObject:[UIImage imageWithCGImage:image scale:scale orientation:UIImageOrientationUp]];
                 CFRelease(image);
             }
         }
         CFRelease(imageSource);
     }else{
         UIImage *img = [UIImage imageWithData:data];
         [images addObject:img];
     }
     return images;
}


/**
 获取gif图片每帧播放时间
 */
+ (NSTimeInterval)TKImageGifFramePlayTimeWithData:(NSData *)gifData
{
    NSTimeInterval frameDuration = 0.0;
    CFDictionaryRef theImageProperties;
    if (gifData) {
        CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)(gifData), NULL);
        if ((theImageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, NULL))) {
            CFDictionaryRef gifProperties;
            if (CFDictionaryGetValueIfPresent(theImageProperties, kCGImagePropertyGIFDictionary, (const void **)&gifProperties)) {
                const void *frameDurationValue;
                if (CFDictionaryGetValueIfPresent(gifProperties, kCGImagePropertyGIFUnclampedDelayTime, &frameDurationValue)) {
                    frameDuration = [(__bridge NSNumber *)frameDurationValue doubleValue];
                    if (frameDuration <= 0) {
                        if (CFDictionaryGetValueIfPresent(gifProperties, kCGImagePropertyGIFDelayTime, &frameDurationValue)) {
                            frameDuration = [(__bridge NSNumber *)frameDurationValue doubleValue];
                        }
                    }
                }
                CFRelease(gifProperties);
            }
            CFRelease(imageSource);
            CFRelease(theImageProperties);
        }
#ifndef OLExactGIFRepresentation
        if (frameDuration < 0.02 - FLT_EPSILON) {
            frameDuration = 0.1;
        }
#endif
    }
    return frameDuration;
}




@end
