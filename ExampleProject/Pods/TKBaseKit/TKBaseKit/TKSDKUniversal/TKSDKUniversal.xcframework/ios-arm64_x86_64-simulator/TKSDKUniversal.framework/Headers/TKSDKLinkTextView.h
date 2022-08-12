//
//  TKLinkTextView.h
//  testText
//
//  Created by PC on 2021/10/9.
//

#import <UIKit/UIKit.h>

/**
 功能：禁止UITextView中禁用复制,剪切,选择,全选等popMenu出现
 场景：一般用于展示富文本并且不编辑文本，如展示用户协议。

 参考：https://qa.1r1g.com/sf/ask/99871201/
 */

NS_ASSUME_NONNULL_BEGIN

@interface TKSDKLinkTextView : UITextView

@end

NS_ASSUME_NONNULL_END
