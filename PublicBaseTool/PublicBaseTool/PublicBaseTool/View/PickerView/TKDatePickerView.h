//
//  TKDatePickerView.h
//  Orchid
//
//  Created by Mac on 2019/2/23.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseXibView.h"

NS_ASSUME_NONNULL_BEGIN

@class TKDatePickerView;
@protocol TKDatePickerViewDelegate <NSObject>
@optional
/**
 date:当前选中时间
 dateStr：时间字符串格式为XXXX-XX-XX
**/
- (void)TKDatePickerViewWith:(TKDatePickerView *)view date:(NSDate *)date dateStr:(NSString *)dateStr;
@end

@interface TKDatePickerView : BaseXibView
@property(strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic, assign) NSInteger index;
@property(nonatomic, weak  ) id<TKDatePickerViewDelegate> delegate;

- (void)show;
- (void)showWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
