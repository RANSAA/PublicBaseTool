//
//  TKSDKListViewController.h
//  Review
//
//  Created by PC on 2020/9/14.
//  Copyright © 2020 PC. All rights reserved.
//

/**
 功能说明：自定义NavigationBar+UITableView
 实现方式：在ViewController中添加一个UITableView来实现与TKSDKTableViewController相同的功能。
 区别说明：
        TKSDKListViewController：继承TKSDKViewController并在其中添加一个UITableView。
        TKSDKTableViewController：继承UITableViewController，并在其中新建了一个newView,让其与tableView交换位置。
                                注意：self.view返回的是newView,而不是tableView
*/

#import <UIKit/UIKit.h>
#import "TKSDKViewController.h"



NS_ASSUME_NONNULL_BEGIN

@interface TKSDKListViewController : TKSDKViewController <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
/** tableView.leftAnchor距离self.view左边的距离*/
@property(nonatomic, assign) CGFloat tableViewLeftAnchorConstant;
/** tableView.rightAnchor距离self.view右边的距离*/
@property(nonatomic, assign) CGFloat tableViewRightAnchorConstant;
/** tableView.topAnchor距离self.view顶部topLayoutGuide.bottom的距离*/
@property(nonatomic, assign) CGFloat tableViewTopAnchorConstant;
/** tableView.bottomAnchor距离self.view底部bottomLayoutGuide.bottom的距离*/
@property(nonatomic, assign) CGFloat tableViewBottomAnchorConstant;

/**
 初始化
 style：UITableView对应的UITableViewStyle样式
 init相关方法创建的UITableView的style为：UITableViewStylePlain
 注意：该类最好是直接使用，不要在storyboard中使用
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

@end

NS_ASSUME_NONNULL_END
