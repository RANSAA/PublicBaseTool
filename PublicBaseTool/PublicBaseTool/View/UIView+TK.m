//
//  UIView+TK.m
//  AdultLP
//
//  Created by mac on 2019/7/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIView+TK.h"

@implementation UIView (TK)

/**  为UIView添加橙色的通用的阴影*/
- (void)addShadowLayerWithOrange
{
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0.0, 3.0f);
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowRadius = 6.0;
    self.layer.shadowColor = [kHEXColor(@"#FF7517") colorWithAlphaComponent:0.3].CGColor;
}

/**  为UIView添加灰色的通用的阴影*/
- (void)addShadowLayerWithGray
{
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0.0, 3.0f);
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowRadius = 6.0;
    self.layer.shadowColor = [kHEXColor(@"#000000") colorWithAlphaComponent:0.16].CGColor;
}

#pragma mark view可以同时设置阴影与圆角，但是要注意该view的子控件frame超出部分是不会被剪切掉的
- (void)setTestDemoLayer
{
    //设置阴影与圆角
    self.layer.masksToBounds = NO;//
    self.layer.shadowColor = kColorImageBg.CGColor;
    self.layer.borderColor = kColorImageBg.CGColor;// 边框颜色建议和阴影颜色一致
    self.layer.borderWidth = 0.000001; // 只要不为0就行
    self.layer.cornerRadius = 12;//圆角
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4;
    self.layer.shadowOffset = CGSizeMake(0.0, 4.0f);
}

@end
