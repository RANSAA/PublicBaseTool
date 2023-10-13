//
//  TKLocationlocatorViewController.m
//  ExampleProject
//
//  Created by kimi on 2023/10/13.
//

#import "TKLocationlocatorViewController.h"
#import "TKLocationlocator.h"


@interface TKLocationlocatorViewController ()
@property(nonatomic, strong) TKLocationlocator *locator;
@property(nonatomic, strong) NSString *curAddr;
@property(nonatomic, strong) CLLocation *curLocation;
@end

@implementation TKLocationlocatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self loadLocator];
}

- (void)setupUI
{
    UIButton *btn = TKButtonFactory.btnGreenCorner;
    [btn setTitleText:@"地址编码"];
    btn.frame = CGRectMake(20, 150, 160, 44);
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    UIButton *btn1 = TKButtonFactory.btnGreenCorner;
    [btn1 setTitleText:@"反地址编码"];
    btn1.frame = CGRectMake(185, 150, 180, 44);
    [btn1 addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)loadLocator
{
    WeakSelf
    _locator = [[TKLocationlocator alloc] init];
    _locator.blockAddress = ^(NSString * _Nullable addr) {
        TKLog(@"详细地址信息:%@",addr);
    };
    _locator.blockLocation = ^(CLLocation * _Nullable location) {
        TKLog(@"坐标信息:  latitude:%f  longitude:%f", location.coordinate.latitude,location.coordinate.longitude);
    };
}


- (void)btnAction
{
    TKLog(@"地址编码....");
    NSString *addr = self.curAddr;
    addr = addr.length > 1 ? addr : @"中国四川省成都市武侯区红运街";
    [_locator geocodeAddress:addr];
}

- (void)btnAction1
{
    TKLog(@"反地址编码.....");
    CLLocation *location = self.curLocation;
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:30.647157  longitude:104.003689];
    location = location ? location : loc;
    [_locator reverseGeocodeLocation:location];
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
