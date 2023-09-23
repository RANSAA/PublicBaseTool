//
//  CoreDataViewController.m
//  TKSDKXibView
//
//  Created by kimi on 2023/5/18.
//

#import "CoreDataViewController.h"


#import "CoreDataService.h"



@interface CoreDataViewController ()
@property(nonatomic, strong) UITextView *textView;

@property(nonatomic, strong) CDPeopleModel *firstQuary;//查询到的第一个model
@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
}

- (void)setupUI
{
//    self.navigationItem.title = @"Core Data测试";
//    self.view.backgroundColor = UIColor.systemGray6Color;
    
    UIButton *btnAdd = TKButtonFactory.btnGreenCorner;
    btnAdd.frame = CGRectMake(80, 100, 80, 50);
    [btnAdd setTitle:@"添加" forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(btnAddAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAdd];
    
    UIButton *btnUpdate = TKButtonFactory.btnGreenCorner;
    btnUpdate.frame = CGRectMake(200, 100, 80, 50);
    [btnUpdate setTitle:@"修改" forState:UIControlStateNormal];
    [btnUpdate addTarget:self action:@selector(btnUpdateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnUpdate];
    
    UIButton *btnDel = TKButtonFactory.btnGreenCorner;
    btnDel.frame = CGRectMake(320, 100, 80, 50);
    [btnDel setTitle:@"删除" forState:UIControlStateNormal];
    [btnDel addTarget:self action:@selector(btnDelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDel];
    
    UIButton *btnQuary = TKButtonFactory.btnGreenCorner;
    btnQuary.frame = CGRectMake(80, 180, 160, 50);
    [btnQuary setTitle:@"查询sex==2" forState:UIControlStateNormal];
    [btnQuary addTarget:self action:@selector(btnQuaryAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnQuary];
    
    UIButton *btnQuaryAll = TKButtonFactory.btnGreenCorner;
    btnQuaryAll.frame = CGRectMake(320, 180, 80, 50);
    [btnQuaryAll setTitle:@"查询全部" forState:UIControlStateNormal];
    [btnQuaryAll addTarget:self action:@selector(btnQuaryAllAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnQuaryAll];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 260, 375, 460)];
    _textView.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_textView];
    _textView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *lay0 = [_textView.topAnchor constraintEqualToAnchor:btnQuaryAll.bottomAnchor constant:24];
    NSLayoutConstraint *lay1 = [_textView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:24];
    NSLayoutConstraint *lay2 = [_textView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-24];
    NSLayoutConstraint *lay3 = [_textView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-24];
    [NSLayoutConstraint activateConstraints:@[lay0,lay1,lay2,lay3]];
    
}

- (void)btnAddAction
{
    NSString *msg = [NSString stringWithFormat:@"Core Data Add ....."];
    [self msg:msg];
    
//    CDPeopleModel *model = [CoreDataService.shared testEntityModel];
//    [CoreDataService.shared saveContext];

    
    [CoreDataService.shared testInsetModel];
//    [CoreDataService.shared testAddPeopelAssociateBook];
    

}

- (void)btnUpdateAction
{
    NSString *msg = [NSString stringWithFormat:@"Core Data Update -> 更新查询到的第一个model ....."];
    [self msg:msg];
    
    if(self.firstQuary){
        self.firstQuary.name = [NSString stringWithFormat:@"Update - %u",arc4random()%225];
        [CoreDataService.shared updateModel:self.firstQuary];
    }

}

- (void)btnDelAction
{
    NSString *msg = [NSString stringWithFormat:@"Core Data Del -> 删除第一个查询到的Model......"];
    [self msg:msg];
    
    if(self.firstQuary){
        [CoreDataService.shared deleteModel:self.firstQuary];
        self.firstQuary = nil;
    }

}

- (void)btnQuaryAction
{
    
    NSArray *ary = [CoreDataService.shared testQuary];
    
    if(ary.count > 0){
        self.firstQuary = ary.firstObject;
    }
    
    NSString *msg = [NSString stringWithFormat:@"Core Data Quary -> 查询全部......\n%@",ary];
    [self msg:msg];
}

- (void)btnQuaryAllAction
{
    
   NSArray *ary = [CoreDataService.shared testQuaryAll];
    
    if(ary.count > 0){
        self.firstQuary = ary.firstObject;
    }
    
    NSString *msg = [NSString stringWithFormat:@"Core Data Quary -> 查询全部......\n%@",ary];
    [self msg:msg];
}

- (void)msg:(NSString *)msg
{
    NSLog(@"%@",msg);
    self.textView.text = msg;
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
