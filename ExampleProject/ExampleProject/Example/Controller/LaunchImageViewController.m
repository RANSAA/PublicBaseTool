//
//  LaunchImageViewController.m
//  ExampleProject
//
//  Created by PC on 2022/8/10.
//

#import "LaunchImageViewController.h"
#import "TKDynamicLaunchImage.h"

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
    self.btn = TKButtonFactory.btnOrangeCorner;
    self.btn.frame = CGRectMake(20, 120, 120, 44);
    [self.btn setTitle:@"修改启动图" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(btnChangeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];

    self.textView = TKTextViewFactory.defaultStyle;
    self.textView.frame = CGRectMake(20, 200, 300, 320);
    [self.view addSubview:self.textView];
}

- (void)btnChangeAction
{
    static int index = 0;
    NSString *name = [NSString stringWithFormat:@"LaunchImage%d",(index%3)];

    NSString *path = [NSBundle.mainBundle resourcePath];
    path = [path stringByAppendingString:@"/"];
//    NSLog(@"path:%@",path);

    NSString *orgPath = [NSString stringWithFormat:@"%@LaunchImage0.png",path];
    NSString *targetPath = [NSString stringWithFormat:@"%@%@.png",path,name];

    NSLog(@"org:%@",orgPath);
    NSLog(@"target:%@",targetPath);

    NSError *err = nil;
    if ([NSFileManager.defaultManager fileExistsAtPath:orgPath]) {
        [NSFileManager.defaultManager removeItemAtPath:orgPath error:&err];
        if (err) {
            NSLog(@"err:%@",err);
        }
    }
    [NSFileManager.defaultManager copyItemAtPath:targetPath toPath:orgPath error:&err];
    if (err) {
        NSLog(@"err-1:%@",err);
    }


    self.textView.text = [NSString stringWithFormat:@"%@\n\n%@",path,name];
    index++;
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
