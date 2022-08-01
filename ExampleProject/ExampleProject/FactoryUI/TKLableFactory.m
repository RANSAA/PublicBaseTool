//
//  TKLableFactory.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "TKLableFactory.h"

@implementation TKLableFactory

+ (UILabel *)labOrangeTextWhite
{
    UILabel *lab = [[UILabel alloc] init];
    lab.bounds = CGRectMake(0, 0, 120, 44);
    [self setOrangeTextWhiteWith:lab];
    return lab;
}

+ (void)setOrangeTextWhiteWith:(UILabel *)lab
{
    lab.backgroundColor = [TKColorManage systemOrange];
    lab.font = kFont13;
    lab.textColor = kWhite;
    lab.textAlignment = NSTextAlignmentCenter;
}

+ (UILabel *)labYellowTextWhite
{
    UILabel *lab = [[UILabel alloc] init];
    lab.bounds = CGRectMake(0, 0, 120, 44);
    [self setOrangeTextWhiteWith:lab];
    return lab;
}

+ (void)setYellowTextWhiteWith:(UILabel *)lab
{
    lab.backgroundColor = [TKColorManage systemYellow];
    lab.textColor = kWhite;
    lab.font = kFont13;
    lab.textAlignment = NSTextAlignmentCenter;
}


@end
