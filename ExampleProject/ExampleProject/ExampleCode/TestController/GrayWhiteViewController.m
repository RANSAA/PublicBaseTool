//
//  GrayWhiteViewController.m
//  ExampleProject
//
//  Created by PC on 2022/12/9.
//

#import "GrayWhiteViewController.h"
#import "TKGrayWhiteFilterView.h"

@interface GrayWhiteViewController ()

@end

@implementation GrayWhiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI
{
    UIButton *btn0 = TKButtonFactory.btnOrangeCorner;
    btn0.frame = CGRectMake(100,120 , 120, 44);
    btn0.titleText = @"开启";
    [btn0 addTarget:self action:@selector(btnOpenAction) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    
    UIButton *btn1 = TKButtonFactory.btnOrangeCorner;
    btn1.frame = CGRectMake(100,220 , 120, 44);
    btn1.titleText = @"关闭";
    [btn1 addTarget:self action:@selector(btnCloseAction) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    [TKGrayWhiteFilterView showGrayWhiteFilterWithSuperView:UIApplication.keyWindow];
}

- (void)btnOpenAction
{
    [TKGrayWhiteFilterView setOpenWhiteBlackModel:YES];
    [TKGrayWhiteFilterView showGrayWhiteFilterWithSuperView:UIApplication.keyWindow];
}


- (void)btnCloseAction
{
    [TKGrayWhiteFilterView removeGrayWhiteFilterFrom:UIApplication.keyWindow];
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
