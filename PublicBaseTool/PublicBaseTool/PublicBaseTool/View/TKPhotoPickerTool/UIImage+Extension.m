//
//  UIImage+Extension.m
//  CreaditCard
//
//  Created by Mac on 2018/1/11.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageModeAlwaysOriginal:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

+ (UIImage *)imageResizableWithImage:(NSString *)name size:(CGFloat)size {
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * size;
    CGFloat h = normal.size.height * size;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

+ (UIImage *)imageModeAlwaysOriginalWithResizableImage:(NSString *)imageName size:(CGFloat)size {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CGFloat w = image.size.width * size;
    CGFloat h = image.size.height * size;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

+ (UIImage *)imageCreateImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
-(UIImage*)imageWithOriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
//    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

+ (UIImage *)imageWithImage:(UIImage *)image leftCapWidth:(NSInteger)leftCapWidth andTopCapHeight:(NSInteger)topCapHeight{
    
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    
    return image;
}

+ (UIImage *)getImageWithImageName:(NSString *)imageName{
    
    UIImage *normalImage = [UIImage imageNamed:imageName];
    
    normalImage = [normalImage stretchableImageWithLeftCapWidth:55 topCapHeight:17];
    
    return normalImage;
}

+ (UIImage *)resizeImageWithOriginalImage:(UIImage *)image
{
    
    if (image.imageOrientation == UIImageOrientationUp || image.imageOrientation == UIImageOrientationDown) {
        
        image = [self imageCompressForOriginalImage:image targetSize:CGSizeMake(720, 720)];
        
    }else if (image.imageOrientation == UIImageOrientationLeft || image.imageOrientation == UIImageOrientationRight){
        
        image = [self imageCompressForOriginalImage:image targetSize:CGSizeMake(720, 720)];
    }
    
    return image;
}

+ (UIImage *)imageCompressForOriginalImage:(UIImage *)sourceImage targetSize:(CGSize)size
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //    if(newImage == nil){
    //        ZLog(@"scale image fail");
    //    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


/**
 图片旋转,
 radians: 旋转的弧度。
 */
+ (UIImage *)imageRotatedByRadinasWithImage:(UIImage *)image radina:(CGFloat)radians
{
    CGAffineTransform t = CGAffineTransformMakeRotation(radians);
    CGRect rotatedRect = CGRectApplyAffineTransform(CGRectMake(0.0 , 0.0, image.size.width, image.size.height), t);
    
    CGSize rotatedsize = rotatedRect.size;
    UIGraphicsBeginImageContext (rotatedsize);
    CGContextRef ctx = UIGraphicsGetCurrentContext ();
    
    CGContextTranslateCTM(ctx, rotatedsize.width/2, rotatedsize.height /2);
    CGContextRotateCTM(ctx,radians);
    CGContextScaleCTM(ctx,1.0, -1.0);//Y方向镜像翻转
    CGContextDrawImage (ctx, CGRectMake (-image.size.width/2, -image.size.height/2, image.size.width, image.size. height),image.CGImage);
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;

}


@end
