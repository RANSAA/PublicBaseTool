//
//  TKSDKCollectionViewController.h
//  TKSDKUniversal
//
//  Created by PC on 2018/10/18.
//  Copyright © 2018年 PC. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TKSDKNavigationBar.h"

/**
继承于UICollectionViewController,实现自定义导航条以及一些常用的功能（如返回，侧滑等）
使用自定义的导航条--默认是把系统的导航条给隐藏了的
使用自定义的导航调配，新页面显示可以利用PUSH与Model的方式进行
支持侧滑返回(使用系统默认的侧滑返回方式)
实现了UIGestureRecognizerDelegate代理
注意：
       1.由于定制了自定义的导航条，需要给Controller的顶部留出导航条区域，所以创建了一个新的View用于替代默认的self.view
       2.导航条的默认高度为44，并且横竖屏不同状态可以分别设置导航条的高度，需要修改导航条的有效高度时，直接调用TKNavigationBar对应的方法即可
替换原理：
       先新建一个newView替换原来的self.view(默认是CollectionView),然后将系统默认的collectionView添加到新的newView上面。
       collectionView的约束条件：left,right.bottom都与superView(newView)的left,right,bottom保持一致；
       collectionView的top是以controller.TopLayoutGuide.Bottom为基准进行约束的，这些约束值都可以调整
其它：
       如果不需要新建newView进行替换默认的self.view只需要重写：setTKEnabledNewView 方法将其置空即可，
       不过重写了之后与newView相关的所有操作都无效了
 附加：
        如果要使CollectionView的顶部与控制器的最顶部保持一致(即状态栏区域不需要自动填充)时，可以配置contentInsetAdjustmentBehavior属性，
        autoUpdateCollectionViewTopAnchor = NO 属性与 [self setTKCollectionViewTopAnchorConstant:offY]方法来处理，
        其中offY可以根据contentInsetAdjustmentBehavior的值来设置是：2倍statusBar安全区域的值，还是1倍statusBar安全区域的值。
 
 PS:
    在使用contentInsetAdjustmentBehavior时一定要注意，如果将它的值设置为：UIScrollViewContentInsetAdjustmentNever时，
    使用IQKeyboardManager时，输入框不会随着键盘弹出而移动位置(系统的UICollectionViewController也会这样)，所以要注意该属性的使用


 使用场景：静态网格时推荐优先使用该控制器

 
*/




NS_ASSUME_NONNULL_BEGIN

@interface TKSDKCollectionViewController : UICollectionViewController <UIGestureRecognizerDelegate>
@property(nonatomic, strong) TKSDKNavigationBar * _Nullable TKNavigationBar;//自定义的导航条
@property(nonatomic, assign) BOOL isEnabledSideslip;//是否开启侧滑返回，默认开启
@property(nonatomic, assign) BOOL isEnabledTKNavigationBar;//是否开启TKNavigationBar的使用，默认开启
/**
作用：
        使控制器默认加载时不创建TKNavigationBar，只有当它的值设置为YES时才会有效，
        并且需要在[self viewDidLoad]方法或者之前设置才会有效。
可用于替换：
        [self defaultEnabledConfig]中重写的
        [self setValue:@(NO) forKey:@"_isEnabledTKNavigationBar"]操作
 */
@property(nonatomic, assign) BOOL isDefaultNoUseTKNavBar;


#pragma mark TKSDKNavigationBar默认配置相关区域
/**
默认配置方法，重写修改配置:
执行顺序：重写init，initWithXXXX方法时，就会执行该方法。
可修改的值：
       _isEnabledSideslip
       _isEnabledTKNavigationBar
注意:
       重写时先[self super]，再修改。修改时使用kvc的方式修改，如：
       [self setValue:@(NO) forKey:@"_isEnabledTKNavigationBar"];
PS:
       主要是当前controller作为childController时，默认不需要创建TKSDKNavigationBar时，重写！
*/
- (void)defaultEnabledConfig;



#pragma mark 新建newView替代默认的self.view处理区域
/**
 是否创建了newView用于替换默认的self.view,默认YES
 PS:isEnabledTKNewView的值外部不能修改，只能根据是否重写了setTKEnabledNewView方法修改，如果重写了其值为：NO
 */
@property(nonatomic, assign, readonly) BOOL isEnabledTKNewView;
/**
 作用：创建一个新的newView替换Controller中的self.view,并将原先的self.CollectionView添加到newView上面。
 约束方式：self.CollectionView的左右下与newView的左右下相关连，self.CollectionView的top方向是基于topLayoutGuide.bottom的。
 功能开关：只需要将该方法重写置空，即可关闭newView相关操作，使之相关联的属性无效化(PS:默认该功能是开启的)
 PS:根据是否开启了该功能决定,talbleView的get函数返回的对象是有区别的：UICollectionView或者UIView
 */
- (void)setTKEnabledNewView;
/**
是否自动根据TKNavigationBar调整tablView.tap的约束值，默认YES
*/
@property(nonatomic, assign) BOOL collectionViewAutoUpdateTopAnchor;
/**
 collectionView.topAnchor距离self.view顶部topLayoutGuide.bottom的距离
 有效条件：即需要先设置collectionViewAutoUpdateTopAnchor的值为NO，该方法才会有效
 */
@property(nonatomic, assign) CGFloat collectionViewTopAnchorConstant;
/** collectionView.leftAnchor距离self.view左边的距离*/
@property(nonatomic, assign) CGFloat collectionViewLeftAnchorConstant;
/** collectionView.rightAnchor距离self.view右边的距离*/
@property(nonatomic, assign) CGFloat collectionViewRightAnchorConstant;
/** collectionView.bottomAnchor距离self.view底部bottomLayoutGuide.bottom的距离*/
@property(nonatomic, assign) CGFloat collectionViewBottomAnchorConstant;



#pragma mark 默认基础函数区域
/**  返回函数操作 */
- (void)backAction:(id _Nonnull)sender;
/**
 当页面完全返回上一级页面后会调用该函数
 :- (void)didMoveToParentViewController:(UIViewController *)parent
 */
- (void)backDidParentControllerAction;


#pragma mark 状态栏相关显示设置
/**
 设置状态栏文字样式
 0:默认黑色
 1:白色高亮
 2:自动
*/
- (void)setStatusBarStyleType:(NSInteger)styleType;
/**  设置设备竖屏时，状态栏是否隐藏*/
- (void)setStatusBarIsHidden:(BOOL)isHidden;
/**
 设置设备横屏时，状态栏是否隐藏，默认隐藏
 PS:iOS13.0+无效，横屏时不能显示状态栏
 */
- (void)setStatusBarLandscapeIsHidden:(BOOL)isHidden;


#pragma mark 扩展UINavigationController相关方法
/**
  扩展使其等效于UINavigationController中对应的方法
  PS:如果当前控制器不在NavigationController中，则使其等效于对应present与dismiss方法
 */
- (void)pushViewController:(UIViewController *_Nullable)viewController animated:(BOOL)animated;
- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated;
- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *_Nullable)viewController animated:(BOOL)animated;


#pragma mark 工具函数区域
/**
作用：解决侧滑返回时，控制器左边有Scrollview控制而引起冲突问题，导致侧滑失效问题。
   ：即可以不设置控制器中多个控件都可以同时接收同一个手势
*/
- (void)setTKPanGestureRecognizerWithScrollView:(UIScrollView *_Nullable)scrollView;



@end

NS_ASSUME_NONNULL_END
