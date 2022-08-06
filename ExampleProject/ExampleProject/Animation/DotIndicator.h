//
//  DotIndicator.h
//  ExampleProject
//
//  Created by PC on 2022/8/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DotIndicatorStyle){
    DotIndicatorStyleZoom = 0,
    DotIndicatorStyleLTR  = 1
};

@interface DotIndicator : UIView
@property(nonatomic, assign) CGFloat dotSize;
@property(nonatomic, assign) CGFloat dotSpace;
@property(nonatomic, assign) CFTimeInterval duration;//default 2.0
@property(nonatomic, assign) DotIndicatorStyle style;
@property(nonatomic, strong) UIColor *color1;
@property(nonatomic, strong) UIColor *color2;
@end

NS_ASSUME_NONNULL_END
