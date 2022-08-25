//
//  TableViewController.h
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *dataAry;
@property(nonatomic, strong) ClassTypeModel *clsModel;


- (void)registerCell;
@end

NS_ASSUME_NONNULL_END
