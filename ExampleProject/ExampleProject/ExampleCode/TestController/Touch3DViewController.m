//
//  Touch3DViewController.m
//  ExampleProject
//
//  Created by kimi on 2023/5/26.
//

#import "Touch3DViewController.h"
#import "Touch3DManager.h"

@interface Touch3DViewController ()

@end

@implementation Touch3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *lab = [[UILabel alloc] init];
    lab.textColor = UIColor.systemPinkColor;
    lab.numberOfLines = 0;
    lab.font = [UIFont systemFontOfSize:17];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"3D Touch 示例\n长按App图标即可看到样式!";
    [self.view addSubview:lab];
    lab.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *lay0 = [lab.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor];
    NSLayoutConstraint *lay1 = [lab.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor];
    [NSLayoutConstraint activateConstraints:@[lay0,lay1]];
    
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
