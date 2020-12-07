//
//  TKSimplePickerView.h
//  Orchid
//
//  Created by Mac on 2019/2/13.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseXibView.h"

@class TKSimplePickerView;
@protocol TKSimplePickerViewDelegate <NSObject>
@optional
- (void)TKSimplePickerView:(TKSimplePickerView*)view didAtRow:(NSInteger)row;
- (void)TKSimplePickerView:(TKSimplePickerView*)view didAtRow:(NSInteger)row title:(NSString *)title;
@end

@interface TKSimplePickerView : BaseXibView
@property (strong, nonatomic) IBOutlet UIView *showView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic) CGFloat fontSize;//显示字体大小
@property (copy  , nonatomic) NSString *title;//标题
/** title 数据源  */
@property (strong, nonatomic) NSArray *dataAry;
@property (weak  , nonatomic) id<TKSimplePickerViewDelegate> delegate;


/** 直接显示在Windows上 */
- (void)show;
- (void)showWithView:(UIView *)view;

@end
