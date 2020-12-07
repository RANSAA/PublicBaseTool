//
//  TKErrorPopView.m
//  LianCard
//
//  Created by Mac on 2019/3/23.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKErrorPopView.h"

@interface TKErrorPopView ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layImgErrorSpaceTop;
@end

@implementation TKErrorPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)instanceSubView
{
    [self.btnDone setLayerCornerRadiusWith:23];
    [self.btnDone setLayerBorderColor:kColorTheme borderWidth:1.5];
    [self.btnDone setTitleColor:kColorTheme];
}


- (IBAction)btnDoneAction:(UIButton *)sender {
    [self setViewUserInteractionEnabledCancel];
    if (self.blockDone) {
        self.blockDone();
    }
}

/** 设置图片距离顶部的距离*/
- (void)setSpaceTopWithType:(CGFloat)spaceTop
{
    self.layImgErrorSpaceTop.constant = spaceTop;
}

/** 创建 */
+ (instancetype)createViewWithView:(UIView*)view img:(NSString *)imgName title:(NSString *)title btnName:(NSString *)btnName
{
    WeakObj(view)
    TKErrorPopView *popView = [[TKErrorPopView alloc] init];
    [view addSubview:popView];
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(viewWeak);
    }];
    popView.imgError.image = kImageName(imgName);
    popView.labRemark.text = title;
    [popView.btnDone setTitle:btnName];
//    CGFloat height = 50;
//    if (Screen_Width>320) {
//        height = 100;
//    }
//    popView.layImgErrorSpaceTop.constant = kStatusHeight+height;
    return popView;
}

/** 创建并显示网络连接失败页面  */
+ (instancetype)createErrorNoNetworkShowView:(UIView *)view
{
    TKErrorPopView *popView = [self createViewWithView:view img:@"tips-errorNoWorking" title:@"网络连接失败，请重试!" btnName:@"重试"];
    return popView;
}

/** 创建并显示没有数据的页面  */
+ (instancetype)createErrorNoDataShowView:(UIView *)view
{
    TKErrorPopView *popView = [self createViewWithView:view img:@"tips-errorNoData" title:@"暂时没有内容!" btnName:@"刷新"];
    popView.btnDone.hidden = YES;
    return popView;
}

/** 创建并显示数据加载失败页面  */
+ (instancetype)createErrorLoadFailShowView:(UIView *)view
{
    TKErrorPopView *popView = [self createViewWithView:view img:@"tips-errorLoadFail" title:@"数据加载失败，请重试!" btnName:@"重试"];
    return popView;
}


@end
