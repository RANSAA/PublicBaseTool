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
 
 
 新增:
    新增了createXibView方法创建View，直接从Xib中加载View并返回。不能直接在其它Xib处直接使用当前方式创建的自定义类。
    注意与initXX相关方法的区别:
        createXibView:直接获取Xib中的View,在其他Xib中不能使用该类。Custom Class绑定位置:当前View
        initXX:将Xib文件中的View加载到当前类中，即View层级中多了一层，并且可以在其它的Xib中直接使用该类。Custom Class绑定位置:File's Owner
        PS:该方法创建的View不能使用任何与xibXX相关的方法都无效。
 */

@interface TKSDKXibView : UIView
/** TKSDKXibView的第一级子控件，如果要设置TKSDKXibView的背景颜色等，直接对xibChildView操作即可 */
@property(nonatomic, strong) UIView  *xibChildView;
/** TKSDKXibView的第一级子控件的颜色 */
@property(nonatomic, strong) UIColor *xibChildViewColor;

/** 重写该方法，可从指定bundle中加载xib */
- (NSBundle *)returnBundle;
+ (NSBundle *)returnBundle;
/** 重写该方法可以加载指定xib文件 */
- (NSString *)returnXibName;
+ (NSString *)returnXibName;

/**  view setupUI 之后可在该方法中进行对其子控件的一些操作*/
- (void)instanceSubView;


/**
 新增:直接从Xib中加载View,注意与initXX相关方法的区别。
 createXibView:直接获取Xib中的View,在其他Xib中不能使用该类。Custom Class绑定位置:当前View
 initXX:将Xib文件中的View加载到当前类中，即View层级中多了一层，并且可以在其它的Xib中直接使用该类。Custom Class绑定位置:File's Owner
 PS:该方法创建的View不能使用任何与xibXX相关的方法都无效。
 */
+ (instancetype)createXibView;

@end
