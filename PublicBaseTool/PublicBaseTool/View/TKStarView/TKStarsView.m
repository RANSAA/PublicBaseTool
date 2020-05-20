//
//  TKStarsView.m
//  Evaluate
//
//  Created by mac on 2019/8/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKStarsView.h"


@implementation TKStarsView{
    UIView *showView;
    NSInteger lastIndex;
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
    self.xibChildViewColor = kColorAlpha;
    self.starAry = @[].mutableCopy;
    showView = [[UIView alloc] init];
    [self addSubview:showView];
    _itemSpace = 15;
    _isEnabledHalf = YES;
    _isSelected    = YES;
    lastIndex = 0;
    _imageNormal = kImageName(@"评分星星-未选中");
    _imageSelected = kImageName(@"评分星星-选中");
    _imageSelectHalf = kImageName(@"评分星星-选中-半");

    [self createStarItemView];
    [self totalStarNumber];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateItemFrame];
}

//创建item
- (void)createStarItemView
{
    for (NSInteger i=0; i<5; i++) {
        UIImageView *img = [[UIImageView alloc] init];
        img.contentMode = UIViewContentModeScaleAspectFit;
        img.clipsToBounds = YES;
        img.userInteractionEnabled = YES;
        img.tag = i;
        img.restorationIdentifier = @"0";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgItemAction:)];
        [img addGestureRecognizer:tap];
        [showView addSubview:img];
        [self.starAry addObject:img];
    }

    //刷新图标
    [self updateItemsImage];
}


/**
 更新item frame
 **/
- (void)updateItemFrame
{
    CGFloat height = self.bounds.size.height;
    CGFloat width = height;
    CGFloat space = _itemSpace;
    CGRect frame = CGRectMake(0, 0,width , height);
    CGFloat maxWidth = 0.0;

    for (NSInteger i=0; i<self.starAry.count; i++) {
        UIImageView *img = self.starAry[i];
        frame.origin.x = width*i+space*i;
        img.frame = frame;
        maxWidth = CGRectGetMaxX(frame);
    }

    //装载view
    CGRect svFrame = CGRectMake(0, 0, maxWidth, height);
    showView.frame = svFrame;
    showView.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
}


/**
 item点击
 restorationIdentifier :用于标记当前item处于什么状态:
 0:未选中状态
 1:选中状态
 2:选中一半状态
 (与isEnabledHalf的值有关)
 **/
- (void)tapImgItemAction:(UITapGestureRecognizer *)tap
{
    UIImageView *img = (UIImageView *)tap.view;
    NSInteger index = img.tag;
    NSInteger type  = img.restorationIdentifier.integerValue;
    type++;
    if (self.isEnabledHalf) {
        type %= 3;
    }else{
        type %= 2;
    }

    if (!self.isEnabledHalf && type == 2) {
        type = 1;
    }
    NSString *identifier = [NSString stringWithFormat:@"%ld",type];

    for (NSInteger i=0; i<self.starAry.count; i++) {
        UIImageView *img = self.starAry[i];
        if (i<index) {
            img.restorationIdentifier = @"1";
        }else{
            img.restorationIdentifier = @"0";
        }
    }
    if (index<lastIndex) {
        img.restorationIdentifier = @"1";
    }else{
        img.restorationIdentifier = identifier;
    }
    lastIndex = index;

    [self updateItemsImage];
    //统计星数
    [self totalStarNumber];
}

/**
 更新item显示的图标
 **/
- (void)updateItemsImage
{
    for (UIImageView *img in self.starAry) {
        NSInteger type = img.restorationIdentifier.integerValue;
        if (type==0) {
            img.image = self.imageNormal;
        }else if (type == 1){
            img.image = self.imageSelected;
        }else{
            img.image = self.imageSelectHalf;
        }
    }
}

/**
 计算当前星数，范围0.0-5.0星
 **/
- (void)totalStarNumber
{
    CGFloat num = 0;
    for (UIImageView *img in self.starAry) {
        NSInteger type = img.restorationIdentifier.integerValue;
        if (type==2) {
            num += 0.5;
        }else{
            num += type;
        }
    }
    //默认5星
    if (self.starType == 1) {//10星
        num *= 2.0;
    }
    NSString *starStr = [NSString TKStringRemoveZeroWithFloat:num];
    self.starNum = starStr;
    TKLog(@"当前星数：%@",starStr);
    //回调
}

/**
 设置显示星数，范围0.0-5.0星
 设置星级显示
 是否允许半星显示由isEnabledHalf确认
 不足一星的都按半星显示
 **/
- (void)setStarNumber:(CGFloat)star
{
    NSInteger index = star;
    BOOL isHalf = NO;//标记是否有半星
    NSString *tmp = [NSString stringWithFormat:@"%.f",star];
    if ([tmp isEqualToString:@"."] && self.isEnabledHalf) {
        isHalf = YES;
    }
    for (NSInteger i=0; i<self.starAry.count; i++) {
        UIImageView *img = self.starAry[i];
        if (i<index) {
            img.restorationIdentifier = @"1";
        }else if (i == index+1){
            if (isHalf) {
                img.restorationIdentifier = @"2";
            }else{
                img.restorationIdentifier = @"0";
            }
        }else{
            img.restorationIdentifier = @"0";
        }
    }
}


@end
