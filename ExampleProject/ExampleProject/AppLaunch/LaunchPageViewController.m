//
//  LaunchPageViewController.m
//  ExampleProject
//
//  Created by PC on 2022/8/4.
//

#import "LaunchPageViewController.h"
#import "LaunchPageManager.h"
#import "LaunchTextView.h"

@interface LaunchPageViewController ()<UITextViewDelegate>

@end

@implementation LaunchPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor
    [self setupLaunchView];
    [self setupUI];

//    NSString *path = [NSBundle.mainBu÷
//    path = [path stringByAppendingString:@"/123.txt"];
//    NSError *err = nil;
//    [path writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&err];
//    NSLog(@"err:%@",err);
}

- (void)setupLaunchView
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
    UIViewController *vc = [story instantiateInitialViewController];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    self.imgView = [self.view viewWithTag:21];
    NSInteger ran = arc4random()%3;
    NSString *name = [NSString stringWithFormat:@"LaunchImage%ld",ran];
    self.imgView.image = [UIImage imageNamed:name];
}

- (void)setupUI
{
    UIView *centerView = [[UIView alloc] init];
    centerView.frame = CGRectMake(100, 100, 200, 200);
    centerView.backgroundColor = UIColor.whiteColor;
    centerView.clipsToBounds = YES;
    centerView.layer.cornerRadius = 8;
    centerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view  addSubview:centerView];
    NSLayoutConstraint *lay1 = [centerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:24];
    NSLayoutConstraint *lay2 = [centerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-24];
    NSLayoutConstraint *lay3 = [centerView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor];
    NSLayoutConstraint *lay4 = [centerView.heightAnchor constraintEqualToConstant:280];
    lay1.active = YES;
    lay2.active = YES;
    lay3.active = YES;
    lay4.active = YES;


    UIView *topView = [[UIView alloc] init];
    [centerView addSubview:topView];
    topView.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *bottomView = [[UIView alloc] init];
    [centerView addSubview:bottomView];
    bottomView.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *top1 = [topView.topAnchor constraintEqualToAnchor:centerView.topAnchor];
    NSLayoutConstraint *top2 = [topView.leftAnchor constraintEqualToAnchor:centerView.leftAnchor];
    NSLayoutConstraint *top3 = [topView.rightAnchor constraintEqualToAnchor:centerView.rightAnchor];
    NSLayoutConstraint *top4 = [topView.bottomAnchor constraintEqualToAnchor:bottomView.topAnchor constant:2];
    [centerView addConstraints:@[top1,top2,top3,top4]];

    NSLayoutConstraint *top22 = [bottomView.leftAnchor constraintEqualToAnchor:centerView.leftAnchor];
    NSLayoutConstraint *top33 = [bottomView.rightAnchor constraintEqualToAnchor:centerView.rightAnchor];
    NSLayoutConstraint *top44 = [bottomView.bottomAnchor constraintEqualToAnchor:centerView.bottomAnchor constant:-12];
    NSLayoutConstraint *top55 = [bottomView.heightAnchor constraintEqualToConstant:40];
    [centerView addConstraints:@[top22,top33,top44,top55]];


    UIButton *btn1 = TKButtonFactory.btnGreenCorner;
    [btn1 setTitle:@"不同意" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnCancelAction) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btn2 = TKButtonFactory.btnOrangeCorner;
    [btn2 setTitle:@"同意" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnDoneAction) forControlEvents:UIControlEventTouchUpInside];

    [bottomView addSubview:btn1];
    [bottomView addSubview:btn2];
    btn2.translatesAutoresizingMaskIntoConstraints = NO;
    btn1.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *layBtn1 = [btn1.topAnchor constraintEqualToAnchor:bottomView.topAnchor];
    NSLayoutConstraint *layBtn2 = [btn1.leftAnchor constraintEqualToAnchor:bottomView.leftAnchor constant:20];
    NSLayoutConstraint *layBtn3 = [btn1.bottomAnchor constraintEqualToAnchor:bottomView.bottomAnchor];

    NSLayoutConstraint *layBtn4 = [btn1.rightAnchor constraintEqualToAnchor:btn2.leftAnchor constant:-24];
    NSLayoutConstraint *layBtn5 = [btn1.widthAnchor constraintEqualToAnchor:btn2.widthAnchor];

    NSLayoutConstraint *layBtn6 = [btn2.topAnchor constraintEqualToAnchor:bottomView.topAnchor];
    NSLayoutConstraint *layBtn7 = [btn2.rightAnchor constraintEqualToAnchor:bottomView.rightAnchor constant:-20];
    NSLayoutConstraint *layBtn8 = [btn2.bottomAnchor constraintEqualToAnchor:bottomView.bottomAnchor];
    [bottomView addConstraints:@[layBtn1,layBtn2,layBtn3,layBtn4,layBtn5,layBtn6,layBtn7,layBtn8]];



    LaunchTextView *textview = [[LaunchTextView alloc] init];
