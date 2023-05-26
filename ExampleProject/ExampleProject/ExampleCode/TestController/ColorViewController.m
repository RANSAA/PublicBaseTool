//
//  ColorViewController.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "ColorViewController.h"

@interface ColorViewController ()

@end

@implementation ColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI
{
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(20, 84, 44, 44)];
    v1.backgroundColor = [TKColorManager systemYellow];

    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(20, 84+60, 44, 44)];
    v2.backgroundColor = [TKColorManager systemPink];

    UIView *v3 = [[UIView alloc] initWithFrame:CGRectMake(20, 84+120, 44, 44)];
    v3.backgroundColor = [TKColorManager systemOrange];

    UIView *v4 = [[UIView alloc] initWithFrame:CGRectMake(20, 84+180, 44, 44)];
    v4.backgroundColor = [TKColorManager systemRed];

    UIView *v5 = [[UIView alloc] initWithFrame:CGRectMake(20, 84+240, 44, 44)];
    v5.backgroundColor = [TKColorManager systemPurple];

    UIView *v6 = [[UIView alloc] initWithFrame:CGRectMake(20, 84+300, 44, 44)];
    v6.backgroundColor = [TKColorManager systemGray];

    UIView *v7 = [[UIView alloc] initWithFrame:CGRectMake(20, 84+360, 44, 44)];
    v7.backgroundColor = [TKColorManager label];

    [self.view addSubview:v1];
    [self.view addSubview:v2];
    [self.view addSubview:v3];
    [self.view addSubview:v4];
    [self.view addSubview:v5];
    [self.view addSubview:v6];
    [self.view addSubview:v7];
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
