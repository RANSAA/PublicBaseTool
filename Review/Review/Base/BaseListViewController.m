//
//  BaseListViewController.m
//  Review
//
//  Created by PC on 2020/9/13.
//  Copyright © 2020 PC. All rights reserved.
//

#import "BaseListViewController.h"

@interface BaseListViewController ()

@end

@implementation BaseListViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;

        _tableViewStyle = style;
    }
    return  self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;

        if (@available(iOS 13.0, *)) {
            _tableViewStyle = UITableViewStyleInsetGrouped;
        } else {
            // Fallback on earlier versions
        }
    }
    return self;
}


//- (void)loadView
//{
//    [super loadView];
//    _tableViewStyle = UITableViewStylePlain;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupChileTableView];
}

- (void)setupChileTableView
{
    self.view.backgroundColor = UIColor.whiteColor;

    _navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 44)];
    _navBar.backgroundColor = UIColor.redColor;
    [self.view addSubview:_navBar];


    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:_tableViewStyle];
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.origin.y = 44;
    rect.size.height -= 44;
    self.tableView.frame = rect;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];



}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 110;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return nil;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}


@end
