//
//  TKSearchBar.h
//  Orchid
//
//  Created by Mac on 2019/1/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

/**
 *  自定义的搜索框
 **/

#import "BaseXibView.h"
@class TKSearchBar;
@protocol TKSearchBarDelegate <NSObject>
@optional
/**
 点击按钮回调，
 如果当前方法实现，则搜索按钮，TKSearchBarWith：searchText：无效
 键盘上的搜索按钮依然有效
 **/
- (void)TKSearchBarWith:(TKSearchBar *)view clickBtn:(UIButton *)clickBtn;
/** 搜索回调 */
- (void)TKSearchBarWith:(TKSearchBar *)view searchText:(NSString *)searchText;
/** 输入框清除按钮回调  */
- (void)TKSearchBarDidClearWith:(TKSearchBar *)view;
@end

@interface TKSearchBar : BaseXibView
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layShowViewLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layShowViewRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layShowViewHeight;
@property (strong, nonatomic) IBOutlet UIView *showView;
@property (strong, nonatomic) IBOutlet UIImageView *imgSearch;//左边搜索图标
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;//搜索框
@property (strong, nonatomic) IBOutlet UIButton    *btnSearch;//右边搜索按钮
@property (nonatomic, copy)   NSString *text;
@property (nonatomic, copy)   NSString *placeholder;
@property (nonatomic, weak) id<TKSearchBarDelegate> delegate;


/**
 设置搜索按钮是否隐藏
 **/
- (void)setSearchButtonIsHidden:(BOOL)isHidden;

/**
 设置搜索框样式
 0:默认样式，搜索按钮显示，左边距10
 1:不显示搜索按钮，左右边距为0
 **/
- (void)setSearchBarStyleWithType:(NSInteger)type;


@end
