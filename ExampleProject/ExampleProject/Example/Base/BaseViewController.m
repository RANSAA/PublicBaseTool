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
    self.view.backgroundColor = [TKColorManage systemBackground];
    self.navigationItem.title = self.clsModel.name;

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.greenColor,
                                            NSFontAttributeName:kFont15
    }];

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
