//
//  TKSDKRefresh.h
//  TKSDKUniversal
//
//  Created by PC on 2019/1/9.
//  Copyright © 2019年 PC. All rights reserved.
//

/**
 对MJRefresh进行了二次封装
 该类中的所有属性和customXXX定定制方法都是通用设置，如果对某个上拉刷新/下拉加载更多，进行定制。
 可以按照以下方式进行定制，例如：
     MJRefreshGifHeader *header = [[TKSDKRefresh shared] headerGifWith:weakSelf.tableView refreshBlock:^{
        //
        ...
     }];
     //对header进行定制
     ...
     [header beginRefreshing];
 */


#import <Foundation/Foundation.h>
#import "TKSDKToolExternalDefines.h"


NS_ASSUME_NONNULL_BEGIN

@interface TKSDKRefresh : NSObject
/** 下拉刷新的三个提示状态文字 **/
@property(nonatomic, copy) NSString *tipHeaderStateIdle;
@property(nonatomic, copy) NSString *tipHeaderStatePulling;
@property(nonatomic, copy) NSString *tipHeaderStateRefreshing;
/** 上拉加载更多的3个提示文字 */
@property(nonatomic, copy) NSString *tipFooterStateIdle;
@property(nonatomic, copy) NSString *tipFooterStatePulling;
@property(nonatomic, copy) NSString *tipFooterStateRefreshing;
@property(nonatomic, copy) NSString *tipFooterStateNoData;
/** 是否隐藏刷新时间显示 */
@property(nonatomic, assign) BOOL isHiddenHeaderLastTime;
@property(nonatomic, assign) BOOL isHiddenFooterLastTime;
/** 字体颜色 */
@property(nonatomic, strong) UIColor *colorFooterStateLabel;
@property(nonatomic, strong) UIColor *colorHeaderStateLabel;

+ (instancetype)shared;

#pragma mark 资源获取

/**
 根据bundle中的文件名称创建bundle
 bundle:
 dirName:bundle中的文件名称，例如:nil, /, dir_1 , dir1/dir2/dir3
 */
- (NSBundle *)createBundleWithInBundle:(NSBundle *)bundle dirName:(NSString *)dirName;

/**
 获取bundle中指定目录(一级目录)下的所有文件的文件名或者全路径
 bundle:指定bundle
 dirName：指定子目录名称，例如:nil, /, dir_1 , dir1/dir2/dir3
 isPath:是否返回全路径，YES:返回全路径 NO:只返回文件名称
 */
- (NSArray *)getAllFileNameWithBundle:(NSBundle *)bundle dirName:(NSString *)dirName isPath:(BOOL)isPath;

/**
 获取TKSDKTool.bundle中指定目录中的所有图片名称，与之对应的bundle
 dirName：目录名称，例如：@"动图数组/下拉刷新"
 return:
 {
    bundle:对应目录所在的bundle
    images:图片名称数组
 }
 */
- (NSDictionary *)getTKSDKToolBundleFileInfoWithDirName:(NSString *)dirName;

/**
 获取TKSDKTool.bundle中指定目录中的所有图片
 dirName：目录名称，例如：@"动图数组/下拉刷新"
 PS:该方法带缓存功能
 */
- (NSArray<UIImage *> *)getTKSDKToolImagesWithDirName:(NSString *)dirName;

/**
 清除TKSDKTool.bundle中指定目录中所有图片在内存中的缓存
 dirName：目录名称，例如：@"动图数组/下拉刷新"
 */
- (void)clearTKSDKToolImagesWithDirName:(NSString *)dirName;


#pragma mark 重写区域,可重新配置header，footer状态提示文字，颜色，是否显示等操作。
/**
 定制通用刷新样式配置，重写该方法修改刷新样式
 PS: 重写该方法时最好是先super
 **/
- (void)customPublicRefreshStyle;

/**
 设置header下拉刷新的状态提示-通用-公共设置
 :MJRefreshStateHeader
 如果定制可以重写该方法
 **/
- (void)customHeaderPublicStyleWithHeader:(MJRefreshStateHeader *)header;
/**
 定制gif header的通用通用样式，加载图片等，
 如果定制可以重写该方法
 **/
- (void)customHeaderGifPublicStyleWithHeader:(MJRefreshGifHeader *)header;
/**
 定制footer "没有更多数据" 公共通用显示，如需修改重写该方法即可，
 不过一般不建议重写该方法!
 @param tmpFooter footer
 @param tip 提示文字
 @param hiddenStateLabel 是否隐藏StateLabel
 :MJRefreshAutoStateFooter,MJRefreshBackStateFooter (重写需要区分)
 */
