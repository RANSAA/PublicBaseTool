//
//  TKPoint.h
//  TKUIKitDemo
//
//  Created by PC on 2021/6/3.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#ifndef TKPoint_h
#define TKPoint_h

//struct TKPoint {
//    CGFloat x;
//    CGFloat y;
//    CGFloat z;
//};
//
//typedef struct TKPoint TKPoint;

typedef struct __attribute__((objc_boxable)) TKPoint{
    CGFloat x;
    CGFloat y;
    CGFloat z;
}TKPoint;


UIKIT_STATIC_INLINE TKPoint TKPointMake(CGFloat x, CGFloat y, CGFloat z) {
    TKPoint point;
    point.x = x;
    point.y = y;
    point.z = z;
    return point;
}

#endif /* TKPoint_h */
