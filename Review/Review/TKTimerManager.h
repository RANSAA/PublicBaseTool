//
//  TKTimerManager.h
//  AdultLP
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//
/**
 定时器处理,默认处理单利，也可以不使用单利，但是需要timerID进行区分。
 定时定时器每执行一次发送一个通知，通知数据结构如下：
 NSDictionary *userInfo = @{kTimerTimerID:@(self.timerID),
                            kTimerCurrentTime:@(self.curInterval)
                           };
 
 **/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/** 定时器通知更新：带参数  */
extern NSString *kTKTimerManagerNotifactionUpdateDataKey;
/** 通知数据：定时器timerID key*/
extern NSString *kTKTimerManagerTimerID;
/** 通知数据：定时器当前时间戳 key*/
extern NSString *kTKTimerManagerCurrentTime;


@interface TKTimerManager : NSObject
/**
 定时器编号ID
 单利模式(默认)的ID为：@"0"
 非单利模式时需要设置timerID
 **/
@property(nonatomic, copy) NSString *timerID;
/** 定时器时间间隔，默认为1s **/
@property(nonatomic, assign)NSTimeInterval timeTnterval;

/** 单利 */
+(instancetype)shared;
/** 开始执行定时器 */
- (void)timerStart;
/** 开始执行定时器，不是立即执行，是定时器间隔时间断延迟之后自行  **/
- (void)timerStartAfter;
/** 暂停定时器  */
- (void)timerPause;
/** 继续定时器 */
- (void)timerResume;
/** 定时器失效-释放销毁 */
- (void)timerRelease;

@end

NS_ASSUME_NONNULL_END
