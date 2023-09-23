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
#import "TwoTableViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"class name:%@",self.class);
    [self setupUI];
    [self updateKeyWindows];
}

- (void)setupUI
{
    OneTableViewController *vc1 = [[OneTableViewController alloc] init];
    TwoTableViewController *vc2 = [[TwoTableViewController alloc] init];
    vc2.view.backgroundColor = [UIColor.grayColor colorWithAlphaComponent:0.3];
    vc2.title = @"blank";
    vc1.title = @"示例";
    
    /**
     ios 15 UITabbar及UINavigationBar的背景颜色问题
     PS: https://blog.csdn.net/LiqunZhang/article/details/120828466
     */

    /**
    关于导航条相关设置可以查看:OneTableViewController , BaseViewController
     */
    NavigationViewController *nav1 = [[NavigationViewController alloc] initWithRootViewController:vc1];
    NavigationViewController *nav2 = [[NavigationViewController alloc] initWithRootViewController:vc2];
    [nav1.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor,NSFontAttributeName:kFont15}];
    [nav2.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor}];
    


    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"BASE" image:[UIImage imageNamed:@"house"] tag:0];
    item1.selectedImage = [UIImage imageNamed:@"house.fill"];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"OTHER" image:[UIImage imageNamed:@"person"] tag:0];
    item2.selectedImage = [UIImage imageNamed:@"person.fill"];


    //适配tabbar选项卡字体
    if (@available(iOS 15.0, *)) {
        UITabBarAppearance *appearance1 = [[UITabBarAppearance alloc] init];
        appearance1.stackedLayoutAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName:UIColor.redColor};
        appearance1.stackedLayoutAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName:UIColor.orangeColor};
        //tabbar 背景颜色
        appearance1.backgroundColor = [UIColor.groupTableViewBackgroundColor colorWithAlphaComponent:0.5];
        appearance1.backgroundColor = UIColor.whiteColor;
        
        //设置tabbar上面的那条线为透明图片
        UIImage *blankImage = [UIImage imageNamed:@"blank"];
        appearance1.shadowImage = blankImage;
        item1.standardAppearance = appearance1;
        item1.scrollEdgeAppearance = appearance1;
        
        UITabBarAppearance *appearance2 = [[UITabBarAppearance alloc] initWithBarAppearance:appearance1];
        appearance2.stackedLayoutAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName:UIColor.greenColor};
        item2.standardAppearance = appearance2;
        item2.scrollEdgeAppearance = appearance2;
        
        
    } else {
        // Fallback on earlier versions
        [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor} forState:UIControlStateNormal];
        [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.purpleColor} forState:UIControlStateSelected];
        
        [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor} forState:UIControlStateNormal];
        [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.greenColor} forState:UIControlStateSelected];
       
        //tabbar 背景颜色
        self.tabBar.backgroundColor = [UIColor.groupTableViewBackgroundColor colorWithAlphaComponent:0.5];
        //设置tabbar上面的那条线为透明图片
        UIImage *blankImage = [UIImage imageNamed:@"blank"];
        self.tabBar.shadowImage = blankImage;
    }
    

    nav1.tabBarItem = item1;
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

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            [self updateKeyWindows];
            NSLog(@"主题跟换。。。。");
        }
    } else {
        // Fallback on earlier versions
    }
}

/**
 更新keyWindow的背景颜色
 */
- (void)updateKeyWindows
{
    //解决系统导航条切换时，右上角显示问题
    UIWindow *key = [UIApplication.sharedApplication getKeyWindow];
    key.backgroundColor = TKColorManager.systemBackground;
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
