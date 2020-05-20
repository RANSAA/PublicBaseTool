//
//  TKItemTitleView.h
//  LianCard
//
//  Created by Mac on 2019/3/30.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN
@class TKItemTitleView;
@protocol TKItemTitleViewDelegate <NSObject>
@optional
/** 点击回调 */
- (void)TKItemTitleViewClick:(TKItemTitleView *)view;
@end



@interface TKItemTitleView : BaseXibView
@property (strong, nonatomic) IBOutlet UIView *vView;
@property (strong, nonatomic) IBOutlet UILabel *labTop;
@property (strong, nonatomic) IBOutlet UILabel *labBottom;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layLabTopTovViewSpaceBottom;//lab top 距离水平中线的距离
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layLabBottomTovViewSpaceTop;//lab bottom 距离水平中线的距离
@property (strong, nonatomic) IBOutlet UIButton *btnMask;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic) NSInteger index;
@property (weak  , nonatomic) id<TKItemTitleViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
