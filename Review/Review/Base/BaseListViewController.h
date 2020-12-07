//
//  BaseListViewController.h
//  Review
//
//  Created by PC on 2020/9/13.
//  Copyright © 2020 PC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UIView *navBar;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, assign) UITableViewStyle tableViewStyle;

@end

NS_ASSUME_NONNULL_END
