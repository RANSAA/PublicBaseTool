//
//  UISearchBar+Factory.h
//  ExampleProject
//
//  Created by PC on 2022/8/1.
//

#import <UIKit/UIKit.h>

/**
 注意如果直接使用UISearchBar定制搜索框效果不好时，可以使用UITextFeild与其它控件定制搜索框，推荐UITextFeild方式(可定制程度高)。
 */

NS_ASSUME_NONNULL_BEGIN

@interface UISearchBar (Factory)
/**
 输入框VIEW
 */
@property(nonatomic, readonly, strong, nullable) UITextField *textField;

/**
 输入框所在区域的backgroundView
 PS:iOS13之后直接使用内部textField的背景修改方案(iOS13+ 获取为空)
 */
@property(nonatomic, readonly, strong, nullable) UIView* backgroundView;

@end

NS_ASSUME_NONNULL_END
