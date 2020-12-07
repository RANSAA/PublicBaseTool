//
//  ImageToolVC.m
//  Review
//
//  Created by PC on 2020/9/15.
//  Copyright © 2020 PC. All rights reserved.
//

#import "ImageToolVC.h"
#import "TKImageTool.h"
#import "Review-Swift.h"


@interface ImageToolVC ()
@property(nonatomic, strong) NSMutableArray *toolAry;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, assign) NSTimeInterval start;
@property(nonatomic, assign) NSTimeInterval end;
@property(nonatomic, strong) UIImageView *imgView;
@end

@implementation ImageToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
     self.tableView.rowHeight = 44;

    self.TKNavigationBar.labTitle.text = @"TKSDKImageTool";
    self.image = kImageName(@"timg");
    NSString *path = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    NSLog(@"\r\n%@\r\n",path);

    self.imgView = [[UIImageView alloc] init];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.imgView.frame = CGRectMake(150, 80, 200, 200);
    [self.view addSubview:self.imgView];

}

- (NSMutableArray *)toolAry
{
    if (!_toolAry) {
        _toolAry = @[@"高斯模糊效果_推荐使用该方法进行高斯模糊处理",
                     @"高斯模糊_使用CoreImage实现_速度比较块_但是生成的图片比较大",
                     @"高斯模糊_使用CoreImage实现_速度很慢_生成的图片相对比较小",
                    @"根据颜色－创建矩形图片",
                    @"根据颜色－创建圆形图片",
                    @"创建一个圆环",
                    @"根据颜色数组创建等宽度的同心圆",
                    @"功能：根据图片数组与对应的比例数组创建同心圆环，每个圆环的宽度由proportions决定",
                    @"将图片大小进行等比例缩放 ",
                    @"指定图片的宽或者高进行等比例缩放-1",
                    @"指定图片的宽或者高进行等比例缩放-0",
                    @"将图片以最小的一边为标准，自动裁剪为正方形",
                    @"对图片指定区域进行裁剪",
                    @"从指定位置对图片进行剪裁_左上角",
                    @"从指定位置对图片进行剪裁_左下角",
                    @"从指定位置对图片进行剪裁_右下角",
                    @"从指定位置对图片进行剪裁_右上角",
                     @"从指定位置对图片进行剪裁_中心",
                     @" ",
                     @"将图片旋转_0",
                     @"将图片旋转_90",
                     @"将图片旋转_180",
                     @"将图片旋转_270",
                     @"将图片旋转-300"
        ].mutableCopy;
    }
    return _toolAry;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toolAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.toolAry[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.imgView.image = nil;
    NSString *name = self.toolAry[indexPath.row];
    for (NSInteger i=0; i<1; i++) {
        NSLog(@"running row:%ld index:%ld",indexPath.row,i);
        name = [name stringByAppendingFormat:@"-%ld",i];

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self imageToolWith:indexPath.row name:name];
        });

//        [NSThread sleepForTimeInterval:0.3];
    }
//    [self imageToolWith:indexPath.row];
}

