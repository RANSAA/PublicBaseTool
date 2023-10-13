//
//  OneTableViewController.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "OneTableViewController.h"
#import "ColorViewController.h"
#import "FontViewController.h"
#import "TraitCollectionViewController.h"
#import "KVOViewController.h"
#import "TransformViewController.h"
#import "FlowViewController.h"
#import "LaunchImageViewController.h"
#import "AppIconViewController.h"
#import "GrayWhiteViewController.h"
#import "UniversalLinkViewController.h"
#import "WKWebViewController.h"
#import "CoreDataViewController.h"
#import "Touch3DViewController.h"
#import "OrientationViewController.h"
#import "JumpToAppStoreViewController.h"
#import "TouchIDViewController.h"
#import "ShareActivityViewController.h"
#import "TKQRCodeToolViewController.h"
#import "TKLocationlocatorViewController.h"





@interface OneTableViewController ()

@end

@implementation OneTableViewController


- (void)loadData
{
    [self.dataAry addObject:[ClassTypeModel initWithName:@"字体管理" cls:@"FontViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"颜色管理" cls:@"ColorViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"TraitCollection" cls:@"TraitCollectionViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"KVO依赖属性设置" cls:@"KVOViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"Transform动画" cls:@"TransformViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"背景流动视图" cls:@"FlowViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"动态修改启动图" cls:@"LaunchImageViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"动态修改App图标" cls:@"AppIconViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"黑白纪念模式" cls:@"GrayWhiteViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"Universa lLink" cls:@"UniversalLinkViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"WKWebViewController" cls:@"WKWebViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"Core Data" cls:@"CoreDataViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"3D Touch 示例" cls:@"Touch3DViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"屏幕方向设置" cls:@"OrientationViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"跳转到App Store" cls:@"JumpToAppStoreViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"Touch ID" cls:@"TouchIDViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"系统自带UIActivityViewController分享控制器" cls:@"ShareActivityViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"二维码生成与扫描" cls:@"TKQRCodeToolViewController"]];
    [self.dataAry addObject:[ClassTypeModel initWithName:@"定位与地址编码-未完成" cls:@"TKLocationlocatorViewController"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


    
    /**
     注意backBarButtonItem与leftBarButtonItem的区别：
     backBarButtonItem:将会在子控制器中显示(push)
     leftBarButtonItem:直接在当前控制器中显示
     */
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"返回List";
    [backBtn setTitleTextAttributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:UIColor.redColor} forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = backBtn;
    self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];


    
    
    NSLog(@"OneTableViewController nav.....");
    [self loadData];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassTypeModel *model = self.dataAry[indexPath.row];
    Class class = NSClassFromString(model.cls);

    id vc;
    if([model.cls isEqualToString:@"WKWebViewController"]){
        WKWebViewController *web = [WKWebViewController instanceWithTitle:model.name urlString:@"https://www.bilibili.com/"];
//        WKWebViewController *web = [WKWebViewController instanceWithTitle:model.name urlString:@"https://www.jianshu.com/"];
//        WKWebViewController *web = [WKWebViewController instanceWithTitle:@"HTML Test" htmlString:@"<p>HTML String</p>" baseURL:nil];
       

        web.userAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1788.0  uacq";
        web.customRequest = YES;
        web.customNavBar = NO;
        web.updateTitle = YES;
        vc = web;
    }else{
        vc = [[class alloc] init];
    }
    [vc setValue:model forKey:@"clsModel"];
//    [vc setValue:@(YES) forKey:@"hidesBottomBarWhenPushed"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (UIWindow *)getKeyWindow
{
    if (@available(iOS 13.0, *))
    {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive)
            {
                for (UIWindow *window in windowScene.windows)
                {
                    if (window.isKeyWindow)
                    {
                        return window;
                    }
                }
            }
        }
    }
    else
    {
        return [UIApplication sharedApplication].keyWindow;
    }
    return nil;
}

- (UIWindow *)getKeyWindow1
{
    return  UIApplication.sharedApplication.windows.firstObject;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
