//
//  TKTextFieldFactory.h
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UITextFieldCustom.h"

NS_ASSUME_NONNULL_BEGIN

/**
 统一生成TextField对象，TextField的具体类型由内部+ (kUITextField *)factoryObj方法决定。
 */


@interface TKTextFieldFactory : NSObject
+ (UITextField *)defaultStyle;
+ (void)setDefaultStyleWith:(UITextField *)textField;

/** 左边带标题的输入框  */
+ (UITextField *)titleInput;
+ (void)setTitleInput:(UITextField *)textField;

/**
 UISearchBar搜索框中的样式
 */
+ (UITextField *)searchBarStyle;
+ (void)setSearchBarStyleWith:(UITextField *)textField;
@end

NS_ASSUME_NONNULL_END
