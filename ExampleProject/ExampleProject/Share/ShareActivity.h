//
//  ShareActivity.h
//  ExampleProject
//
//  Created by kimi on 2023/10/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 使用系统自带的分享空间
 */
@interface ShareActivity : NSObject
@property(nonatomic, strong,nullable) NSString *shareText;//要分享文本
@property(nonatomic, strong,nullable) NSArray<UIImage *> *images; //要分享的图片数组
@property(nonatomic, strong,nullable) NSArray<NSURL *> *urls; //要分享的URL链接
@property(nonatomic, weak) UIViewController *controller;


- (instancetype)initWithController:(UIViewController *)controller text:(nullable NSString *)shareText images:(nullable NSArray<UIImage *> *)images urls:(nullable NSArray<NSURL *> *)urls;


/** 显示分享页面 */
- (void)show;


@end

NS_ASSUME_NONNULL_END
