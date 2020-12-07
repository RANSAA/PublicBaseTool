//
//  StudentViewController.h
//  Review
//
//  Created by PC on 2020/9/2.
//  Copyright © 2020 PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"


NS_ASSUME_NONNULL_BEGIN

@interface StudentViewController : UIViewController
@property(nonatomic, copy) void (^backBlock)(void);
@end

NS_ASSUME_NONNULL_END
