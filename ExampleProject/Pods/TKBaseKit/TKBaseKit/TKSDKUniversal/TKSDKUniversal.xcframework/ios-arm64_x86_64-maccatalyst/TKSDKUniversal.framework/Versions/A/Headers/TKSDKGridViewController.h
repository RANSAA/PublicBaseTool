//
//  TKSDKGridViewController.h
//  Review
//
//  Created by PC on 2020/9/14.
//  Copyright © 2020 PC. All rights reserved.
//

/**
 功能说明：自定义NavigationBar+UICollectionView
 实现方式：在TKSDKViewController中添加一个UITableView来实现与TKSDKCollectionViewController类似的功能。
 区别说明：
        TKSDKGridViewController：继承TKSDKViewController并在其中添加一个UICollectionView。
        TKSDKCollectionViewController：继承UICollectionViewController。

 使用注意：
        TKSDKGridViewController使用是必须重新实现UICollectionViewLayout或者UICollectionViewDelegateFlowLayout协议
*/


#import <UIKit/UIKit.h>
#import "TKSDKViewController.h"



NS_ASSUME_NONNULL_BEGIN

@interface TKSDKGridViewController : TKSDKViewController <UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *collectionView;

/**
 是否根据TKNavigationBar的高度自动调整collectionView.topAnchor的约束值， Default:YES
 */
@property(nonatomic, assign) BOOL autoUpdateCollectionViewTopAnchor;
/**
 ⚠️:设置collectionView.topAnchor距离self.topLayoutGuide.bottom的constant值
 ⚠️:需要先将autoUpdateCollectionViewTopAnchor的值设置为NO，该方法才会有效。
 */
@property(nonatomic, assign) CGFloat collectionViewTopAnchorConstant;
/**
 collectionView.leftAnchor距离self.view.leftAnchor的constant值
 */
@property(nonatomic, assign) CGFloat collectionViewLeftAnchorConstant;
/**
 collectionView.rightAnchor距离self.view.rightAnchor的constant值
 */
@property(nonatomic, assign) CGFloat collectionViewRightAnchorConstant;
/**
 collectionView.bottomAnchor距离self.view.bottomAnchor的constant值
 */
@property(nonatomic, assign) CGFloat collectionViewBottomAnchorConstant;



/** overload UICollectionViewDataSource方便编辑器代码提示 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
