//
//  TKSimplePickerView.h
//  Orchid
//
//  Created by Mac on 2019/2/13.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TKUIBaseXib.h"
#import "TKAnimation.h"


@class TKSimplePickerView;
@protocol TKSimplePickerViewDelegate <NSObject>
@optional
- (void)TKSimplePickerView:(TKSimplePickerView*)picker didAtRow:(NSInteger)row;
- (void)TKSimplePickerView:(TKSimplePickerView*)picker didAtRow:(NSInteger)row title:(NSString *)title;
@end

@interface TKSimplePickerView : TKUIBaseXib
@property (strong, nonatomic) IBOutlet UIView *showView;
@property (strong, nonatomic) IBOutlet UIView *toolView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UILabel *labTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (assign, nonatomic) NSInteger index;//标记picker
@property (assign, nonatomic) NSInteger defaultIndex;//默认显示第几行
@property (assign, nonatomic) CGFloat fontSize;//row font size
@property (strong, nonatomic) NSArray *dataAry;//row title数据源

@property (copy  , nonatomic) BlockValue blockRow;//回调选中第几换 NSNumber
@property (copy  , nonatomic) BlockValue blockTitle;//回调选中的title NSString
@property (weak  , nonatomic) id<TKSimplePickerViewDelegate> delegate;

/** 直接显示在Windows上 */
- (void)show;
- (void)showWithView:(UIView *)view;

@end
