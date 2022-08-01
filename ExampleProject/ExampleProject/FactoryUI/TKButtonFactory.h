//
//  TKButtonFactory.h
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKButtonFactory : NSObject
+ (UIButton *)btnOrangeCorner;
+ (void)setOrangeCornerWith:(UIButton *)btn;

+ (UIButton *)btnYellowCorner;
+ (void)setYellowCornerWith:(UIButton *)btn;

+ (UIButton *)btnGreenCorner;
+ (void)setGreenCornerWith:(UIButton *)btn;

@end

NS_ASSUME_NONNULL_END
