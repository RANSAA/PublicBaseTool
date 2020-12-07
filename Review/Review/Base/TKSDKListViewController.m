//
//  TKSDKListViewController.m
//  Review
//
//  Created by PC on 2020/9/14.
//  Copyright © 2020 PC. All rights reserved.
//

#import "TKSDKListViewController.h"

@interface TKSDKListViewController ()
@property(nonatomic, strong, nullable) NSLayoutConstraint *layTKTableViewTopAnchor;
@property(nonatomic, strong, nullable) NSLayoutConstraint *layTKTableViewLeftAnchor;
@property(nonatomic, strong, nullable) NSLayoutConstraint *layTKTableViewRightAnchor;
@property(nonatomic, strong, nullable) NSLayoutConstraint *layTKTableViewBottomAnchor;
@end

@implementation TKSDKListViewController{
    UITableViewStyle sdkTableViewStyle;
}

/**
 初始化
 style：UITableView对应的UITableViewStyle样式
 init相关方法创建的UITableView的style为：UITableViewStylePlain
 注意：该类最好是直接使用，不要在storyboard中使用
 */
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        sdkTableViewStyle = style;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupChildTableView];
}

- (void)defaultEnabledConfig
{
    [super defaultEnabledConfig];
    sdkTableViewStyle = UITableViewStylePlain;
}


- (void)setupChildTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:sdkTableViewStyle];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat topHeight = self.TKNavigationBar.navViewPortraitHeight;//default 44
    if (@available(iOS 11.0, *)) {
        _layTKTableViewLeftAnchor   = [_tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0];
        _layTKTableViewRightAnchor  = [_tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0];
        _layTKTableViewBottomAnchor = [_tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0.0];
        _layTKTableViewTopAnchor    = [_tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:topHeight];
     } else {
        _layTKTableViewLeftAnchor   = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        _layTKTableViewRightAnchor  = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        _layTKTableViewBottomAnchor = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        _layTKTableViewTopAnchor    = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:topHeight];
     }
    _layTKTableViewLeftAnchor.active = YES;
    _layTKTableViewRightAnchor.active = YES;
    _layTKTableViewTopAnchor.active = YES;
    _layTKTableViewBottomAnchor.active = YES;
}

/** tableView.leftAnchor距离self.view左边的距离*/
- (void)setTableViewLeftAnchorConstant:(CGFloat)tableViewLeftAnchorConstant
{
    _tableViewLeftAnchorConstant = tableViewLeftAnchorConstant;
    self.layTKTableViewLeftAnchor.constant = tableViewLeftAnchorConstant;

}

/** tableView.rightAnchor距离self.view右边的距离*/
- (void)setTableViewRightAnchorConstant:(CGFloat)tableViewRightAnchorConstant
{
    _tableViewRightAnchorConstant = tableViewRightAnchorConstant;
    self.layTKTableViewRightAnchor.constant = tableViewRightAnchorConstant;
}

/** tableView.topAnchor距离self.view顶部topLayoutGuide.bottom的距离*/
- (void)setTableViewTopAnchorConstant:(CGFloat)tableViewTopAnchorConstant
{
    _tableViewTopAnchorConstant = tableViewTopAnchorConstant;
    self.layTKTableViewTopAnchor.constant = tableViewTopAnchorConstant;
}

/** tableView.bottomAnchor距离self.view底部bottomLayoutGuide.bottom的距离*/
- (void)setTableViewBottomAnchorConstant:(CGFloat)tableViewBottomAnchorConstant
{
    _tableViewBottomAnchorConstant = tableViewBottomAnchorConstant;
    self.layTKTableViewBottomAnchor.constant = tableViewBottomAnchorConstant;
}




#pragma mark UITableViewDataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return nil;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
