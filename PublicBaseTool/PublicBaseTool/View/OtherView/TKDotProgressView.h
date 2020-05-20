//
//  TKDotProgressView.h
//  Evaluate
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKDotProgressView : BaseXibView
@property (strong, nonatomic) IBOutlet UIView *hView;
@property (strong, nonatomic) IBOutlet UIView *dotView;
@property (strong, nonatomic) IBOutlet UILabel *labTitle;

@end

NS_ASSUME_NONNULL_END
