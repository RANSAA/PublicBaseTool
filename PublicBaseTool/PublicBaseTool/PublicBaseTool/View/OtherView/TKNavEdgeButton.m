//
//  TKNavEdgeButton.m
//  LianCard
//
//  Created by Mac on 2019/3/25.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKNavEdgeButton.h"

@interface TKNavEdgeButton ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layLabWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layLabHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layLabLeftSpce;

@end

@implementation TKNavEdgeButton{
    CGFloat level1;
    CGFloat level2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)instanceSubView
{
    [self.labEdge setLayerCornerRadiusWith:6];
    self.xibChildViewColor = kColorAlpha;

    level1 = [self fontWidthWith:@"8"]+2;
    level2 = [self fontWidthWith:@"88"]+2;

    [self setEdgeNum:1];
}

/**
 设置红点显示数字，如果小于1，则不显示红点
 **/
- (void)setEdgeNum:(NSInteger)num
{
    if (num>0) {
        self.labEdge.hidden = NO;
        NSString *str = [NSString stringWithFormat:@"%ld",num];
        [self setText:str];
    }else{
        self.labEdge.hidden = YES;
    }
}

/**
 设置红点显示字符串，如果字符串长度小于1，为nil，则红点不显示
 **/
- (void)setEdgeText:(NSString *)text
{
    NSString *str = text;
    if (str.length<1) {
        str = @"";
        self.labEdge.hidden = YES;
    }else{
        self.labEdge.hidden =NO;
    }
    [self setText:str];
}

- (void)setText:(NSString *)text
{
    CGFloat width = [self fontWidthWith:text];
    if (width<=level1) {
        self.layLabWidth.constant = 14;
        self.layLabHeight.constant= 14;
        self.layLabLeftSpce.constant = -7;
        [self.labEdge setLayerCornerRadiusWith:7];
        self.labEdge.text = text;
    }else{
        self.layLabWidth.constant = 21;
        self.layLabHeight.constant= 14;
        self.layLabLeftSpce.constant = -10.5;
        [self.labEdge setLayerCornerRadiusWith:7];
        if (width<level2) {
            self.labEdge.text = text;
        }else{
            self.labEdge.text = @"99";
        }
    }
}

- (CGFloat)fontWidthWith:(NSString *)text
{
    CGFloat width = 0;
    width = [NSString TKGetTextHighOrWideString:text fixed:12 type:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]}];
    return width;
}

@end
