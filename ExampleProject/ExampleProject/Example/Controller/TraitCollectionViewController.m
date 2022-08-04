//
//  TraitCollectionViewController.m
//  ExampleProject
//
//  Created by PC on 2022/8/4.
//

#import "TraitCollectionViewController.h"

@interface TraitCollectionViewController ()
@property(nonatomic, strong) NSString *kvoUs;
@end

@implementation TraitCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    NSLog(@"TraitCollection状态改变。。");

    if (@available(iOS 13.0,*)) {
        //判断当前模式是否发生变化，因为屏幕旋转也会触发该方法。
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            NSLog(@"TraitCollection主题模式发生变化，可以在这儿做修改");
        }
    }

}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"viewWillTransitionToSize:%@     coordinator:%@",NSStringFromCGSize(size),coordinator);
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
