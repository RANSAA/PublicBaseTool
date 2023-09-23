//
//  TKButtonFactory.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "TKButtonFactory.h"

@implementation TKButtonFactory

+ (UIButton *)creationCustom
{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 按下状态下的文字颜色
    [btn setTitleColor:[UIColor.whiteColor colorWithAlphaComponent:0.15] forState:UIControlStateHighlighted];
    return btn;
}

//MARK: -
+ (UIButton *)btnOrangeCorner
{
    UIButton *btn = self.creationCustom;
    [self setOrangeCornerWith:btn];
    return btn;
}

+ (void)setOrangeCornerWith:(UIButton *)btn
{
    btn.backgroundColor = [TKColorManager systemOrange];
    [btn setTitleColor:kColorWhite forState:UIControlStateNormal];
    btn.titleLabel.font = kFont15;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 22;
}

+ (UIButton *)btnYellowCorner
{
    UIButton *btn = self.creationCustom;
    [self setYellowCornerWith:btn];
    return btn;
}

+ (void)setYellowCornerWith:(UIButton *)btn
{
    btn.backgroundColor = [TKColorManager systemYellow];
    [btn setTitleColor:kColorWhite forState:UIControlStateNormal];
    btn.titleLabel.font = kFont15;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 22;
}

+ (UIButton *)btnGreenCorner
{
    UIButton *btn = self.creationCustom;
    [self setGreenCornerWith:btn];
    return btn;
}

+ (void)setGreenCornerWith:(UIButton *)btn
{
    btn.backgroundColor = [TKColorManager systemGreen];
    [btn setTitleColor:kColorWhite forState:UIControlStateNormal];
    btn.titleLabel.font = kFont15;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 22;
}

@end
