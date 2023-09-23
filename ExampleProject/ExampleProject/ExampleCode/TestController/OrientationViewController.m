//
//  OrientationViewController.m
//  ExampleProject
//
//  Created by kimi on 2023/8/1.
//

#import "OrientationViewController.h"
#import "UIDevice+Orientation.h"


@interface OrientationViewController ()

@end

@implementation OrientationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI
{
    UIButton *btn0 = TKButtonFactory.btnGreenCorner;
    btn0.frame = CGRectMake(50, 80, 100, 60);
    [btn0 setTitle:@"上" forState:UIControlStateNormal];
    [btn0 addTarget:self action:@selector(btnUpAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    
    UIButton *btn1 = TKButtonFactory.btnGreenCorner;
    btn1.frame = CGRectMake(160, 80, 100, 60);
    [btn1 setTitle:@"左" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnLeftAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = TKButtonFactory.btnGreenCorner;
    btn2.frame = CGRectMake(50, 180, 100, 60);
    [btn2 setTitle:@"下" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnDownAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = TKButtonFactory.btnGreenCorner;
    btn3.frame = CGRectMake(160, 180, 100, 60);
    [btn3 setTitle:@"右" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnRightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
}

- (void)btnUpAction
{
//    if(@available(iOS 16.0, *)){
//        [UIDevice.currentDevice setOrientationIOS16:UIInterfaceOrientationMaskPortrait errorHandler:nil];
//    }else{
//        [UIDevice.currentDevice setOrientation:UIInterfaceOrientationPortrait];
//    }
    
    [UIDevice.currentDevice setUIOrientation:TKInterfaceOrientationPortrait];
}

- (void)btnLeftAction
{
//    if(@available(iOS 16.0, *)){
//        [UIDevice.currentDevice setOrientationIOS16:UIInterfaceOrientationMaskLandscapeLeft errorHandler:nil];
//    }else{
//        [UIDevice.currentDevice setOrientation:UIInterfaceOrientationLandscapeLeft];
//    }
    [UIDevice.currentDevice setUIOrientation:TKInterfaceOrientationLandscapeLeft];
}

- (void)btnDownAction
{
//    if(@available(iOS 16.0, *)){
//        [UIDevice.currentDevice setOrientationIOS16:UIInterfaceOrientationMaskPortraitUpsideDown errorHandler:nil];
//    }else{
//        [UIDevice.currentDevice setOrientation:UIInterfaceOrientationPortraitUpsideDown];
//    }
    [UIDevice.currentDevice setUIOrientation:TKInterfaceOrientationPortraitUpsideDown];
}

- (void)btnRightAction
{
//    if(@available(iOS 16.0, *)){
//        [UIDevice.currentDevice setOrientationIOS16:UIInterfaceOrientationMaskLandscapeRight errorHandler:nil];
//    }else{
//        [UIDevice.currentDevice setOrientation:UIInterfaceOrientationLandscapeRight];
//    }
    [UIDevice.currentDevice setUIOrientation:TKInterfaceOrientationLandscapeRight];
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
