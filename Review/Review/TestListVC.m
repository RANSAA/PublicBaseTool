//
//  TestListVC.m
//  Review
//
//  Created by PC on 2020/9/13.
//  Copyright © 2020 PC. All rights reserved.
//

#import "TestListVC.h"

@interface TestListVC ()

@end

@implementation TestListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor TKLightColor:UIColor.whiteColor darkColor:UIColor.blackColor];

    
    [self add];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(112.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tableViewTopAnchorConstant = 120;
        self.tableViewLeftAnchorConstant = 50;
        self.tableViewRightAnchorConstant = -50;
        self.tableViewBottomAnchorConstant = -50;
    });

}


- (void)add
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
     self.tableView.rowHeight = 44;


    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg"]];
    img.alpha = 0.25;
    img.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:img];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 22;
}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"row:%ld",indexPath.row];
    cell.backgroundColor = UIColor.grayColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}


#define HMScreenMaxWidth1024 1334
#define HMScreenMinWidth768 750
#define HMDockMaxWidth 750

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"viewWillTransitionToSize-----1");
//    NSLog(@"size:%@",NSStringFromCGSize(size));

       //动画同步 --> 系统默认0.25 而选择是0.4

       [UIView animateWithDuration:[coordinator transitionDuration] animations:^{

           //方法一:

//           if (size.width == HMScreenMaxWidth1024) {
//
//               NSLog(@"横屏");
//
//               self.dockView.width = HMDockMaxWidth;
//
//               self.dockView.height = HMScreenMinWidth768;
//
//           } else {
//
//               NSLog(@"竖屏");
//
//               self.dockView.width = HMDockMinWidth;
//
//               self.dockView.height = HMScreenMaxWidth1024;
//
//           }



       }];
}

- (void)statusBarOrientationChange
{
    NSLog(@"statusBarOrientationChange------2");
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews------3");
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
