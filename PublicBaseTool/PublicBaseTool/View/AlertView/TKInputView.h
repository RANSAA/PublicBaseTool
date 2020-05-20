//
//  TKInputView.h
//  Orchid
//
//  Created by Mac on 2019/3/14.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKInputView : BaseXibView
@property (strong, nonatomic) IBOutlet UILabel *labTitle;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *btnOK;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (nonatomic, copy) BlockValue blockDone;
@property (nonatomic, copy) Block blockCancel;

/**
 *有两个按钮: OK , Cancel
 *创建并添加到 view 上
 **/
+ (TKInputView *)TKInputViewWithTitle:(NSString *)title;
/**
 *只有一个 OK 按钮
 *创建并添加到 view 上*
 */
+ (TKInputView *)TKInputViewDialogWithTitle:(NSString *)title;


@end

NS_ASSUME_NONNULL_END
