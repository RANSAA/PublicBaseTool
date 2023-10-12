//
//  ShareActivity.m
//  ExampleProject
//
//  Created by kimi on 2023/10/12.
//

#import "ShareActivity.h"

@implementation ShareActivity



- (instancetype)initWithController:(UIViewController *)controller text:(nullable NSString *)shareText images:(nullable NSArray<UIImage *> *)images urls:(nullable NSArray<NSURL *> *)urls
{
    if(self = [super init]){
        self.controller = controller;
        self.shareText = shareText;
        self.images = images;
        self.urls = urls;
    }
    return self;
}


/** 显示分享页面 */
- (void)show
{
    // 要分享的内容
//    NSString *textToShare = @"这是要分享的文本";
//    UIImage *imageToShare = [UIImage imageNamed:@"yourImageName"]; // 你可以使用自己的图像
//    NSURL *urlToShare = [NSURL URLWithString:@"https://www.example.com"];

    __block NSMutableArray *itemsToShare = [NSMutableArray array];
    if (self.shareText) {
        [itemsToShare addObject:self.shareText];
    }

    if (self.images) {
        [itemsToShare addObjectsFromArray:self.images];
    }

    if (self.urls) {
        [itemsToShare addObjectsFromArray:self.urls];
    }

    // 创建 UIActivityViewController
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];

    // 设置 popoverPresentationController（仅用于iPad）
//    activityViewController.popoverPresentationController.sourceView = sender;
    activityViewController.popoverPresentationController.sourceView = self.controller.view;
    
    WeakSelf
    activityViewController.completionWithItemsHandler = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        NSLog(@"completionWithItemsHandler....");
        [itemsToShare removeAllObjects];
        itemsToShare = nil;
        weakSelf.urls = nil;
        weakSelf.shareText = nil;
        weakSelf.images = nil;
        weakSelf.controller = nil;
    };

    // 显示分享视图控制器
    [self.controller presentViewController:activityViewController animated:YES completion:nil];
}


- (void)dealloc
{
    _images = nil;
    _shareText = nil;
    _urls = nil;
    _controller = nil;
    NSLog(@"dealloc class:%@",self.class);
    NSLog(@"_images:%@",_images);
}

@end
