//
//  ShareActivityViewController.m
//  ExampleProject
//
//  Created by kimi on 2023/10/12.
//

#import "ShareActivityViewController.h"
#import "ShareActivity.h"


@interface ShareActivityViewController ()
@property(nonatomic, strong) ShareActivity *share;

@property(nonatomic, copy) NSString *shareText;
@property(nonatomic, copy) NSArray *images;
@property(nonatomic, copy) NSArray *urls;
@end

@implementation ShareActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _shareText = @"UIActivityViewController分享的文本";
    _images = @[[UIImage imageNamed:@"LaunchImage0.png"],
                [UIImage imageNamed:@"LaunchImage1.png"],
    ];
    _urls = @[
        [NSURL URLWithString:@"https://www.baidu.com"],
        [NSURL URLWithString:@"https://www.jianshu.com"],
    ];
    
 
    
    UIButton *btn = TKButtonFactory.btnOrangeCorner;
    [btn setTitleText:@"UIActivityViewController--NULL"];
    btn.frame = CGRectMake(40, 100, 280, 45);
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = TKButtonFactory.btnOrangeCorner;
    [btn1 setTitleText:@"UIActivityViewController--Test"];
    btn1.frame = CGRectMake(40, 170, 280, 45);
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = TKButtonFactory.btnOrangeCorner;
    [btn2 setTitleText:@"UIActivityViewController--images"];
    btn2.frame = CGRectMake(40, 240, 280, 45);
    [self.view addSubview:btn2];
    
    UIButton *btn3 = TKButtonFactory.btnOrangeCorner;
    [btn3 setTitleText:@"UIActivityViewController--urls"];
    btn3.frame = CGRectMake(40, 310, 280, 45);
    [self.view addSubview:btn3];
    
    UIButton *btn4 = TKButtonFactory.btnOrangeCorner;
    [btn4 setTitleText:@"UIActivityViewController--all"];
    btn4.frame = CGRectMake(40, 380, 280, 45);
    [self.view addSubview:btn4];
  
    [self.view addSubview:btn];
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    
    [btn addTarget:self action:@selector(openShare) forControlEvents:UIControlEventTouchUpInside];
    [btn1 addTarget:self action:@selector(openShare1) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(openShare2) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(openShare3) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(openShare4) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)openShare
{
    ShareActivity *share = [[ShareActivity alloc] initWithController:self text:nil images:nil urls:nil];
    [share show];
    self.share = share;
}

- (void)openShare1
{
    ShareActivity *share = [[ShareActivity alloc] initWithController:self text:_shareText images:nil urls:nil];
    [share show];
}

- (void)openShare2
{
    ShareActivity *share = [[ShareActivity alloc] initWithController:self text:nil images:_images urls:nil];
    [share show];
}

- (void)openShare3
{
    ShareActivity *share = [[ShareActivity alloc] initWithController:self text:nil images:nil urls:_urls];
    [share show];
}

- (void)openShare4
{
    ShareActivity *share = [[ShareActivity alloc] initWithController:self text:_shareText images:_images urls:_urls];
    [share show];
    self.share = share;
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
