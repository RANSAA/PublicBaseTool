//
//  TKProgressView.h
//  Evaluate
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 mac. All rights reserved.
//
/**
 自定义进度条
 **/
#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKProgressView : BaseXibView
@property (strong, nonatomic) IBOutlet UIView *trackView;//背景
@property (strong, nonatomic) IBOutlet UIView *progressView;//进度
@property (assign, nonatomic) CGFloat progress;//进度0-1
@end

NS_ASSUME_NONNULL_END
