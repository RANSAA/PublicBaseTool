//
//  BaseXibView.h
//  AF
//
//  Created by Apple on 2018/3/2.
//  Copyright © 2018年 PC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 利用xib构建view的基类
 * ps:类名要与XIB文件名保持一致
 **/

@interface TKSDKXibView : UIView
/** TKSDKXibView的第一级子控件，如果要设置TKSDKXibView的背景颜色等，直接对xibChildView操作即可 */
@property(nonatomic, strong) UIView  *xibChildView;
/** TKSDKXibView的第一级子控件的颜色 */
@property(nonatomic, strong) UIColor *xibChildViewColor;

/**  view setupUI 之后可在该方法中进行对其子控件的一些操作*/
- (void)instanceSubView;

@end
