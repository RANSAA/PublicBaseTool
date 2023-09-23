//
//  JumpToAppStoreViewController.m
//  ExampleProject
//
//  Created by kimi on 2023/9/21.
//

#import "JumpToAppStoreViewController.h"
#import "JumpToAppStore.h"


@interface JumpToAppStoreViewController ()
@property(nonatomic, strong)JumpToAppStore *jumpAppStore;
@end

@implementation JumpToAppStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.jumpAppStore = [JumpToAppStore new];
    [self.jumpAppStore setAppleAppID:@"1436002627"];
    [self setupUI];
}

- (void)setupUI
{
    UIButton *btn0 = TKButtonFactory.btnGreenCorner;
    btn0.frame = CGRectMake(50, 120, 240, 44);
    [btn0 setTitle:@"直接跳转到App Store" forState:UIControlStateNormal];
    [btn0 addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    UIButton *btn1 = TKButtonFactory.btnGreenCorner;
    btn1.frame = CGRectMake(50, 240, 240, 44);
    [btn1 setTitle:@"在App内直接打开App Store" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnAction2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)btnAction1
{
    [self.jumpAppStore jump];
}

- (void)btnAction2
{
    
    [self.jumpAppStore jumpWithPresentVC:self];
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
