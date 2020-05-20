//
//  UIImage+TK.h
//  AdultLP
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (TK)
/**
 合并两张图片-本项目用于海报处
 **/
+ (UIImage *)TKMergeImageWith:(UIImage *)image1 two:(UIImage *)image2;

@end

NS_ASSUME_NONNULL_END
