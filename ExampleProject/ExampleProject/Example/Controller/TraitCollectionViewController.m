//
//  TraitCollectionViewController.m
//  ExampleProject
//
//  Created by PC on 2022/8/4.
//

#import "TraitCollectionViewController.h"
#import "TestImageView.h"



@interface TraitCollectionViewController ()
@property(nonatomic, strong) NSString *kvoUs;
@property(nonatomic, strong) UIImageView *blockImgView;
@end

@implementation TraitCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI
{
    TestImageView *imgView = [[TestImageView alloc] initWithFrame:CGRectMake(10, 80, 150, 320)];
    imgView.clipsToBounds = YES;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.image = [UIImage imageNamed:@"LaunchImage0"];
    imgView.tag = 9527;
    [self.view addSubview:imgView];

    CGRect frame = CGRectMake(170, 80, 140, 44);
    UIButton *btn1 = TKButtonFactory.btnOrangeCorner;
    btn1.frame = frame;
    [btn1 setTitle:@"button" forState:UIControlStateNormal];
    [self.view addSubview:btn1];

    UILabel *lab = TKLableFactory.labOrangeTextWhite;
    frame.origin.y += 50;
    lab.frame = frame;
    lab.text = @"lable";
    [self.view addSubview:lab];

    UITextField *textField = TKTextFieldFactory.defaultStyle;
    frame.origin.y += 50;
    textField.frame = frame;
    textField.text = @"textField";
    [self.view addSubview:textField];

    UITextView *textView = TKTextViewFactory.defaultStyle;
    frame.origin.y += 50;
    textView.frame = frame;
    textView.text =@"textview";
    [self.view addSubview:textView];


    UISearchBar *searchBar = TKSearchBarFactory.defaultStyle;
    frame.origin.y += 50;
    searchBar.frame = frame;
    searchBar.text = @"searchbar";
    [self.view addSubview:searchBar];


    if (@available(iOS 13.0, *)) {
        [imgView bingMonitorTheme:^(UIUserInterfaceStyle theme, UIView * _Nonnull view) {
            UIImageView *img = (UIImageView *)view;
            if (theme == UIUserInterfaceStyleDark) {
                img.image = [UIImage imageNamed:@"LaunchImage1"];
            }else{
                img.image = [UIImage imageNamed:@"LaunchImage2"];
            }
        }];

        [btn1 bingMonitorTheme:^(UIUserInterfaceStyle theme, UIView * _Nonnull view) {
            if (theme == UIUserInterfaceStyleDark) {
                view.backgroundColor = UIColor.redColor;
            }else{
                view.backgroundColor = UIColor.orangeColor;
            }
        }];

        [lab bingMonitorTheme:^(UIUserInterfaceStyle theme, UIView * _Nonnull view) {
            if (theme == UIUserInterfaceStyleDark) {
                view.backgroundColor = UIColor.redColor;
            }else{
                view.backgroundColor = UIColor.orangeColor;
            }
        }];

        [textField bingMonitorTheme:^(UIUserInterfaceStyle theme, UIView * _Nonnull view) {
            if (theme == UIUserInterfaceStyleDark) {
                view.backgroundColor = UIColor.redColor;
            }else{
                view.backgroundColor = UIColor.orangeColor;
            }
        }];

        [textView bingMonitorTheme:^(UIUserInterfaceStyle theme, UIView * _Nonnull view) {
            if (theme == UIUserInterfaceStyleDark) {
                view.backgroundColor = UIColor.redColor;
            }else{
                view.backgroundColor = UIColor.orangeColor;
            }
        }];

        [searchBar bingMonitorTheme:^(UIUserInterfaceStyle theme, UIView * _Nonnull view) {
            if (theme == UIUserInterfaceStyleDark) {
                view.backgroundColor = UIColor.redColor;
            }else{
                view.backgroundColor = UIColor.orangeColor;
            }

            UISearchBar *bar = (UISearchBar *)view;
            if (theme == UIUserInterfaceStyleDark) {
                bar.barTintColor = UIColor.redColor;
            }else{
                bar.barTintColor = UIColor.orangeColor;
            }
        }];


        //controller
        [self bingMonitorTheme:^(UIUserInterfaceStyle theme, UIViewController * _Nonnull controller) {
            if (theme == UIUserInterfaceStyleDark) {
                controller.view.backgroundColor = UIColor.cyanColor;
            }else{
                controller.view.backgroundColor = UIColor.whiteColor;
            }
        }];

        [self bingMonitorTraitCollection:^(UITraitCollection * _Nonnull previousTraitCollection, UIViewController * _Nonnull controller) {
            NSLog(@"previousTraitCollection...");
        }];
    } else {
        // Fallback on earlier versions
    }


}


- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    NSLog(@"ViewController TraitCollection状态改变。。");

    if (@available(iOS 13.0,*)) {
        //判断当前模式是否发生变化，因为屏幕旋转也会触发该方法。
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            NSLog(@"ViewController TraitCollection主题模式发生变化，可以在这儿做修改");
        }
    }

}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
//{
//    NSLog(@"viewWillTransitionToSize:%@     coordinator:%@",NSStringFromCGSize(size),coordinator);
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
