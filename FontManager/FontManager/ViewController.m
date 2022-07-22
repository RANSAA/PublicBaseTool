//
//  ViewController.m
//  TKFontManager
//
//  Created by PC on 2022/7/22.
//

#import "ViewController.h"
#import "TKFontManager.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lab;
@property (strong, nonatomic) IBOutlet UILabel *labSetp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSString *fPath = [NSBundle.mainBundle pathForResource:@"dynamic" ofType:@"ttf"];
    NSData *fontData = [NSData dataWithContentsOfFile:fPath];
    [TKFontManager.shared dynamicLoadFontData:fontData];


    [TKFontManager.shared fontNames];
//    [TKFontManager.shared familyName];
//    [TKFontManager.shared setFontName:@"AaJianHaoTi" isApply:YES];
    UIFont *f = kFont6;
    NSLog(@"font:%@",f);
}

- (IBAction)btnFontSwitchAction:(UIButton *)sender {
    static NSInteger index = 0;
    NSInteger type = index%4;
    switch (type) {
        case 0:
            [TKFontManager.shared setFontName:@"AaJianHaoTi" isApply:YES];
            break;
        case 1:
            [TKFontManager.shared setFontName:@"AaKADRXZW" isApply:YES];
            break;
        case 2:
            [TKFontManager.shared setFontName:@"A025-SounsoWarm-" isApply:YES];
            break;
        default:
            //使用系统字体
            [TKFontManager.shared setFontName:@".SFNS-Regular" isApply:NO];
            break;
    }
    index++;
}
- (IBAction)btnRemoveLableAction:(UIButton *)sender {
    [self.lab removeFromSuperview];
}
- (IBAction)stepperAction:(UIStepper *)sender {
    self.labSetp.text = [NSString stringWithFormat:@"%.f",sender.value];
    self.lab.font = [TKFontManager.shared fontFactoryOfSize:sender.value];
}

@end
