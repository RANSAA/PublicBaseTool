//
//  TKQRCodeTool.m
//  ExampleProject
//
//  Created by kimi on 2023/10/13.
//

#import "TKQRCodeTool.h"
#import <QuartzCore/QuartzCore.h>


@implementation TKQRCodeTool

//MARK: - 生成二维码
/**
 生成二维码
 string: 二维码信息
 centerImage: 二维码中心图片，可选
 PS:如果未指定二维码生成的宽度时，生成二维码的原始大小与被编码的数据长度有关。
 */
+ (nullable UIImage *)qrGenerateQRCodeWith:(NSString *)string centerImage:(nullable UIImage *)centerImage
{
    return [self qrGenerateQRCodeWith:string centerImage:centerImage width:0];
}


/**
 生成二维码
 string: 二维码信息
 centerImage: 二维码中心图片，可选
 width: 指定生成二维码的宽，只有当width>0时才有效。
 PS:如果未指定二维码生成的宽度时，生成二维码的原始大小与被编码的数据长度有关。
 */
+ (nullable UIImage *)qrGenerateQRCodeWith:(NSString *)string centerImage:(nullable UIImage *)centerImage width:(CGFloat)width
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if(!data){
        return nil;
    }
    // 创建 CIFilter，用于生成二维码
    CIFilter *qrCodeFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrCodeFilter setValue:data forKey:@"inputMessage"];
    // 生成二维码图像
    CIImage *qrCodeImage = qrCodeFilter.outputImage;
    
    
    // 放大二维码图像
    CGFloat scale = 10.0;
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    CIImage *transformedQRCode = [qrCodeImage imageByApplyingTransform:transform];
    // 将 CIImage 转换为 UIImage
    UIImage *qrCodeUIImage = [UIImage imageWithCIImage:transformedQRCode];
    
    UIImage *resultImage = qrCodeUIImage;
    
    

    
    //添加中心图片
    if(centerImage){        
        //生成二维码中心的最大宽度,如果大于这个值那么生成的二维码不能被识别出来
        CGFloat maxWidth = 6*scale;
        CGFloat min = MAX(centerImage.size.width, centerImage.size.height);
        if(min>maxWidth){
            NSLog(@"注意二维码中心图片大小不要超过: 60x60");
            centerImage = [self imageResizeWith:centerImage tragetSize:CGSizeMake(maxWidth, maxWidth)];
        }
        
        // 获取中央图像的位置
        CGSize qrCodeSize = qrCodeUIImage.size;
        CGSize centerImageSize = centerImage.size;
        CGPoint center = CGPointMake(qrCodeSize.width / 2, qrCodeSize.height / 2);
        CGRect centerImageRect = CGRectMake(center.x - centerImageSize.width / 2, center.y - centerImageSize.height / 2, centerImageSize.width, centerImageSize.height);

        // 创建一个图形上下文，将二维码和中央图像组合
        UIGraphicsBeginImageContext(qrCodeSize);
        [qrCodeUIImage drawInRect:CGRectMake(0, 0, qrCodeSize.width, qrCodeSize.height)];
        [centerImage drawInRect:centerImageRect];
        UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        resultImage = finalImage;
    }
    
    
    CGSize reSzie = resultImage.size;
    //对生成的二维码整体进行缩放
    if(width > 0){
        reSzie = (CGSize){width,width};
    }
    /**
     注意：最终生成的二维码图片必须要再内存中重新绘制；如果不在内存中绘制本工具中的二维码识别器无法识别二维码信息，即在二维码识别时会出现CIImage创建失败的错误。
     用其他手机来来拍照是能识别到这个生成的二维码信息的。
     */
    resultImage = [self imageResizeWith:resultImage tragetSize:reSzie];
    
    return resultImage;
}

+ (UIImage *)imageResizeWith:(UIImage *)image tragetSize:(CGSize)size
{
   UIGraphicsBeginImageContext(size);
   [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *res = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return res;
}



//AMRK: -  识别二维码

/**
 识别图像中的二维码
 PS:该方法只解码图片中识别到的第一个二维码，因为同一图片中可能有多个二维码信息
 */
+ (nullable NSString *)qrRecognizeFromImage:(UIImage *)image
{
    NSArray *resAtr = [self qrRecognizeAllFromImage:image];
    if(resAtr){
        return resAtr.firstObject;
    }
    return nil;
}

/**
 识别图片中所有的二维码信息。
 return: 返回所有识别到的二维码信息。
 */
+ (nullable NSArray *)qrRecognizeAllFromImage:(UIImage *)image
{
    if(!image || ![image isKindOfClass:UIImage.class]){
        return nil;
    }
    
    // 将 UIImage 转换为 CIImage
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    
    // 创建 CIDetector
    CIDetector *qrDetector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    
    // 获取识别结果
    NSArray *features = [qrDetector featuresInImage:ciImage];
    
    // 如果找到了二维码，返回其内容
    if (features.count > 0) {
        NSMutableArray *resAry = @[].mutableCopy;
        for (CIQRCodeFeature *feature in features) {
            [resAry addObject:feature.messageString];
        }
        return resAry;
    }
    return nil;
}


@end
