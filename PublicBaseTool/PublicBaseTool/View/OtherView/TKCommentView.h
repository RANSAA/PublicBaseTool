//
//  TKCommentView.h
//  Evaluate
//
//  Created by mac on 2019/8/9.
//  Copyright © 2019 mac. All rights reserved.
//
/**
 评论条
 **/
#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKCommentView : BaseXibView
@property (strong, nonatomic) IBOutlet UIView *showView;
@property (strong, nonatomic) IBOutlet UITextField *textFieldInput;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
@property (copy  , nonatomic) BlockValue blockSubmit;//发表按钮回调-参数-输入内容
@end

NS_ASSUME_NONNULL_END
