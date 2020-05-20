//
//  UIImage+TK.m
//  AdultLP
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIImage+TK.h"

@implementation UIImage (TK)

/**
 合并两张图片-本项目用于海报处
 **/
+ (UIImage *)TKMergeImageWith:(UIImage *)image1 two:(UIImage *)image2
{
    CGSize boundSize = CGSizeMake(1080, 1690);
    UIGraphicsBeginImageContext(boundSize);
    [image1 drawInRect:(CGRect){{0,0},boundSize}];
    [image2 drawInRect:(CGRect){{378,1040},{324,324}}];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
