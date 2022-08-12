//
//  NSValue+TKSDK.h
//  TKBaseKit
//
//  Created by PC on 2021/12/25.
//  Copyright © 2021 PC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//rect的4个角
typedef struct __attribute__((objc_boxable)) UIEdgeCorners{
    CGFloat topLeft,bottomLeft,bottomRight,topRight;    
}UIEdgeCorners;

#define UIEdgeCornersZero UIEdgeCornersMake(0, 0, 0, 0)

UIKIT_STATIC_INLINE UIEdgeCorners UIEdgeCornersMake(CGFloat topLeft, CGFloat bottomLeft, CGFloat bottomRight, CGFloat topRight) {
    UIEdgeCorners corners = {topLeft, bottomLeft, bottomRight, topRight};
    return corners;
}

UIKIT_STATIC_INLINE BOOL UIEdgeCornersEqualToEdgeCorners(UIEdgeCorners corner1, UIEdgeCorners corner2) {
    return corner1.topLeft == corner2.topLeft && corner1.bottomLeft == corner2.bottomLeft && corner1.bottomRight == corner2.bottomRight && corner1.topRight == corner2.topRight;
}

UIKIT_EXTERN NSString *NSStringFromUIEdgeCorners(UIEdgeCorners corners);


@interface NSValue (TKSDK)
+ (NSValue *)valueWithUIEdgeCorners:(UIEdgeCorners)corner;
- (UIEdgeCorners)UIEdgeCornersValue;
@end

NS_ASSUME_NONNULL_END
