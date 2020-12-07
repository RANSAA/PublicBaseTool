//
//  TKSimplePhotoPicker.m
//  Evaluate
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKSimplePhotoPickerView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+Extension.h"


typedef NS_ENUM(NSUInteger, PickerType) {
    PickerTypePhoto  = 0,
    PickerTypeCamera = 1
};


@interface TKSimplePhotoPicker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TKSimplePhotoPickerViewDelegate>
@property(nonatomic, strong) UIImagePickerController *picker;
@property(nonatomic, strong) UIViewController *tragetVC;//父Controller
@property(nonatomic, strong) UIView *tragetView;//父View
@property(nonatomic, strong) TKSimplePhotoPickerView *popView;
@property(nonatomic, assign) BOOL isShear;//是否剪裁图片
@end

@implementation TKSimplePhotoPicker

/**
 创建并显示
 isShear:是否剪切图片
 **/
+ (instancetype)showWithController:(UIViewController *)controller isShear:(BOOL)isShear
{
    TKSimplePhotoPicker *picker = [[TKSimplePhotoPicker alloc] init];
    picker.tragetVC = controller;
    picker.isShear = isShear;
    picker.tragetView = appWin;
    [picker setupUI];
    return picker;
}


/**
 装载UI
 **/
- (void)setupUI
{
    self.popView = [[TKSimplePhotoPickerView alloc] init];
    self.popView.delegate = self;
    [self.tragetView.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
    [self.tragetView addSubview:self.popView];
    [self.popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tragetView);
    }];

}


- (void)TKSimplePhotoPickerViewClickIndex:(NSInteger)index
{
    WeakSelf
    if (index == 0) {//打开相机
        [[PrivacyPermission sharedInstance] accessPrivacyPermissionWithType:PrivacyPermissionTypeCamera completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
            if (response) {
                [self initImagePickerWithType:PickerTypeCamera];
            }else{
                [self openAuthAlertWithType:PickerTypeCamera];
            }
        }];
    }else if (index == 1){//打开相册
        [[PrivacyPermission sharedInstance] accessPrivacyPermissionWithType:PrivacyPermissionTypePhoto completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
            if (response) {
                [weakSelf initImagePickerWithType:PickerTypePhoto];
            }else{
                [weakSelf openAuthAlertWithType:PickerTypePhoto];
            }
        }];
    }
}

- (void)openAuthAlertWithType:(PickerType)type
{
    NSString *msgs = @"请允许访问相册";
    if (type == PickerTypeCamera) {
        msgs = @"请允许访问照相机";
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        TKAlertView *alert = [TKAlertView TKAlertViewWithTitle:@"提示" text:msgs];
        alert.blockDone = ^{
            [TKJumpToolUnit jumpAppSetting];
        };
    });
}

- (void)initImagePickerWithType:(PickerType)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (type == PickerTypeCamera) {
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.picker.delegate = self;
        self.picker.allowsEditing = self.allowsEditing;
        self.picker.sourceType = sourceType;
        [self.tragetVC presentViewController:self.picker animated:YES completion:nil];
        [self setNavigationBarStyleWith:self.picker.navigationBar];
    });
}

/**
 * 设置ImagePickerController 导航条的样式
 **/
- (void)setNavigationBarStyleWith:(UINavigationBar *)navigationBar
{
    if (self.blockPickerStyle) {
        self.blockPickerStyle(navigationBar);
    }else{
        navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        navigationBar.tintColor = [UIColor whiteColor];
//        [navigationBar setBackgroundImage:kImageName(@"nav-bg-green") forBarMetrics:UIBarMetricsDefault];
//        navigationBar.shadowImage = [UIImage new];
//        navigationBar.backIndicatorImage = [UIImage new];
        navigationBar.barTintColor  = kColorTheme;
        navigationBar.translucent = NO;
    }
}


#pragma mark - imagePicker delegate
/**
 *  完成回调
 *  @param picker imagePickerController
 *  @param info   信息字典
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {

        UIImage *image = nil;
        if (self.allowsEditing) {//裁剪
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{//原图
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }

//        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
//            });
//        }

        if (self.isShear == YES) {
            //根据屏幕方向裁减图片(720, 720)||(720, 720),如不需要裁减请注释
            image = [UIImage resizeImageWithOriginalImage:image];
//            image = [UIImage imageCompressForOriginalImage:image targetSize:CGSizeMake(400, 400)];
        }

#pragma mark 将image对象回调
        if (self.blockDone) {
            self.blockDone(image);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.popView removeView];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.tragetVC dismissViewControllerAnimated:YES completion:nil];
    [self.popView removeView];
}


//UIImagePickerController 编辑图片时的左下角取消按键难点击的问题
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([UIDevice currentDevice].systemVersion.floatValue < 11) {
        return;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")]) {
        [viewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.frame.size.width < 42) {
                [viewController.view sendSubviewToBack:obj];
                *stop = YES;
            }
        }];
    }
}


@end







#pragma mark --视图view区域


@interface TKSimplePhotoPickerView ()
@property (strong, nonatomic) IBOutlet UIView *showView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layShowViewBottomSpace;

@end

@implementation TKSimplePhotoPickerView

- (void)instanceSubView
{
    self.showView.backgroundColor = kColorAlpha;
    [self.topView setLayerCornerRadiusWith:10];
    [self.bottomView setLayerCornerRadiusWith:10];
    if ([UIDevice TK_isFullScreen]) {
        self.layShowViewBottomSpace.constant = 24+34;
    }else{
        self.layShowViewBottomSpace.constant = 24;
    }

}

#pragma mark 打开照相机
- (IBAction)btnCameraAction:(UIButton *)sender {
    [sender setViewUserInteractionEnabledCancel];
    [self hiddenView];
    [self callBackWithIndex:0];
}

#pragma mark 打开相册
- (IBAction)btnPhotoAction:(UIButton *)sender {
    [sender setViewUserInteractionEnabledCancel];
    [self hiddenView];
    [self callBackWithIndex:1];
}

- (IBAction)btnCancelAction:(UIButton *)sender {
    [sender setViewUserInteractionEnabledCancel];
    [self.superview.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
    [self removeView];
}

- (void)hiddenView
{
    [self.superview.layer addAnimation:[TKAnimation TKAnimationGetFade] forKey:nil];
    self.hidden = YES;
}

- (void)removeView
{
    [self removeFromSuperview];
    self.delegate = nil;
}


- (void)callBackWithIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(TKSimplePhotoPickerViewClickIndex:)]) {
        [self.delegate TKSimplePhotoPickerViewClickIndex:index];
    }
}


@end



