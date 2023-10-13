//
//  TKQRCodeToolViewController.m
//  ExampleProject
//
//  Created by kimi on 2023/10/13.
//

#import "TKQRCodeToolViewController.h"
#import "TKQRCodeTool.h"


@interface TKQRCodeToolViewController ()
@property(nonatomic, strong) UITextField *textfield;
@property(strong) UIImageView *imgQRView;
@property(strong) UITextView *qrTextView;
@end

@implementation TKQRCodeToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setuoUI];
}

- (void)setuoUI
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(100, 400, 180, 180);
    [self.view addSubview:imgView];
    self.imgQRView  = imgView;
    imgView.hidden = YES;
    
    self.qrTextView = [[UITextView alloc] init];
    self.qrTextView.frame = CGRectMake(20, 400, 320, 180);
    [self.view addSubview:self.qrTextView];
    self.qrTextView.hidden = YES;
    
    
    
    UITextField *textfield = TKTextFieldFactory.titleInput;
    textfield.frame = CGRectMake(20, 100, 320, 40);
    textfield.placeholder = @"二维码生成数据.....";
    [self.view addSubview:textfield];
    for (UIView* view in textfield.leftView.subviews) {
        if( [view isKindOfClass:UILabel.class]){
            ((UILabel *)view).text = @"QR";
        }else{
            view.hidden = YES;
        }
    }
    self.textfield = textfield;
    
    
    
    
    UIButton *btn = TKButtonFactory.btnGreenCorner;
    [btn setTitleText:@"生成二维码"];
    btn.frame = CGRectMake(20, 150, 160, 44);
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    UIButton *btn1 = TKButtonFactory.btnGreenCorner;
    [btn1 setTitleText:@"生成带中心图片二维码"];
    btn1.frame = CGRectMake(185, 150, 180, 44);
    [btn1 addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = TKButtonFactory.btnGreenCorner;
    [btn2 setTitleText:@"生成二维码-resize"];
    btn2.frame = CGRectMake(20, 220, 160, 44);
    [btn2 addTarget:self action:@selector(btnAction2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

    UIButton *btn3 = TKButtonFactory.btnGreenCorner;
    [btn3 setTitleText:@"生成带中心图片二维码-resize"];
    btn3.frame = CGRectMake(185, 220, 180, 44);
    [btn3 addTarget:self action:@selector(btnAction3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = TKButtonFactory.btnGreenCorner;
    [btn4 setTitleText:@"识别二维码"];
    btn4.frame = CGRectMake(20, 290, 160, 44);
    [btn4 addTarget:self action:@selector(btnAction4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}



- (void)btnAction
{
    NSLog(@"生成二维码");
    NSString *str = self.textfield.text;
    UIImage *result = [TKQRCodeTool qrGenerateQRCodeWith:str centerImage:nil width:0];
    [self showQRImage:result];
}

- (void)btnAction1
{
    NSLog(@"生成带中心图片二维码");
    UIImage *centerImage = [UIImage imageNamed:@"QRCenter.png"];
    NSString *str = self.textfield.text;
    UIImage *result = [TKQRCodeTool qrGenerateQRCodeWith:str centerImage:centerImage width:0];
    [self showQRImage:result];
}

- (void)btnAction2
{
    NSLog(@"生成二维码-ReSize");
    NSString *str = self.textfield.text;
    UIImage *result = [TKQRCodeTool qrGenerateQRCodeWith:str centerImage:nil width:200];
    [self showQRImage:result];
}

- (void)btnAction3
{
    NSLog(@"生成带中心图片二维码-ReSize");
    UIImage *centerImage = [UIImage imageNamed:@"QRCenter.png"];
    NSString *str = self.textfield.text;
    UIImage *result = [TKQRCodeTool qrGenerateQRCodeWith:str centerImage:centerImage width:200];
    [self showQRImage:result];
}

- (void)btnAction4
{
    NSLog(@"识别二维码");
    NSString *str = [TKQRCodeTool qrRecognizeFromImage:self.imgQRView.image];
    str = str ? str : @"Error:未识别到二维码信息";
    [self showQRString:str];
}


- (void)showQRImage:(UIImage *)image
{
    NSLog(@"result image:%@",image);
    self.imgQRView.hidden = NO;
    self.qrTextView.hidden = YES;
    self.imgQRView.image = image;
}


- (void)showQRString:(NSString *)str
{
    NSLog(@"result qrcode:%@",str);
    self.imgQRView.hidden = YES;
    self.qrTextView.hidden = NO;
    self.qrTextView.text = str;
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
