//
//  TKItemView.h
//  LianCard
//
//  Created by Mac on 2019/3/27.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN

@class TKItemView;
@protocol TKItemViewDelegate <NSObject>
@optional
- (void)TKItemViewClickViewView:(TKItemView*)view;
@end

@interface TKItemView : BaseXibView
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layVviewSpaceY;//V 的水平约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layLabTitleToViewSpaceTop;//labTitle顶部距离v的距离
@property (strong, nonatomic) IBOutlet UIImageView *layImgToViewSpaceBottom;//img底部距离v的距离

@property (strong, nonatomic) IBOutlet UIView *vView;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *labTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnMask;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger index;
@property (weak  , nonatomic) id<TKItemViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
