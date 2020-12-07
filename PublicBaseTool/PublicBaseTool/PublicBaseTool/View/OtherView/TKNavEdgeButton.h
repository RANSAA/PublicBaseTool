//
//  TKNavEdgeButton.h
//  LianCard
//
//  Created by Mac on 2019/3/25.
//  Copyright © 2019年 Mac. All rights reserved.
//
/**
 导航条-带数字的自定义btn
 **/
#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKNavEdgeButton : BaseXibView
@property (strong, nonatomic) IBOutlet UIButton *btnMask;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *labEdge;

/**
 设置红点显示数字，如果小于1，则不显示红点
 **/
- (void)setEdgeNum:(NSInteger)num;

/**
 设置红点显示字符串，如果字符串长度小于1，为nil，则红点不显示
 **/
- (void)setEdgeText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
