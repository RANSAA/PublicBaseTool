//
//  TKSearchBarFactory.h
//  ExampleProject
//
//  Created by PC on 2022/7/31.
//

#import <Foundation/Foundation.h>

/**
 注意如果直接使用UISearchBar定制搜索框效果不好时，可以使用UITextFeild与其它控件定制搜索框，推荐UITextFeild方式(可定制程度高)。
 */

NS_ASSUME_NONNULL_BEGIN

@interface TKSearchBarFactory : NSObject
+ (UISearchBar *)defaultStyle;
+ (void)setDefaultStyleWith:(UISearchBar *)searchBar;

+ (UISearchBar *)defaultStyle2;
+ (void)setDefaultStyle2With:(UISearchBar *)searchBar;

/**
 设置UISearchBar右边取消按钮样式与是否显示。
 注意:一般需要在UISearchBar的代理中动态修改样式
 */
+ (void)setCancelButtonStyleWith:(UISearchBar *)searchBar show:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
