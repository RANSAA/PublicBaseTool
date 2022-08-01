//
//  FontViewController.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "FontViewController.h"

@interface FontViewController ()<UISearchBarDelegate>

@end

@implementation FontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBackStyle];
    [self setupUI];
}

- (void)setupUI
{
    UIButton *btn = TKButtonFactory.btnOrangeCorner;
    btn.frame = CGRectMake(24, 80, 280, 44);
    [btn setTitle:@"字体切换" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnSitchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.acceptEventInterval = .3;
    

    UIButton *btn1 = TKButtonFactory.btnGreenCorner;
    btn1.frame = CGRectMake(24, 140, 280, 44);
    [btn1 setTitle:@"UIButton字体效果" forState:UIControlStateNormal];
    [self.view addSubview:btn1];


    UILabel *lab1 = TKLableFactory.labOrangeTextWhite;
    lab1.frame = CGRectMake(24, 200, 280, 44);
    lab1.text = @"UILable字体效果";
    [self.view addSubview:lab1];


    UITextField *textField = [TKTextFieldFactory defaultStyle];
    textField.frame = CGRectMake(24, 260, 280, 40);
    textField.text = @"UITextField字体效果";
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"提示文字效果" attributes:@{NSForegroundColorAttributeName:kTextFieldPlaceholder,NSFontAttributeName:kFont15}];
//    textField.attributedPlaceholder = attr;
    textField.placeholder = @"搜索家居美图、商品、专贴和讨论帖";
    [self.view addSubview:textField];

    UITextField *textField2 = TKTextFieldFactory.titleInput;
    textField2.frame = CGRectMake(24, 320, 280, 40);
    textField2.text = @"UITextField字体效果";
    [self.view addSubview:textField2];



    UITextView *textView = [TKTextViewFactory defaultStyle];
    textView.frame = CGRectMake(24, 380, 280, 44);
    textView.text = @"UITextView字体效果";
    [self.view addSubview:textView];

//    NSLog(@"sub view button:%@",[self.view subViewOfClassName:@"UIButton"]);
//    NSLog(@"sub all views button:%@",[self.view subViewsOfClassName:@"UIButton"]);
//    NSLog(@"textfield:%f",textField.offsetCursorY);

    UISearchBar *searchBar = TKSearchBarFactory.defaultStyle;
    searchBar.frame = CGRectMake(24, 440, 280, 44);
    searchBar.text = @"UISearchBar";
    [self.view addSubview:searchBar];
    searchBar.delegate = self;

    UISearchBar *searchBar1 = TKSearchBarFactory.defaultStyle2;
    searchBar1.frame = CGRectMake(24, 500, 280, 44);
    searchBar1.text = @"UISearchBar Minimal";
    searchBar1.placeholder = @"搜索家居美图、商品、专贴和讨论帖";
    [self.view addSubview:searchBar1];


    UISearchBar *searchBar2 = [[UISearchBar alloc] init];
    searchBar2.frame = CGRectMake(24, 560, 280, 44);
    searchBar2.text = @"UISearchBar system";
    searchBar2.placeholder = @"搜索家居美图、商品、专贴和讨论帖";
    [self.view addSubview:searchBar2];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [TKSearchBarFactory setCancelButtonStyleWith:searchBar show:YES];
    return  YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [TKSearchBarFactory setCancelButtonStyleWith:searchBar show:NO];
    return  YES;
}



- (void)setNavBackStyle
{
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"person"] forState:UIControlStateNormal];
    //[_backButton setTitle:backStr forState:UIControlStateNormal];
    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
//    self.navigationItem.leftBarButtonItem = backItem;
}


- (void)backItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnSitchAction:(UIButton*)btn
{
    static NSInteger index = 0;
    NSInteger type = index%3;
    switch (type) {
        case 1:
            [TKFontManager.shared setFontName:@"AaJianHaoTi" isApply:YES];
            NSLog(@"font:AaJianHaoTi");
            break;
        case 2:
            [TKFontManager.shared setFontName:@"AaKADRXZW" isApply:YES];
            NSLog(@"font:AaKADRXZW");
            break;
        default:
            [TKFontManager.shared setFontName:@"system" isApply:NO];
            NSLog(@"font:恢复到系统默认字体");
            break;
    }
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