- (void)imageToolWith:(NSInteger)row name:(NSString *)name
{
    self.start = CACurrentMediaTime();
    UIImage *img = nil;
    CGRect rect = CGRectMake(0, 0, 400, 400);
    UIColor *color = UIColor.purpleColor;
    switch (row) {
        case 0:
        {
            img = [TKImageTool TKBlurryImage:_image withBlurLevel:0.4];
        }
            break;
        case 1:
        {
            img = [UIImage TKBlurryGaussianSpeedMaxImage:_image withBlurLevel:8];
        }
            break;
        case 2:
        {
            img = [UIImage TKBlurryGaussianSpeedMinImage:_image withBlurLevel:8];
        }
            break;
        case 3:
        {
            img = [UIImage TKCreateSquareWithColor:color size:rect.size alpha:0.9];
        }
            break;
        case 4:
        {
            rect.size.width = 450;
            rect.size.height = 350;
            img = [UIImage TKCreateCircularWithColor:color size:rect.size alpha:0.7];
        }
            break;
        case 5:
        {
            img = [UIImage TKCreateCircularRingWithColor:color radius:200 width:22 alpha:1];
        }
            break;
        case 6:
        {
            NSArray *cols = @[UIColor.redColor,UIColor.orangeColor,UIColor.yellowColor,UIColor.clearColor,UIColor.greenColor,UIColor.purpleColor,UIColor.redColor];
            img = [UIImage TKCreateConcentricCirclesWithColors:cols radius:200 alpha:1];


        }
            break;
        case 7:
        {
            NSArray *cols = @[UIColor.redColor,
                              UIColor.clearColor,
                              UIColor.orangeColor,
                              UIColor.yellowColor,
                              UIColor.grayColor,
                              UIColor.greenColor,
                              UIColor.purpleColor];
            NSArray *nums = @[@(12),@(24),@(30),@(35.9),@(30),@(12),@(5)];

            img = [UIImage TKCreateConcentricCirclesWithColors:cols proportions:nums radius:200 alpha:1];
        }
            break;
        case 8:
        {
            img = [UIImage TKImageCompressScaleWith:_image scale:2];
        }
            break;
        case 9:
        {
            img = [UIImage TKImageCompressTragetWidthOrHeightWith:_image widthOrHeight:800 type:1];
        }
            break;
        case 10:
        {
            img = [UIImage TKImageCompressTragetWidthOrHeightWith:_image widthOrHeight:800 type:0];
        }
            break;
        case 11:
        {
            img = [UIImage TKImageTailoringToSquareWithImage:_image];
        }
            break;
        case 12:
        {
            rect.origin.y = 400;
            rect.size.width = 534;
            rect.size.height = 350;
            img = [UIImage TKImageTailoringToSquareWithImage:_image tragetFrame:rect];
        }
            break;
        case 13:
        {
            img = [UIImage TKImageTailoringToSquareWithImage:_image tragetSize:CGSizeMake(100, 100) type:0];
        }
            break;
        case 14:
        {
            img = [UIImage TKImageTailoringToSquareWithImage:_image tragetSize:CGSizeMake(100, 100) type:1];
        }
            break;
        case 15:
        {
            img = [UIImage TKImageTailoringToSquareWithImage:_image tragetSize:CGSizeMake(100, 100) type:2];
        }
            break;
        case 16:
        {
            img = [UIImage TKImageTailoringToSquareWithImage:_image tragetSize:CGSizeMake(100, 100) type:3];
        }
            break;
        case 17:
        {
            img = [UIImage TKImageTailoringToSquareWithImage:_image tragetSize:CGSizeMake(100, 100) type:4];
        }
            break;
        case 18:
         {
//             img = [UIImage TKImageRotationWithImage:_image rotation:0.5*M_PI*0.5+9];
         }
             break;
        case 19:
         {
             img = [UIImage TKImageRotationWithImage:_image angle:0 isExpand:YES];

         }
             break;
        case 20:
         {
             img = [UIImage TKImageRotationWithImage:_image angle:90 isExpand:YES];

         }
             break;
        case 21:
         {
             img = [UIImage TKImageRotationWithImage:_image angle:180 isExpand:YES];

         }
             break;
        case 22:
         {
             img = [UIImage TKImageRotationWithImage:_image angle:270 isExpand:YES];

         }
             break;
        case 23:
         {
             img = [UIImage TKImageRotationWithImage:_image angle:300 isExpand:YES];

         }
             break;
    }


//    [self saveImage:img row:row];
    [self saveImage:img row:row name:name];
}

- (void)saveImage:(UIImage *)image row:(NSInteger)row name:(NSString *)name
{
//    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@.jpg",NSHomeDirectory(),name];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        YYImageEncoder *jpegEncoder = [[YYImageEncoder alloc] initWithType:YYImageTypeJPEG];
//        jpegEncoder.quality = 0.9;
//        [jpegEncoder addImage:image duration:0];
//        NSData *jpegData = [jpegEncoder encode];
//        NSString *type = [UIImage TKImageTypeWithImageData:jpegData];
//        NSLog(@"type:%@",type);
////        [jpegData writeToFile:path atomically:YES];
//    });
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imgView.image = image;
    });
}


- (void)saveImage:(UIImage *)image row:(NSInteger)row
{
    
    self.end = CACurrentMediaTime();
    NSLog(@"%@  耗时:%.6f",self.toolAry[row],(_end-_start));
    dispatch_async(dispatch_get_global_queue(0, 0), ^{


        self.start = CACurrentMediaTime();
//
        NSString *path = [NSString stringWithFormat:@"%@/Documents/%@-1.jpg",NSHomeDirectory(),self.toolAry[row]];

//        NSData *data = UIImagePNGRepresentation(image);
//        [data writeToFile:path atomically:YES];
//        self.end = CACurrentMediaTime();

        NSLog(@"%@UIImagePNGRepresentation  耗时:%.6f",self.toolAry[row],(self.end-self.start));


        self.start = CACurrentMediaTime();
        path = [NSString stringWithFormat:@"%@/Documents/%@-2.jpg",NSHomeDirectory(),self.toolAry[row]];
        YYImageEncoder *jpegEncoder = [[YYImageEncoder alloc] initWithType:YYImageTypeJPEG];
        jpegEncoder.quality = 0.9;
        [jpegEncoder addImage:image duration:0];
        NSData *jpegData = [jpegEncoder encode];
        [jpegData writeToFile:path atomically:YES];
//
//
//        self.end = CACurrentMediaTime();
//        NSLog(@"%@YYImageEncoder  耗时:%.6f",self.toolAry[row],(self.end-self.start));
//
//        [TKImageTool TKImageTypeWithImageData:jpegData];
//
//        CGFloat c = [TKImageTool TKImageGifFramePlayTimeWithData:jpegData];
//        NSLog(@"c:%f",c);

       NSArray *files = [TKImageTool TKStringGetAllFilePathWithBundle:[NSBundle mainBundle] dirName:@"TKSDKTool.bundle"];
        NSLog(@"files:\n%@",files);
    });

    dispatch_async(dispatch_get_main_queue(), ^{
        self.imgView.image = image;
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
