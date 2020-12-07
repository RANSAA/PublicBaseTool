//
//  TKUpdateAlertView.h
//  LianCard
//
//  Created by Mac on 2019/4/24.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKUpdateAlertView : BaseXibView
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnOK;
@property (strong, nonatomic) IBOutlet UILabel *labTitle;
@property (strong, nonatomic) IBOutlet UILabel *labVersion;
@property (strong, nonatomic) IBOutlet UITextView *textViewRemark;
@property (nonatomic, copy) Block blockDone;
@property (nonatomic, copy) Block blockCancel;
@property (nonatomic, assign) NSInteger type;//用于标记

/** 设置提示信息
 type  0：显示两个按钮 1：显示一个按钮
 */
- (void)setTitle:(NSString *)title version:(NSString *)version remark:(NSString *)remark type:(NSInteger)type;
- (void)show;
- (void)hidden;

@end

NS_ASSUME_NONNULL_END
