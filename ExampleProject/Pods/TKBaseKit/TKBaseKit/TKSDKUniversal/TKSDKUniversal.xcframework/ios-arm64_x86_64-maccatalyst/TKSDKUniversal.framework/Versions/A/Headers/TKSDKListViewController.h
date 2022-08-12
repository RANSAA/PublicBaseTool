//
//  TKSDKListViewController.h
//  Review
//
//  Created by PC on 2020/9/14.
//  Copyright © 2020 PC. All rights reserved.
//

/**
 功能说明：自定义NavigationBar+UITableView
 实现方式：在TKSDKViewController中添加一个UITableView来实现与TKSDKTableViewController相似的功能。
 区别说明：
        TKSDKListViewController：继承TKSDKViewController并在其中添加一个UITableView。
        TKSDKTableViewController：继承UITableViewController。
*/

#import <UIKit/UIKit.h>
#import "TKSDKViewController.h"



NS_ASSUME_NONNULL_BEGIN

@interface TKSDKListViewController : TKSDKViewController <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;

/**
 是否根据TKNavigationBar的高度自动调整tableView.topAnchor的约束值， Default:YES
 */
@property(nonatomic, assign) BOOL autoUpdateTableViewTopAnchor;
/**
 ⚠️:设置tableView.topAnchor距离self.topLayoutGuide.bottom的constant值
 ⚠️:需要先将autoUpdateTableViewTopAnchor的值设置为NO，该方法才会有效。
 */
@property(nonatomic, assign) CGFloat tableViewTopAnchorConstant;
/**
 tableView.leftAnchor距离self.view.leftAnchor的constant值
 */
@property(nonatomic, assign) CGFloat tableViewLeftAnchorConstant;
/**
 tableView.rightAnchor距离self.view.rightAnchor的constant值
 */
@property(nonatomic, assign) CGFloat tableViewRightAnchorConstant;
/**
 tableView.bottomAnchor距离self.view.bottomAnchor的constant值
 */
@property(nonatomic, assign) CGFloat tableViewBottomAnchorConstant;


/**
 初始化
 style：UITableView对应的UITableViewStyle样式
 其它init相关方法创建的UITableView的style为：UITableViewStylePlain
 注意：该类最好是直接使用，不要在storyboard中使用
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

@end

NS_ASSUME_NONNULL_END
