//
//  TKTimerManager.m
//  AdultLP
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKTimerManager.h"

NSString *kTKTimerManagerNotifactionUpdateDataKey = @"kTKTimerManagerNotifactionUpdateDataKey";
NSString *kTKTimerManagerTimerID     = @"kTKTimerManagerIDKey";
NSString *kTKTimerManagerCurrentTime = @"kTKTimerManagerCurrentTimeKey";

@interface TKTimerManager ()
@property (nonatomic, strong) NSTimer   *timer;//定时器
@property (nonatomic, assign) NSInteger curInterval;//当前时间的时间戳
@property (nonatomic, assign) BOOL isDelay;//定时器是否延迟执行（定时器时间间隔）
@end

@implementation TKTimerManager

- (id)init
{
    if (self = [super init]) {
        self.timerID = @"0";
        self.timeTnterval = 1;
    }
    return self;
}

+(instancetype)shared
{
    static dispatch_once_t onceToken;
    static TKTimerManager *obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [[TKTimerManager alloc] init];
    });
    return obj;
}

/** 开始执行定时器  **/
- (void)timerStart
{
    TKLog(@"TKTimerManager-开始获取当前时间的时间戳");
    self.isDelay = NO;
    if (!self.timer.valid) {
        self.curInterval = [[NSDate new] timeIntervalSince1970];//当前时间
        self.timer = [NSTimer timerWithTimeInterval:self.timeTnterval target:self selector:@selector(currentTimeStampNotifaction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
        [self.timer fire];//立即开始执行
    }else{
        [self.timer fire];//立即开始执行
    }
}

/** 开始执行定时器，不是立即执行，是定时器间隔时间断延迟之后自行  **/
- (void)timerStartAfter
{
    TKLog(@"TKTimerManager-开始获取当前时间的时间戳（延迟）");
    self.isDelay = YES;
    if (!self.timer.valid) {
        self.curInterval = [[NSDate new] timeIntervalSince1970];//当前时间
        self.timer = [NSTimer timerWithTimeInterval:self.timeTnterval target:self selector:@selector(currentTimeStampNotifaction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
    }else{
        NSDate *curDate = [NSDate new];
        curDate = [curDate dateByAddingTimeInterval:self.timeTnterval];
        self.curInterval = [curDate timeIntervalSince1970];
        [self.timer setFireDate:curDate];
    }
}

/** 暂停定时器  */
- (void)timerPause
{
    if (self.timer.valid) {
        TKLog(@"TKTimerManager-暂停定时器");
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

/** 继续定时器 */
- (void)timerResume
{
    if (self.timer.valid) {
        TKLog(@"TKTimerManager-继续定时器");
        if (self.isDelay) {
            NSDate *curDate = [NSDate new];
            curDate = [curDate dateByAddingTimeInterval:self.timeTnterval];
            self.curInterval = [curDate timeIntervalSince1970];
            [self.timer setFireDate:curDate];
        }else{
            self.curInterval = [[NSDate new] timeIntervalSince1970];//当前时间
            [self.timer setFireDate:[NSDate distantPast]];
        }
    }
}

/** 定时器失效-释放销毁 */
- (void)timerRelease
{
    if (_timer.valid) {
        TKLog(@"TKTimerManager-释放销毁");
        [_timer invalidate];
        _timer = nil;
    }
}

/** 获取当前时间戳定时器执行函数  */
- (void)currentTimeStampNotifaction
{
    self.curInterval++;
    NSDictionary *userInfo = @{kTKTimerManagerTimerID:self.timerID,
                               kTKTimerManagerCurrentTime:@(self.curInterval)
                               };
    [[NSNotificationCenter defaultCenter] postNotificationName:kTKTimerManagerNotifactionUpdateDataKey object:nil userInfo:userInfo];
}

@end
