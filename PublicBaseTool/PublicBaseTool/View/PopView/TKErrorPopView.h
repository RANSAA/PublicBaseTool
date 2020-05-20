//
//  ErrorPopView.h
//  LianCard
//
//  Created by Mac on 2019/3/23.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKErrorPopView : BaseXibView
@property (strong, nonatomic) IBOutlet UIImageView *imgError;
@property (strong, nonatomic) IBOutlet UILabel *labRemark;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (copy  , nonatomic) Block blockDone;

/** 创建并显示网络连接失败页面  */
+ (instancetype)createErrorNoNetworkShowView:(UIView *)view;
/** 创建并显示没有数据的页面  */
+ (instancetype)createErrorNoDataShowView:(UIView *)view;
/** 创建并显示数据加载失败页面  */
+ (instancetype)createErrorLoadFailShowView:(UIView *)view;
/** 设置图片距离顶部的距离*/
- (void)setSpaceTopWithType:(CGFloat)spaceTop;
@end

NS_ASSUME_NONNULL_END
