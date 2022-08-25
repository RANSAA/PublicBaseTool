//
//  NavigationViewController.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"class name:%@",self.class);


}
// 重写自定义的UINavigationController中的push方法
// 处理tabbar的显示隐藏
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
     if (self.childViewControllers.count==1) {
         viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
     }
     [super pushViewController:viewController animated:animated];
}

@end
