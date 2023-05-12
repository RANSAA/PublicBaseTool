//
//  BaseViewController.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"class name:%@",self.class);
    self.view.backgroundColor = [TKColorManager systemBackground];
    self.navigationItem.title = self.clsModel.name;


    
    //默认返回按钮字体颜色
    [self.navigationController.navigationBar setTintColor:UIColor.purpleColor];

    NSDictionary *titleAttr = @{NSForegroundColorAttributeName:UIColor.greenColor,
                                NSFontAttributeName:kFont15};
    
    if(@available(iOS 15, *)){
        UIImage *blankImage = [UIImage imageNamed:@"blank"];
        // 设置 NavigationBar
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        appearance.backgroundColor = UIColor.orangeColor;
//        appearance.shadowImage = backImage;
        appearance.titleTextAttributes = titleAttr;
        //修改返回按钮的箭头图标，注意这儿不能是一个空UIImage(即：[UIImage new]),如果是空UIImage将会使用默认值。
        [appearance setBackIndicatorImage:blankImage transitionMaskImage:blankImage];
        //navBar Title 位置偏移量
        appearance.titlePositionAdjustment = UIOffsetMake(0, 5);
        //返回按钮 Title偏移设置
        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffsetMake(0, 5);
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    }else{
        //返回按钮图标
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];
        //导航条颜色
        self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
        //导航条标题属性
        [self.navigationController.navigationBar setTitleTextAttributes:titleAttr];
        //navBar title 垂直方向位置的偏移量
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:10 forBarMetrics:UIBarMetricsDefault];
        //返回按钮 Title偏移设置
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 5) forBarMetrics:UIBarMetricsDefault];
    }

    
    //    //Test Add Back
    //    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(btnBackAction:)];
    //    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)btnBackAction:(UIButton *)sender
{
    if(self.navigationController.childViewControllers.count>1){
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)dealloc
{
    NSLog(@"dealloc class:%@    title:%@",self.class,self.clsModel.name);
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
