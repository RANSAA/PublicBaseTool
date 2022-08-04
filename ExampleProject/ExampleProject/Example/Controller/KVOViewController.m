//
//  KVOViewController.m
//  ExampleProject
//
//  Created by PC on 2022/8/4.
//

#import "KVOViewController.h"

@interface KVOViewController ()
@property(nonatomic, assign) NSInteger a;
@property(nonatomic, assign) NSInteger b;
@property(nonatomic, assign) NSInteger c;
@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (NSInteger)a
{
    return _b+_c;
}

/**
 KVO计算属性 设置依赖键
 a的值依赖于b和c
 */
+ (NSSet *)keyPathsForValuesAffectingA
{
    return [NSSet setWithObjects:@"b",@"c", nil];
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
