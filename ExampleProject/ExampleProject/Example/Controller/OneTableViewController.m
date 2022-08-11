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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadData];

//    [LaunchPageManage.shared checkAgreement];


//

    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
     backBtn.title = @"返回";
    [backBtn setTitleTextAttributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:UIColor.redColor} forState:UIControlStateNormal];
     self.navigationItem.backBarButtonItem = backBtn;
    self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];



    NSLog(@"getKeyWindow:%@",[self getKeyWindow]);
    NSLog(@"getKeyWindow1:%@",[self getKeyWindow1]);

    //解决系统导航条切换时，右上角显示问题
    UIWindow *key = [self getKeyWindow];
    key.backgroundColor = UIColor.whiteColor;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassTypeModel *model = self.dataAry[indexPath.row];
    Class class = NSClassFromString(model.cls);
    id vc = [[class alloc] init];
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
