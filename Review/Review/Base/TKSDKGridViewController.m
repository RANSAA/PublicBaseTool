//
//  TKSDKGridViewController.m
//  Review
//
//  Created by PC on 2020/9/14.
//  Copyright © 2020 PC. All rights reserved.
//

#import "TKSDKGridViewController.h"

@interface TKSDKGridViewController ()
@property(nonatomic, strong, nullable) NSLayoutConstraint *layTKCollectionViewLeftAnchor;
@property(nonatomic, strong, nullable) NSLayoutConstraint *layTKCollectionViewRightAnchor;
@property(nonatomic, strong, nullable) NSLayoutConstraint *layTKCollectionViewTopAnchor;
@property(nonatomic, strong, nullable) NSLayoutConstraint *layTKCollectionViewBottomAnchor;
@end

@implementation TKSDKGridViewController{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupChildCollectionView];
}

- (void)setupChildCollectionView
{
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewLayout new]];
    _collectionView.backgroundColor = [UIColor TKLightColor:UIColor.whiteColor darkColor:UIColor.blackColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat topHeight = self.TKNavigationBar.navViewPortraitHeight;//default 44
    if (@available(iOS 11.0, *)) {
        _layTKCollectionViewLeftAnchor   = [_collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0];
        _layTKCollectionViewRightAnchor  = [_collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0];
        _layTKCollectionViewTopAnchor    = [_collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:topHeight];
        _layTKCollectionViewBottomAnchor = [_collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0.0];
     } else {
        _layTKCollectionViewLeftAnchor   = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        _layTKCollectionViewRightAnchor  = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        _layTKCollectionViewTopAnchor    = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:topHeight];
        _layTKCollectionViewBottomAnchor = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];

     }
    _layTKCollectionViewLeftAnchor.active = YES;
    _layTKCollectionViewRightAnchor.active = YES;
    _layTKCollectionViewTopAnchor.active = YES;
    _layTKCollectionViewBottomAnchor.active = YES;
}

/** collectionView.leftAnchor距离self.view左边的距离*/
- (void)setCollectionViewLeftAnchorConstant:(CGFloat)collectionViewLeftAnchorConstant
{
    _collectionViewLeftAnchorConstant = collectionViewLeftAnchorConstant;
    self.layTKCollectionViewLeftAnchor.constant = collectionViewLeftAnchorConstant;
}

/** collectionView.rightAnchor距离self.view右边的距离*/
- (void)setCollectionViewRightAnchorConstant:(CGFloat)collectionViewRightAnchorConstant
{
    _collectionViewRightAnchorConstant = collectionViewRightAnchorConstant;
    self.layTKCollectionViewRightAnchor.constant = collectionViewRightAnchorConstant;
}

/** collectionView.topAnchor距离self.view顶部topLayoutGuide.bottom的距离*/
- (void)setCollectionViewTopAnchorConstant:(CGFloat)collectionViewTopAnchorConstant
{
    _collectionViewTopAnchorConstant = collectionViewTopAnchorConstant;
    self.layTKCollectionViewTopAnchor.constant = collectionViewTopAnchorConstant;
}

/** collectionView.bottomAnchor距离self.view底部bottomLayoutGuide.bottom的距离*/
- (void)setCollectionViewBottomAnchorConstant:(CGFloat)collectionViewBottomAnchorConstant
{
    _collectionViewBottomAnchorConstant = collectionViewBottomAnchorConstant;
    self.layTKCollectionViewBottomAnchor.constant = collectionViewBottomAnchorConstant;
}




#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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
