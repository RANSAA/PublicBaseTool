//
//  LaunchImageViewController.m
//  ExampleProject
//
//  Created by PC on 2022/8/10.
//

#import "LaunchImageViewController.h"
#import "TKDynamicLaunchImage.h"
#import "TKDynamicLaunchImageHelper.h"

@interface LaunchImageViewController ()

@property(nonatomic, strong) UIButton *btn;
@property(nonatomic, strong) UITextView *textView;
@end

@implementation LaunchImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI
{
    UIButton *btn1 = TKButtonFactory.btnOrangeCorner;
    btn1.frame = CGRectMake(10, 80, 140, 44);
    [btn1 setTitle:@"LaunchImage1" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 1;
    [self.view addSubview:btn1];


    UIButton *btn2 = TKButtonFactory.btnOrangeCorner;
    btn2.frame = CGRectMake(170, 80, 140, 44);
    [btn2 setTitle:@"LaunchImage2" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 2;
    [self.view addSubview:btn2];


    UIButton *btn3 = TKButtonFactory.btnOrangeCorner;
    btn3.frame = CGRectMake(10, 80+44+24, 140, 44);
    [btn3 setTitle:@"复原" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    btn3.tag = 3;
    [self.view addSubview:btn3];



    self.textView = TKTextViewFactory.defaultStyle;
    self.textView.frame = CGRectMake(20, 200, 300, 320);
    [self.view addSubview:self.textView];
}


- (void)btnChangeAction:(UIButton *)btn
{
    NSString *name = [NSString stringWithFormat:@"LaunchImage%ld.png",btn.tag];
    UIImage *launchImage = [UIImage imageNamed:name];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
    UIViewController *vc = [story instantiateInitialViewController];
    if (btn.tag != 3) {
        UIImageView *imgView = [vc.view viewWithTag:21];
        imgView.image = launchImage;
    }


    UIImage *image0 = [TKDynamicLaunchImageHelper snapshotViewController:vc isPortrait:YES];
    UIImage *image1 = [TKDynamicLaunchImageHelper snapshotViewController:vc isPortrait:NO];

    [TKDynamicLaunchImageHelper changePortraitLaunchImage:image0 landscapeLaunchImage:image1];



//    NSLog(@"ns home:%@",NSHomeDirectory());
//    NSString *path0 = [NSHomeDirectory() stringByAppendingPathComponent:@"1.png"];
//    NSString *path1 = [NSHomeDirectory() stringByAppendingPathComponent:@"2.png"];
//
//    NSData *data0 = UIImagePNGRepresentation(image0);
//    NSData *data1 = UIImagePNGRepresentation(image1);
//
//    [data0 writeToFile:path0 options:NSDataWritingWithoutOverwriting error:nil];
//    [data1 writeToFile:path1 options:NSDataWritingWithoutOverwriting error:nil];

    [TKMBProgressHUD showText:@"启动图更新成功,程序退出中...." inView:self.view after:1.5];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
}

@end
