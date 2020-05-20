//
//  TKTriangleButton.h
//  LianCard
//
//  Created by Mac on 2019/3/30.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN

@class TKTriangleButton;
@protocol TKTriangleButtonDelegate <NSObject>
@optional
- (void)TKTriangleButtonClick:(TKTriangleButton*)view;
@end

@interface TKTriangleButton : BaseXibView
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layImgToBtnSpaceLeft;//图标距离title的距离
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layImgWidth;
@property (strong, nonatomic) IBOutlet UIButton *btnTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgTips;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) BOOL imgIsTouch;//图标是否可以点击，默认可以
@property (weak  , nonatomic) id<TKTriangleButtonDelegate>delegate;



@end

NS_ASSUME_NONNULL_END
