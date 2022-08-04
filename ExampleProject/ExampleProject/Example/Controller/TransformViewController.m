//
//  TransformViewController.m
//  ExampleProject
//
//  Created by PC on 2022/8/4.
//

#import "TransformViewController.h"

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
    UIStackView *stackView = [[UIStackView alloc]initWithFrame:CGRectMake(20, 64, 200, 400)];
    stackView.backgroundColor = TKColorManage.systemGray3;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.spacing = 20;



    [self.view addSubview:stackView];

    UIButton *btn1 = TKButtonFactory.btnOrangeCorner;
    [btn1 setTitle:@"111" forState:UIControlStateNormal];

    UIButton *btn2 = TKButtonFactory.btnGreenCorner;
    [btn2 setTitle:@"222" forState:UIControlStateNormal];

    UIButton *btn3 = TKButtonFactory.btnYellowCorner;
    [btn3 setTitle:@"333" forState:UIControlStateNormal];


    [stackView addArrangedSubview:btn1];
    [stackView addArrangedSubview:btn2];
    [stackView addArrangedSubview:btn3];

   
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
