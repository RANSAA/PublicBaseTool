//
//  TKTextViewFactory.h
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKTextViewFactory : NSObject
+ (UITextView *)defaultStyle;
+ (void)setDefaultStyleWith:(UITextView *)textView;

@end

NS_ASSUME_NONNULL_END
