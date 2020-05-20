//
//  TKTextView.h
//  AdultLP
//
//  Created by mac on 2019/7/25.
//  Copyright © 2019 mac. All rights reserved.
//

/**
 自定义UITextView，支持placeHolder,设置
 **/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKTextView : UITextView
/** 占位提示文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位提示文字颜色*/
@property (nonatomic, strong) UIColor  *placeholderColor;
/** 占位提示文字字体  */
@property (nonatomic, strong) UIFont *placeholderFont;

/**
 获取输入框中的文字,与text有点区别
 用于输入框带提示文字的时候
 **/
@property (nonatomic, copy, readonly) NSString *textInput;

@end

NS_ASSUME_NONNULL_END
