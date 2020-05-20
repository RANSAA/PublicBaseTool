//
//  TKSimplePhotoPicker.h
//  Evaluate
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 mac. All rights reserved.
//
/**
 简单的图片选择器
 UIImagePickerController
 **/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TKSimplePhotoPickerReturn)(UIImage *image);
typedef void(^TKSimplePhotoPickerNavStyle)(UINavigationBar *navigationBar);

@protocol TKSimplePhotoPickerViewDelegate <NSObject>
@optional
- (void)TKSimplePhotoPickerViewClickIndex:(NSInteger)index;
@end

@class TKSimplePhotoPickerView;
@interface TKSimplePhotoPicker : NSObject
/** 获取到图片后回调block */
@property (nonatomic, copy)TKSimplePhotoPickerReturn   blockDone;
/** 设置UIImagePickerController导航条的样式 */
@property (nonatomic, copy)TKSimplePhotoPickerNavStyle blockPickerStyle;
/** 是否允许编辑图片 **/
@property (nonatomic, assign) BOOL allowsEditing;

/**
 创建并显示
 isShear:是否剪切图片
 **/
+ (instancetype)showWithController:(UIViewController *)controller isShear:(BOOL)isShear;

@end



@interface TKSimplePhotoPickerView : BaseXibView
@property (strong, nonatomic,nullable) id<TKSimplePhotoPickerViewDelegate> delegate;
- (void)removeView;
@end

NS_ASSUME_NONNULL_END
