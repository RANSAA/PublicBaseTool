//
//  TKStarsView.h
//  Evaluate
//
//  Created by mac on 2019/8/9.
//  Copyright © 2019 mac. All rights reserved.
//
/**
 star item 的高宽会更具当前view的高度进行自动计算
 PS:view有效宽度计算方式：item-height*5 + itemSpace*4;
 **/
#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKStarsView : BaseXibView
@property(nonatomic, strong) NSMutableArray *starAry;//用于装载星星
@property(nonatomic, assign) BOOL isEnabledHalf;//是否启用半星显示，默认允许
@property(nonatomic, assign) BOOL isSelected;//是否允许选择，默认允许
@property(nonatomic, assign) CGFloat itemSpace;//item间隔，默认15
@property(nonatomic, strong) UIImage *imageNormal;//默认图标
@property(nonatomic, strong) UIImage *imageSelected;//选中图标
@property(nonatomic, strong) UIImage *imageSelectHalf;//选中一半的图标
@property(nonatomic, copy  ) NSString *starNum;//总星数
@property(nonatomic, assign) NSInteger starType;//0:5星 1：10星

/**
 设置显示星数，范围0.0-5.0星
 设置星级显示
 是否允许半星显示由isEnabledHalf确认
 不足一星的都按半星显示
 **/
- (void)setStarNumber:(CGFloat)star;

@end

NS_ASSUME_NONNULL_END
