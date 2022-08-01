//
//  TabBarViewController.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "TabBarViewController.h"
#import "NavigationViewController.h"
#import "ViewController.h"
#import "OneTableViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"class name:%@",self.class);
    [self setupUI];
}

- (void)setupUI
{
    OneTableViewController *vc1 = [[OneTableViewController alloc] init];
    ViewController *vc2 = [[ViewController alloc] init];
    vc2.view.backgroundColor = UIColor.purpleColor;
    NavigationViewController *nav1 = [[NavigationViewController alloc] initWithRootViewController:vc1];
    NavigationViewController *nav2 = [[NavigationViewController alloc] initWithRootViewController:vc2];
    vc2.title = @"2222";
    [nav1.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor,NSFontAttributeName:kFont15}];
    [nav2.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor}];



    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"BASE" image:[UIImage imageNamed:@"house"] tag:0];
    item1.selectedImage = [UIImage imageNamed:@"house.fill"];
    [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor} forState:UIControlStateNormal];
    [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.purpleColor} forState:UIControlStateSelected];
    nav1.tabBarItem = item1;

    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"OTHER" image:[UIImage imageNamed:@"person"] tag:0];
    item2.selectedImage = [UIImage imageNamed:@"person.fill"];
    [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor} forState:UIControlStateNormal];
    [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.greenColor} forState:UIControlStateSelected];
    nav2.tabBarItem = item2;





    [self addChildViewController:nav1];
    [self addChildViewController:nav2];
    self.delegate = self;


}


// MARK: DELEGATE
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"tabbar vc selected index:%ld",self.selectedIndex);
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
