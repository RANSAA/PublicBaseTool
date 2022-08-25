//
//  LaunchPageViewController.h
//  ExampleProject
//
//  Created by PC on 2022/8/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LaunchPageViewController : UIViewController
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, copy) void (^completion)(void);
@property(nonatomic, copy) void (^saveAgreementStatus)(void);
@end

NS_ASSUME_NONNULL_END
