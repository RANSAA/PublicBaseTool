//
//  UIButton+TKSDK.h
//  testFor
//
//  Created by Mac on 2019/6/15.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 ⚠️注意：在UIButton扩展中添加setTitle:方法设置标题时,在iOS 10.3中可以正常设置，但是在iOS13.0+中无效，所以不要扩展setTitle:方法。
 */


NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TKSDK)
//这5个扩展的属性都是指UIControlStateNormal状态
@property(nonatomic, strong) NSString *text;        //等效titleText
@property(nonatomic, strong) NSString *titleText;   //等效text
@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIFont *titleFont;
@property(nonatomic, strong) UIImage *image;


#pragma mark Action
/** 添加一个action点击事件,并且添加了0.3秒防止重复点击 */
- (void)addActionWithBlock:(void(^)(UIButton *button))block;

@end

NS_ASSUME_NONNULL_END