- (void)customFooterNoMoreDataStyleWithFooter:(MJRefreshFooter *)tmpFooter tip:(NSString *)tip hiddenStateLabel:(BOOL)hiddenStateLabel;
/**
 设置footer上拉加载更多的状态提示-通用-公共设置
 :MJRefreshAutoStateFooter,MJRefreshBackStateFooter (重写需要区分)
 如果定制可以重写该方法
 **/
- (void)customFooterPublicStyleWithFooter:(MJRefreshFooter *)tmpFooter;
/**
 设置footer上拉加载更多的状态提示-通用-公共设置
 :MJRefreshAutoGifFooter,MJRefreshBackGifFooter (重写需要区分)
 如果定制可以重写该方法
 **/
- (void)customFooterGifPublicStyleWithFooter:(MJRefreshFooter *)tmpFooter;


#pragma mark 刷新状态控制区域
/** 结束刷新header */
- (void)stopHeaderWith:(UIScrollView *)scrollView;
/** 结束刷新footer */
- (void)stopFooterWith:(UIScrollView *)scrollView;
/** 隐藏或者显示footer
 isHidden:  YES-隐藏footer    NO-显示footer
 */
- (void)hiddenFooterWith:(UIScrollView *)scrollView isHidden:(BOOL)isHidden;
/** 展示没有更多数据状态-提示使用公共通用的提示 */
- (void)endNoMoreDataWith:(UIScrollView *)scrollView;
/** 展示没有更多数据-使用自定义提示 */
- (void)endNoMoreDataWith:(UIScrollView *)scrollView tips:(NSString *)tips;


#pragma mark Header下拉刷新
/** 下拉刷新MJRefreshNormalHeader */
- (MJRefreshNormalHeader *)headerNormalWith:(UIScrollView *)scrollView traget:(id)traget refreshAction:(SEL)refreshAction;
/** 下拉刷新MJRefreshNormalHeader */
- (MJRefreshNormalHeader *)headerNormalWith:(UIScrollView *)scrollView refreshBlock:(void(^)(void))refreshBlock;
/** 下拉刷新MJRefreshGifHeader */
- (MJRefreshGifHeader *)headerGifWith:(UIScrollView *)scrollView traget:(id)traget refreshAction:(SEL)refreshAction;
/** 下拉刷新MJRefreshGifHeader */
- (MJRefreshGifHeader *)headerGifWith:(UIScrollView *)scrollView refreshBlock:(void(^)(void))refreshBlock;

#pragma mark Footer上拉加载更多

/**
 上拉刷新MJRefreshAutoNormalFooter
 默认隐藏footer,需要手动控制footer是否显示
 可以使用：hiddenFooterWith: isHidden: 控制
 **/
- (MJRefreshAutoNormalFooter *)footerAutoNormalWith:(UIScrollView *)scrollView traget:(id)traget refreshAction:(SEL)refreshAction;
/**
 上拉刷新MJRefreshAutoNormalFooter
 默认隐藏footer,需要手动控制footer是否显示
 可以使用：hiddenFooterWith: isHidden: 控制
 **/
- (MJRefreshAutoNormalFooter *)footerAutoNormalWith:(UIScrollView *)scrollView refreshBlock:(void(^)(void))refreshBlock;
/** 上拉刷新MJRefreshBackNormalFooter */
- (MJRefreshBackNormalFooter *)footerBackNormalWith:(UIScrollView *)scrollView traget:(id)traget refreshAction:(SEL)refreshAction;
/** 上拉刷新MJRefreshBackNormalFooter */
- (MJRefreshBackNormalFooter *)footerBackNormalWith:(UIScrollView *)scrollView refreshBlock:(void(^)(void))refreshBlock;
/** 上拉刷新MJRefreshAutoGifFooter **/
- (MJRefreshAutoGifFooter *)footerGifAutoWith:(UIScrollView *)scrollView traget:(id)traget refreshAction:(SEL)refreshAction;
/** 上拉刷新MJRefreshAutoGifFooter **/
- (MJRefreshAutoGifFooter *)footerGifAutoNormalWith:(UIScrollView *)scrollView refreshBlock:(void(^)(void))refreshBlock;
/** 上拉刷新MJRefreshBackGifFooter **/
- (MJRefreshBackGifFooter *)footerGifBackWith:(UIScrollView *)scrollView traget:(id)traget refreshAction:(SEL)refreshAction;
/** 上拉刷新MJRefreshBackGifFooter **/
- (MJRefreshBackGifFooter *)footerGifBackNormalWith:(UIScrollView *)scrollView refreshBlock:(void(^)(void))refreshBlock;


@end

NS_ASSUME_NONNULL_END
