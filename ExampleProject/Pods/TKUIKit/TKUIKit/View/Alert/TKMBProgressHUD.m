//
//  TKMBProgressHUD.m
//  NovalSetApp
//
//  Created by Apple on 2018/3/21.
//  Copyright © 2018年 sayaDev. All rights reserved.
//

#import "TKMBProgressHUD.h"

@implementation TKMBProgressHUD
    
/**  HUD消除最大时间延迟 */
static CGFloat maxAfter = MAXFLOAT;//99999999999.0
/**  存放Loadding方式创建的HUD容器*/
static NSMutableArray *aryLoading = nil;
    
+(MBProgressHUD*)createHUDWithViwe:(UIView *)view mode:(MBProgressHUDMode)mode text:(NSString*)text after:(CGFloat)after
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:view];
    HUD.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [view addSubview:HUD];
    //mode要先设置，然后再设置其相应的属性
    HUD.mode = mode;
    //bezelView显示模式-颜色控制（其它bulr）
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    switch (mode) {
        case MBProgressHUDModeText:{//提示文字
            HUD.bezelView.color = [[UIColor blackColor]colorWithAlphaComponent:0.5];
            HUD.label.text = text;
            HUD.label.numberOfLines = 0;
            HUD.label.textColor = [UIColor whiteColor];
        }
            break;
        case MBProgressHUDModeIndeterminate:{//菊花-圈圈
            HUD.contentColor = [UIColor whiteColor];
            HUD.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            HUD.label.text = text;
        }
            break;
        case MBProgressHUDModeCustomView:{//自定义：提示图片的提示
            HUD.bezelView.color = [[UIColor blackColor]colorWithAlphaComponent:0.45];
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我的_白"]];
            HUD.label.text = text;
            HUD.label.textColor = [UIColor whiteColor];
        }
            break;
        case MBProgressHUDModeDeterminate:{//圆形进度条样式
            HUD.contentColor = [UIColor whiteColor];
            HUD.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.56];
            
            for (UIView *view in HUD.bezelView.subviews) {//这儿进行进度条样式调整，后面应该放到相应方法中去调整！
                if([view isKindOfClass:[MBRoundProgressView class]]){
                    NSLog(@"这儿进行进度，样式调整");
                    MBRoundProgressView *progreView = (MBRoundProgressView*)view;
                    progreView.progress = 0.45;
                    progreView.annular = YES;
                    progreView.progressTintColor = [UIColor whiteColor];
                    progreView.backgroundTintColor = [UIColor blackColor];
                }
            }
        }
            break;
        case MBProgressHUDModeAnnularDeterminate:{// 圆形进度条样式.和第二个有点不同
            
        }
            break;
        case MBProgressHUDModeDeterminateHorizontalBar:{//横向滚动进度条样式--
            
        }
            break;
    }
    //bezelView -- 是中间的那一块
    HUD.animationType = MBProgressHUDAnimationZoom;
    // 隐藏时候从父控件中移除
    HUD.removeFromSuperViewOnHide = YES;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:after];
    
    return HUD;
}
    
/** 显示提示文字 */
+ (void)showText:(NSString *)text inView:(UIView *)view after:(CGFloat)after
{
    if(!text){
        text = @"";
    }
    [TKMBProgressHUD createHUDWithViwe:view mode:MBProgressHUDModeText text:text after:after];
}

/** 显示提示文字 */
+ (void)showText:(NSString *)text inView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [TKMBProgressHUD showText:text inView:view after:1.5];
    });
}

/** 显示提示文字在KeyWindow上 */
+ (void)showText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [TKMBProgressHUD showText:text inView:[UIApplication sharedApplication].keyWindow after:1.5];
    });
}

/**显示loaing, 在after秒之后消除*/
+ (TKMBProgressHUD *)showLoaddingInView:(UIView *)view after:(CGFloat)after
{
    MBProgressHUD *HUD = [TKMBProgressHUD createHUDWithViwe:view mode:MBProgressHUDModeIndeterminate text:nil after:after];
    TKMBProgressHUD *obj = [TKMBProgressHUD new];
    obj.HUD = HUD;
    
    //将obj添加到数组容器中
    if (aryLoading ==nil) {
        aryLoading = [[NSMutableArray alloc]init];
    }
    [aryLoading addObject:obj];
    return obj;
}

/** 显示loaing不消除 */
+ (TKMBProgressHUD *)showLoaddingInView:(UIView *)view
{
    TKMBProgressHUD *obj =[TKMBProgressHUD showLoaddingInView:view after:maxAfter];
    return obj;
}
  
/** 在keyWindows上显示loaing不消除 */
+ (TKMBProgressHUD *)showLoadding
{
    TKMBProgressHUD *obj =[TKMBProgressHUD showLoaddingInView:[UIApplication sharedApplication].keyWindow after:maxAfter];
    return obj;
}
    
/** 移除Loading模式创建的HUD */
+(void)hideLoadingHUDafterDelay:(CGFloat)after
{
    NSInteger count = aryLoading.count;
    for (NSInteger i=0; i<count; i++) {
        TKMBProgressHUD *obj = [aryLoading objectAtIndex:i];
        if (aryLoading.count>1) {
            if (i==count-1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [obj.HUD hideAnimated:YES afterDelay:after];
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [obj.HUD hideAnimated:NO];
                });
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [obj.HUD hideAnimated:YES afterDelay:after];
            });
        }
    }
    //从容器中移除，防止一直存在，无法释放掉的问题
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(after * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger removeCount = count;
        if (count <= aryLoading.count) {
            removeCount = count;
        }else{
            removeCount = aryLoading.count;
        }
        for (NSInteger i=0; i<removeCount; i++) {
            [aryLoading removeObject:[aryLoading objectAtIndex:0]];
        }
    });
}

/** 隐藏showLoading */
+ (void)hideLoading
{
    [TKMBProgressHUD hideLoadingHUDafterDelay:0];
}
/** 隐藏showLoading */
+ (void)hideLoadingAfter:(CGFloat)after
{
    [TKMBProgressHUD hideLoadingHUDafterDelay:after];
}
    
    
@end


