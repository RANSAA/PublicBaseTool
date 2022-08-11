//
//  FlowViewController.m
//  ExampleProject
//
//  Created by PC on 2022/8/10.
//

#import "FlowViewController.h"
#import "FlowView.h"

@interface FlowViewController ()

@end

@implementation FlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 320, 1)];
    line.backgroundColor = UIColor.redColor;
    [self.view addSubview: line];

    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 80+420, 320, 1)];
    line1.backgroundColor = UIColor.redColor;
    [self.view addSubview: line1];
    
    FlowView *flow = [[FlowView alloc] initWithFrame:CGRectMake(20, 80, 280, 420)];
    flow.backgroundColor = TKColorManage.systemGray5;
    flow.image = [UIImage imageNamed:@"LaunchImage1"];
    flow.fixed = 580;
    flow.distance = 0.5;
//    flow.direction = FlowViewDirectionHorizontal;
    [self.view addSubview:flow];
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
