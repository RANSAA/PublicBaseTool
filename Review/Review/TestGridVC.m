//
//  TestGridVC.m
//  Review
//
//  Created by PC on 2020/9/14.
//  Copyright © 2020 PC. All rights reserved.
//

#import "TestGridVC.h"

@interface TestGridVC ()<UICollectionViewDelegateFlowLayout>

@end

@implementation TestGridVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor TKLightColor:UIColor.whiteColor darkColor:UIColor.blackColor];
    [self add];

    self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void)add
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(168, 120);
    layout.minimumLineSpacing = 12;
    layout.minimumInteritemSpacing = 12;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg"]];
    img.frame = [UIScreen mainScreen].bounds;
    img.alpha = 0.5;
//    [self.view addSubview:img];
    [self.view insertSubview:img atIndex:0];

    self.collectionView.backgroundColor = UIColor.clearColor;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 21;
}

//- (UICollectionViewCell *)colle

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.purpleColor;
    cell.selectedBackgroundView.backgroundColor = UIColor.redColor;
    return cell;
}

#pragma mark layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(88, 88);
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
