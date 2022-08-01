//
//  BaseViewController.h
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import <UIKit/UIKit.h>
#import "ClassTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property(nonatomic, strong) ClassTypeModel *clsModel;
@end

NS_ASSUME_NONNULL_END