//    textview.editable = NO;
//    textview.delegate = self;
    textview.dataDetectorTypes = UIDataDetectorTypeLink;
    textview.textColor = TKColorManager.label;
    textview.backgroundColor = TKColorManager.colorWhite;
    [topView addSubview:textview];
    textview.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *v = @{@"view":textview};
    [topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[view]-12-|" options:0 metrics:nil views:v]];
    [topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[view]-12-|" options:0 metrics:nil views:v]];
    NSString *msg = @"\t\t用户协议与隐私政策\t\n\n\n这是一个测试《服务协议》和《隐私政策》的一段文字说明\n“我们一向庄严承诺保护使用户(“用户”或“您”)的隐私。您在使用我们服务时,我们可能会收集和使用您的相关信息,https://sourceforge.net.";
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:msg];

    NSURL *url1 = [NSURL URLWithString:@"lauch1://1513"];
    NSURL *url2 = [NSURL URLWithString:@"lauch2:"];
    NSString *tip = @"《服务协议》";
    NSRange range = [msg rangeOfString:tip];
    [attr setAttributes:@{NSForegroundColorAttributeName:UIColor.redColor,
                          NSLinkAttributeName:url1
    } range:range];
    tip = @"《隐私政策》";
    range = [msg rangeOfString:tip];
    [attr setAttributes:@{NSForegroundColorAttributeName:UIColor.redColor,
                          NSLinkAttributeName:url2
    } range:range];
    textview.attributedText = attr;

    __weak typeof(self) weakSelf = self;
    [textview addLinkAttributeName:url1];
    [textview addLinkAttributeName:url2];
    textview.clickLinkCompletion = ^(NSURL * _Nonnull url) {
        NSLog(@"clickLinkCompletion :%@",url);
    };
    textview.clickLinkAttrCompletion = ^(NSURL * _Nonnull url) {
        NSLog(@"clickLinkAttrCompletion :%@",url);
        if ([url isEqual:url1]) {
            [weakSelf toUserAgreeAction];
        }else if ([url isEqual:url2]){
            [weakSelf toPrivateAction];
        }
    };
}

- (void)btnCancelAction
{
    exit(0);
}

- (void)btnDoneAction
{
    if (self.saveAgreementStatus) {
        self.saveAgreementStatus();
    }

    if (self.completion) {
        self.completion();
    }
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    NSLog(@"TEXT URL:%@",URL);

    NSString *scheme = URL.scheme;
    if ([scheme isEqualToString:@"lauch1"]) {
        [self toUserAgreeAction];
        return NO;
    }else if ([scheme isEqualToString:@"lauch2"]){
        [self toPrivateAction];
        return NO;
    }

    return YES;
}

- (void)toUserAgreeAction
{
    NSLog(@"跳转到用户协议。。。。 ");
    ClassTypeModel *model = [ClassTypeModel initWithName:@"用户协议" cls:@"BaseViewController"];

    Class class = NSClassFromString(model.cls);
    id vc = [[class alloc] init];
    [vc setValue:model forKey:@"clsModel"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toPrivateAction
{
    NSLog(@"跳转到隐私协议。。。。");

    ClassTypeModel *model = [ClassTypeModel initWithName:@"隐私协议" cls:@"BaseViewController"];

    Class class = NSClassFromString(model.cls);
    id vc = [[class alloc] init];
    [vc setValue:model forKey:@"clsModel"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)dealloc
{
    NSLog(@"dealloc LaunchPageViewController");
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
