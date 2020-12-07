//
//  TKPointView.h
//  LianCard
//
//  Created by Mac on 2019/3/26.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKPointView : BaseXibView
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *dotAry;

@end

NS_ASSUME_NONNULL_END
