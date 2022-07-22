//
//  TKSDKRefresh.h
//  TKSDKUniversal
//
//  Created by PC on 2019/1/9.
//  Copyright © 2019年 PC. All rights reserved.
//

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

/** 可以直接重写该方法 */
+ (instancetype)shared;
/**
 获取Bundle指定目录下的所有文件的详细路径路径
 
 @param bundelName Bundle名
 @param subPath Bundle的子目录，可为空
 @param trgetName Bundle中需要获取的目标文件夹名称可为空
 @return 返回所有排序好了的路径
 例如：[self loadTKSDKToolBundleWithBundelName:@"TKSDKTool" subPath:@"动图数组" srcName:@"蓝白猫"];
 */
- (NSArray *)loadTKSDKToolBundleWithBundelName:(NSString *)bundelName subPath:(NSString *)subPath   trgetName:(NSString *)trgetName;

#pragma mark -------------------------自定义/重写区域-------------------------
/**
 定制通用刷新样式配置，重写该方法修改刷新样式
 PS: 重写该方法时最好是先super
 **/
- (void)customPublicRefreshStyle;

#pragma mark -------------------------刷新状态控制区域-------------------------
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


#pragma mark -------------------------header，footer状态提示，显示等设置区域-------------------------
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


#pragma mark -------------------------下拉，上拉刷新等操作区域-------------------------
/** 下拉刷新MJRefreshNormalHeader */
- (MJRefreshNormalHeader *)headerNormalWith:(UIScrollView *)scrollView traget:(id)traget refreshAction:(SEL)refreshAction;
/** 下拉刷新MJRefreshNormalHeader */
- (MJRefreshNormalHeader *)headerNormalWith:(UIScrollView *)scrollView refreshBlock:(void(^)(void))refreshBlock;
/** 下拉刷新MJRefreshGifHeader */
- (MJRefreshGifHeader *)headerGifWith:(UIScrollView *)scrollView traget:(id)traget refreshAction:(SEL)refreshAction;
/** 下拉刷新MJRefreshGifHeader */
- (MJRefreshGifHeader *)headerGifWith:(UIScrollView *)scrollView refreshBlock:(void(^)(void))refreshBlock;

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
