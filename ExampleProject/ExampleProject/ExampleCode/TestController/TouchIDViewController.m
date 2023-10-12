//
//  TouchIDViewController.m
//  ExampleProject
//
//  Created by kimi on 2023/10/12.
//

#import "TouchIDViewController.h"
#import "TouchIDManager.h"


@interface TouchIDViewController ()

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *btn = TKButtonFactory.btnOrangeCorner;
    [btn setTitleText:@"Touch ID 校验"];
    btn.frame = CGRectMake(100, 100, 200, 45);
    [self.view addSubview:btn];
    WeakSelf
    [btn addActionWithBlock:^(UIButton * _Nonnull button) {
        [TouchIDManager.shared startTouchIDWithCompare:^(BOOL success, NSString * _Nonnull msg) {
            TKAlertView *alert = [TKAlertView TKAlertViewDialogWithTitle:@"Touch ID" text:msg];
            [alert show];
        }];
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
