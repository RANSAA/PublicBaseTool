//
//  TKSystemPhotoPicker.m
//  TKUIKitDemo
//
//  Created by PC on 2021/1/4.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import "TKSystemPhotoPicker.h"
#import <CoreServices/CoreServices.h>
//#import <AssetsLibrary/AssetsLibrary.h>

@interface TKSystemPhotoPicker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong) UIImagePickerController *imagePicker;
@property(nonatomic, strong) UIViewController *tragetVC;//父Controller
@property(nonatomic, assign) TKSystemPhotoPickerStyle style;
@end

@implementation TKSystemPhotoPicker

+ (instancetype)showWithController:(UIViewController *)controller stylew:(TKSystemPhotoPickerStyle)style allowsEditing:(BOOL)allowsEditing isShear:(BOOL)isShear
{
    TKSystemPhotoPicker *picker = [TKSystemPhotoPicker new];
    picker.tragetVC = controller;
    picker.style = style;
    picker.allowsEditing = allowsEditing;
    picker.isShear = isShear;
    [picker setupAlertController];
    return picker;
}

+ (instancetype)showPhotoWithController:(UIViewController *)controller isShear:(BOOL)isShear
{
    return [self showWithController:controller stylew:TKSystemPhotoPickerPhoto allowsEditing:NO isShear:isShear];
}


+ (instancetype)showVideoWithController:(UIViewController *)controller isShear:(BOOL)isShear
{
    return [self showWithController:controller stylew:TKSystemPhotoPickerVideo allowsEditing:NO isShear:isShear];
}

- (void)setupAlertController
{
    UIAlertAction *cameraAction   = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self alertAction:0];
    }];
    UIAlertAction *albumAction   = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self alertAction:1];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self alertAction:2];
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:cameraAction];
    [alertController addAction:albumAction];
    [alertController addAction:cancelAction];
    
    //ipad
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover)
    {
        popover.sourceView = self.tragetVC.view;
        popover.sourceRect = CGRectMake(kScreenWidth/2.0, kScreenHeight/2.0-64, 0, 0);
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
//        popover.barButtonItem = showBtn;
    }
    
    [self.tragetVC presentViewController:alertController animated:YES completion:nil];
}

/** 点击事件 */
- (void)alertAction:(NSInteger)index
{
    switch (index) {
        case 0:{//拍照
            [self setupPickerAuthWithType:UIImagePickerControllerSourceTypeCamera];
        }
            break;
        case 1:{//从手机相册选择
            [self setupPickerAuthWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
            break;
        case 2:{//取消
            if ([self.delegate respondsToSelector:@selector(TKSystemPhotoPickerCancel:)]) {
                [self.delegate TKSystemPhotoPickerCancel:self];
            }
        }
    }
}

- (void)setupPickerAuthWithType:(UIImagePickerControllerSourceType)sourceType
{
    NSLog(@"type:%ld",sourceType);
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
       [TKPermissionCamera authWithAlert:YES completion:^(BOOL isAuth) {
           if (isAuth) {
               if ([UIDevice TK_isSimulator]) {
                   [TKPermissionCamera alertCameraError];
               }else{
                   [self initImagePickerWithType:sourceType];
               }
           }
       }];
    }else{
        [TKPermissionPhoto authWithAlert:YES level:TKPhotoAccessLevelReadWrite completion:^(BOOL isAuth) {
            if (isAuth) {
                [self initImagePickerWithType:sourceType];
            }
        }];

//        if (@available(iOS 14.0, *)) {
//            [self initImagePickerWithType:sourceType];
//        }else{
//
//        }
    }
}

- (void)initImagePickerWithType:(UIImagePickerControllerSourceType)sourceType
{
//    dispatch_async(dispatch_get_main_queue(), ^{
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.modalPresentationStyle = UIModalPresentationOverFullScreen; //UIModalPresentationFullScreen,UIModalPresentationOverFullScreen;
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = self.allowsEditing;
        self.imagePicker.sourceType = sourceType;
        if (self.style == TKSystemPhotoPickerPhoto) {
            self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        }else if(self.style == TKSystemPhotoPickerVideo){
            self.imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
        }else{
            self.imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
        }
        [self.tragetVC presentViewController:self.imagePicker animated:YES completion:nil];
        [self setNavigationStyleWith:self.imagePicker.navigationBar];
//    });
}

- (void)setAllowsEditing:(BOOL)allowsEditing
{
    _allowsEditing = allowsEditing;
    if (self.imagePicker) {
        self.imagePicker.allowsEditing = allowsEditing;
    }
}

- (void)setNavigationStyleWith:(UINavigationBar *)navigationBar;
{
    if (self.blockNavigation) {
        self.blockNavigation(navigationBar);
    }else{
        
//        UINavigationBar* aperBar = navigationBar;
        UINavigationBar* aperBar = [UINavigationBar appearance];//ios13.0+只能使用[UINavigationBar appearance]修改
//        aperBar.translucent = NO;
        UIColor *bgColor = [UIColor colorWithLight:UIColor.whiteColor dark:UIColor.blackColor];
        UIColor *titleColor  = [UIColor colorWithLight:UIColor.blackColor dark:kRGBColor(188, 188, 192)];
        UIColor *backColor   = [UIColor colorWithLight:kRGBColor(68, 68, 70) dark:kRGBColor(188, 188, 192)];
        aperBar.barTintColor = bgColor;
        aperBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        aperBar.tintColor = backColor;
        
        //设置图片背景
//        [aperBar setBackgroundImage:kImageName(@"nav-bar") forBarMetrics:UIBarMetricsDefault];
//        aperBar.shadowImage = [UIImage new];
//        aperBar.backIndicatorImage = [UIImage new];
    }
}



#pragma mark picker deleage
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if ([self.delegate respondsToSelector:@selector(TKSystemPhotoPickerCancel:)]) {
        [self.delegate TKSystemPhotoPickerCancel:self];
    }
    [self.tragetVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    [self setInfo:info];
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        UIImage *image = nil;
        if (self.allowsEditing) {//裁剪
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{//原图
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        if (self.isShear) {
            image = [UIImage TKImageTailoringToSquareWithImage:image];
        }
        
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera && _isSaveAlbum) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
            });
        }
        
        if (self.blockImageDone) {
            self.blockImageDone(image);
        }
        
        if ([self.delegate respondsToSelector:@selector(TKSystemPhotoPicker:resultImage:)]) {
            [self.delegate TKSystemPhotoPicker:self resultImage:image];
        }
    }else{
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoURL) {
            if (self.blockVideoDone) {
                self.blockVideoDone(videoURL);
            }
            if ([self.delegate respondsToSelector:@selector(TKSystemPhotoPicker:resultVideo:)]) {
                [self.delegate TKSystemPhotoPicker:self resultVideo:videoURL];
            }
        }
    }
    
    [self.tragetVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)setInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
//    NSLog(@"info:%@",info);
//    id url = [info valueForKey:UIImagePickerControllerReferenceURL];
//    ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
//    [lib  assetForURL:url resultBlock:^(ALAsset *asset) {
//        NSLog(@"asset:%@",asset);
//        ALAssetRepresentation *al = [asset defaultRepresentation];
//        NSLog(@"al:%@",al.fullScreenImage);
//        NSLog(@"al:%@",al.metadata);
//    } failureBlock:^(NSError *error) {
//
//    }];
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
