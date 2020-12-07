//
//  TKSDKGridViewController.h
//  Review
//
//  Created by PC on 2020/9/14.
//  Copyright © 2020 PC. All rights reserved.
//

/**
 功能说明：自定义NavigationBar+UICollectionView
 实现方式：在ViewController中添加一个UITableView来实现与TKSDKCollectionViewController相同的功能。
 区别说明：
        TKSDKGridViewController：继承TKSDKViewController并在其中添加一个UICollectionView。
        TKSDKCollectionViewController：继承UICollectionViewController，并在其中新建了一个newView,让其与collectionView交换位置。
                                    注意：self.view返回的是newView,而不是collectionView

 使用注意：
        TKSDKGridViewController使用是必须重新实现UICollectionViewLayout后者UICollectionViewDelegateFlowLayout协议
*/


#import <UIKit/UIKit.h>
#import "TKSDKViewController.h"



NS_ASSUME_NONNULL_BEGIN

@interface TKSDKGridViewController : TKSDKViewController <UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *collectionView;
/** collectionView.leftAnchor距离self.view左边的距离*/
@property(nonatomic, assign) CGFloat collectionViewLeftAnchorConstant;
/** collectionView.rightAnchor距离self.view右边的距离*/
@property(nonatomic, assign) CGFloat collectionViewRightAnchorConstant;
/** collectionView.topAnchor距离self.view顶部topLayoutGuide.bottom的距离*/
@property(nonatomic, assign) CGFloat collectionViewTopAnchorConstant;
/** collectionView.bottomAnchor距离self.view底部bottomLayoutGuide.bottom的距离*/
@property(nonatomic, assign) CGFloat collectionViewBottomAnchorConstant;

/** overload UICollectionViewDataSource方便编辑器代码提示 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
