//
//  TKSystemPhotoPicker.h
//  TKUIKitDemo
//
//  Created by PC on 2021/1/4.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKUIImportSDK.h"


/**
 功能：简单封装UIImagePickerController
    1.delegate与block可以二选一获取照片
    2.设置navBar样式时需要注意
    3。如果需要将照片上传可以使用YYImage对图片压缩
 */

/**
 该文件基本上可以被弃用了，直接使用三方工具如:TZImagePickerController
 */

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,TKSystemPhotoPickerStyle){
    TKSystemPhotoPickerPhoto = 0,
    TKSystemPhotoPickerVideo = 1,
    TKSystemPhotoPickerAll   = 2
};

@class TKSystemPhotoPicker;
@protocol TKSystemPhotoPickerDelegate <NSObject>
@optional
/** 选中图片回调 */
- (void)TKSystemPhotoPicker:(TKSystemPhotoPicker *)picker resultImage:(UIImage *)image;
/** 选中视频回调 */
- (void)TKSystemPhotoPicker:(TKSystemPhotoPicker *)picker resultVideo:(NSURL *)videoURL;
/** 取消 */
- (void)TKSystemPhotoPickerCancel:(TKSystemPhotoPicker *)picker;

@end


@interface TKSystemPhotoPicker : NSObject
@property(nonatomic, assign) NSInteger tag;
/** 是否将照片保存到相册*/
@property(nonatomic, assign) BOOL isSaveAlbum;
/** 是否允许编辑图片,可以对图片进行指定区域裁剪 **/
@property(nonatomic, assign) BOOL allowsEditing;
/** 是否裁剪图片(将图片以最小的一边为标准，自动裁剪为正方形)*/
@property(nonatomic, assign) BOOL isShear;
/**
 回传image.navigationBar修改样式，iOS13.0+直接使用[UINavigationBar appearance]设置
 */
@property(nonatomic, copy, nullable)  BlockValue blockNavigation;

@property(nonatomic, copy, nullable)  BlockValue blockImageDone;//选中图片回调(UIImage)
@property(nonatomic, copy, nullable)  BlockValue blockVideoDone;//选中视频回调(Video URL)
@property(nonatomic, weak, nullable)  id<TKSystemPhotoPickerDelegate> delegate;

//照片
+ (instancetype)showPhotoWithController:(UIViewController *)controller isShear:(BOOL)isShear;
//视频
+ (instancetype)showVideoWithController:(UIViewController *)controller isShear:(BOOL)isShear;
//创建
+ (instancetype)showWithController:(UIViewController *)controller stylew:(TKSystemPhotoPickerStyle)style allowsEditing:(BOOL)allowsEditing isShear:(BOOL)isShear;

@end

NS_ASSUME_NONNULL_END
