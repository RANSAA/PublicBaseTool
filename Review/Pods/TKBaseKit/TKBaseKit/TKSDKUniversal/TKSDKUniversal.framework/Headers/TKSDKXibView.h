//
//  BaseXibView.h
//  AF
//
//  Created by Apple on 2018/3/2.
//  Copyright © 2018年 PC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 功能说明：利用xib构建View的基类
 使用方式：直接使用init方法即可
 Xib说明：xib文件的名称要有类名保持一直
 绑定方式：直接绑定到xib文件的Fiel's Owner 的class上面
 作为子控件：本方创建的Xib控件可以直接在StoryBorad上面作为子控件使用，使用方式->直接绑定对应view的class即可
 注意：
    本类是直接在控件中添加了一层控件并与之绑定，如果要像一般控件一样操作self.XXX，请直接操作self.xibChildView.XXX

 */

@interface TKSDKXibView : UIView
/** TKSDKXibView的第一级子控件，如果要设置TKSDKXibView的背景颜色等，直接对xibChildView操作即可 */
@property(nonatomic, strong) UIView  *xibChildView;
/** TKSDKXibView的第一级子控件的颜色 */
@property(nonatomic, strong) UIColor *xibChildViewColor;

/**  view setupUI 之后可在该方法中进行对其子控件的一些操作*/
- (void)instanceSubView;

@end
