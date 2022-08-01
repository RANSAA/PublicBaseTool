//
//  TKLableFactory.h
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKLableFactory : NSObject
+ (UILabel *)labOrangeTextWhite;
+ (void)setOrangeTextWhiteWith:(UILabel *)lab;

+ (UILabel *)labYellowTextWhite;
+ (void)setYellowTextWhiteWith:(UILabel *)lab;
@end

NS_ASSUME_NONNULL_END
