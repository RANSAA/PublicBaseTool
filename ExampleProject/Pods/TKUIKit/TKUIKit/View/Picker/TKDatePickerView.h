//
//  TKDatePickerView.h
//  Orchid
//
//  Created by Mac on 2019/2/23.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKUIBaseXib.h"
#import "TKAnimation.h"


NS_ASSUME_NONNULL_BEGIN

@class TKDatePickerView;
@protocol TKDatePickerViewDelegate <NSObject>
@optional
/**
 date:当前选中时间
 dateStr：时间字符串格式为XXXX-XX-XX
**/
- (void)TKDatePickerViewWith:(TKDatePickerView *)picker date:(NSDate *)date dateStr:(NSString *)dateStr;
@end

@interface TKDatePickerView : TKUIBaseXib
@property (strong, nonatomic) IBOutlet UIView *showView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIView *toolView;
@property (strong, nonatomic) IBOutlet UILabel *labTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (nonatomic, assign) NSInteger index;//标记picker

@property (copy  , nonatomic) BlockValue blockDate;//回调选中时间 NSDate
@property (copy  , nonatomic) BlockValue blockDateStr;//回调选中时间字符串，格式：yyyy-MM-dd
@property (nonatomic, weak  ) id<TKDatePickerViewDelegate> delegate;

- (void)show;
- (void)showWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
