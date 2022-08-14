//
//  AppIconViewController.m
//  ExampleProject
//
//  Created by PC on 2022/8/12.
//

#import "AppIconViewController.h"
#import "AppIconManage.h"

@interface AppIconViewController ()

@end

@implementation AppIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI
{
    UIButton *btn1 = TKButtonFactory.btnOrangeCorner;
    btn1.frame = CGRectMake(10, 80, 140, 44);
    [btn1 setTitle:@"icon1" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 1;
    [self.view addSubview:btn1];


    UIButton *btn2 = TKButtonFactory.btnOrangeCorner;
    btn2.frame = CGRectMake(170, 80, 140, 44);
    [btn2 setTitle:@"icon2" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 2;
    [self.view addSubview:btn2];

    UIButton *btn3 = TKButtonFactory.btnOrangeCorner;
    btn3.frame = CGRectMake(10, 150, 140, 44);
    [btn3 setTitle:@"icon3" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    btn3.tag = 3;
    [self.view addSubview:btn3];


    UIButton *btn4 = TKButtonFactory.btnOrangeCorner;
    btn4.frame = CGRectMake(170, 150, 140, 44);
    [btn4 setTitle:@"恢复默认" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btnChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    btn4.tag = 4;
    [self.view addSubview:btn4];
}


- (void)btnChangeAction:(UIButton *)btn
{
    NSString *iconName = nil;
    switch (btn.tag) {
        case 1:
            iconName = @"icon1";
            break;
        case 2:
            iconName = @"icon2";
            break;
        case 3:
            iconName = @"icon3";
            break;

        default:
            break;
    }


    AppIconManage.shared.showAlert = NO;
    [AppIconManage.shared changeAppIconWithName:iconName];
    AppIconManage.shared.completionHandler = ^(NSError * _Nullable error) {
        NSLog(@"App Icon 更新回调");
    };


}


@end
