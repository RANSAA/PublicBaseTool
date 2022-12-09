//
//  TKGrayWhiteFilterView.m
//  ExampleProject
//
//  Created by PC on 2022/12/9.
//

#import "TKGrayWhiteFilterView.h"

@implementation TKGrayWhiteFilterView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return nil;
}

/**
 设置是否启用黑白模式，并将状态存储在NSUserDefaults中
 */
+ (void)setOpenWhiteBlackModel:(BOOL)isOpen
{
    NSString *key = @"kTKGrayWhiteFilterModelState";
    [NSUserDefaults.standardUserDefaults setValue:@(isOpen) forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];
}

+ (BOOL)isOpenWhiteBlackModel
{
    //该方法是用来存储是否为黑白模式
    NSString *key = @"kTKGrayWhiteFilterModelState";
    BOOL isOpenWhiteBlackModel = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    return isOpenWhiteBlackModel;
}

+ (instancetype)showGrayWhiteFilterWithSuperView:(UIView *)superView
{
    TKGrayWhiteFilterView *overlay = nil;
    if (self.isOpenWhiteBlackModel) {
        if (@available(iOS 13.0, *)) {//只支持13及以上
            for (UIView *vi in superView.subviews) {
                if ([vi isKindOfClass:TKGrayWhiteFilterView.class]) {
                    overlay = (TKGrayWhiteFilterView*)vi;
                    [superView bringSubviewToFront:overlay];
                    break;;
                }
            }
            if (!overlay) {
                overlay = [[TKGrayWhiteFilterView alloc] initWithFrame:superView.bounds];
                overlay.userInteractionEnabled = NO;
                overlay.translatesAutoresizingMaskIntoConstraints = NO;
                overlay.backgroundColor = [UIColor lightGrayColor];
                overlay.layer.compositingFilter = @"saturationBlendMode";
                [superView addSubview:overlay];
                [superView bringSubviewToFront:overlay];
                NSDictionary *dic = @{@"view":overlay};
                [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:dic]];
                [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:dic]];
            }
        }
    }
    return overlay;
}

/**
 将黑白滤镜从指定view上移出
 */
+ (void)removeGrayWhiteFilterFrom:(UIView *)superView
{
    [self setOpenWhiteBlackModel:NO];
    for (UIView *vi in superView.subviews) {
        if ([vi isKindOfClass:TKGrayWhiteFilterView.class]) {
            [vi removeFromSuperview];
        }
    }
}

@end
