//
//  TransformViewController.m
//  ExampleProject
//
//  Created by PC on 2022/8/4.
//

#import "TransformViewController.h"
#import "DotIndicator.h"
#import "TestAniView.h"

@interface TransformViewController ()

@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI
{
    UIStackView *stackView = [[UIStackView alloc]initWithFrame:CGRectMake(100, 64, 200, 400)];
    stackView.backgroundColor = TKColorManage.systemGray3;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.spacing = 20;



    [self.view addSubview:stackView];

    UIButton *btn1 = TKButtonFactory.btnOrangeCorner;
    [btn1 setTitle:@"DotIndicator" forState:UIControlStateNormal];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btn2 = TKButtonFactory.btnGreenCorner;
    [btn2 setTitle:@"TestAniView" forState:UIControlStateNormal];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btn3 = TKButtonFactory.btnYellowCorner;
    [btn3 setTitle:@"333" forState:UIControlStateNormal];
    btn3.tag = 3;
    [btn3 addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];

    [stackView addArrangedSubview:btn1];
    [stackView addArrangedSubview:btn2];
    [stackView addArrangedSubview:btn3];

   
}

- (void)btnClickAction:(UIButton *)btn
{
    NSInteger index = btn.tag;
    NSLog(@"index:%ld",index);
    switch (index) {
        case 1:
            [self aniDotIndicator];
            break;
        case 2:
            [self aniTestAniView];
            break;

        default:
            break;
    }

}

- (void)aniDotIndicator
{
    DotIndicator *view = [[DotIndicator alloc] initWithFrame:CGRectMake(8, 80, 80, 80)];
    view.backgroundColor = UIColor.grayColor;
//    view.color1 = UIColor.redColor;
    [self.view addSubview:view];
}

- (void)aniTestAniView
{
    TestAniView *view = [[TestAniView alloc] initWithFrame:CGRectMake(8, 80, 80, 80)];
    view.backgroundColor = UIColor.grayColor;
    [self.view addSubview:view];
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
