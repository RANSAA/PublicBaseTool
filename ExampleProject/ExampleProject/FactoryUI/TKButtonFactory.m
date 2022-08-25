//
//  TKButtonFactory.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "TKButtonFactory.h"

@implementation TKButtonFactory

+ (UIButton *)btnOrangeCorner
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.bounds = CGRectMake(0, 0, 120, 44);
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
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.bounds = CGRectMake(0, 0, 120, 44);
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
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.bounds = CGRectMake(0, 0, 120, 44);
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
