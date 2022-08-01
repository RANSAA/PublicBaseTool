//
//  UITextField+Factory.h
//  ExampleProject
//
//  Created by PC on 2022/7/31.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Factory)

// MARK: - text与placeholder X轴上的偏移量
@property(nonatomic, assign) CGFloat offsetText;
@property(nonatomic, assign) CGFloat offsetPlaceholder;
@property(nonatomic, assign) CGFloat offsetLeftView;
@property(nonatomic, assign) CGFloat offsetRightView;

@end

NS_ASSUME_NONNULL_END
