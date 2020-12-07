//
//  UIView+TK.h
//  AdultLP
//
//  Created by mac on 2019/7/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TK)

/**  为UIView添加橙色的通用的阴影*/
- (void)addShadowLayerWithOrange;
/**  为UIView添加灰色的通用的阴影*/
- (void)addShadowLayerWithGray;

@end

NS_ASSUME_NONNULL_END
