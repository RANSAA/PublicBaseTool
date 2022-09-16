//
//  LaunchTextView.h
//  ExampleProject
//
//  Created by PC on 2022/8/11.
//

#import <UIKit/UIKit.h>


/**
 可点击，长按不出现上下文菜单，不跳转，一般用于展示用户协议类型的UITextView。
 点击跳转富文本NSLinkAttributeName。
 */

NS_ASSUME_NONNULL_BEGIN

@interface LaunchTextView : UITextView
/** 点击所有链接时的回调block */
@property(nonatomic, copy) void(^clickLinkAttrCompletion)(NSURL *url);
/** 点击指定链接时的回调block，指定url通过addLinkAttributeName：方法添加。 */
@property(nonatomic, copy) void(^clickLinkCompletion)(NSURL *url);

/**
 添加NSLinkAttributeName协议链接，点击添加url不会跳转，直接通过clickLinkAttrCompletion回调处理。
 */
- (void)addLinkAttributeName:(NSURL *)url;
- (void)addLinkAttributeNames:(NSArray <NSURL *> *)urls;

@end

NS_ASSUME_NONNULL_END
