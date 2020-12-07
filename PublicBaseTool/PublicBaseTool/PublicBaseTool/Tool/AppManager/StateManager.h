//
//  StateManager.h
//  Evaluate
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 mac. All rights reserved.
//
/**
 用于管理项目中的临时数据，即这些数据不需要保存
 **/
#import "BaseResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface StateManager : BaseModel
/** 未读消息数量  **/
@property(nonatomic, assign) NSInteger msgNum;

/** 标记是否弹出重新登录alert **/
@property(nonatomic, assign) BOOL isReloginAlert;
/** 标记用户重新登录时，是否进入了登录页面，退出登录页面时恢复为NO **/
@property(nonatomic, assign) BOOL isReloginJumpLogin;

/**
 人脸识别：标记是否达到最大识别次数，并且识别错误，但是当做识别成功回调
 PS:注意每次进入人脸识别需要复原
 **/
@property(nonatomic, assign) BOOL isFaceMaxErrorSuccess;

/**
 上次或者当前播放的视频ID
 记录条件：1. 视频点击了播放，即播放器获取到第一帧数据时记录

 复原置空：退出播放切页面时(PlayerViewController 释放时)，需要将该值设置为nil
 **/
@property(nonatomic, copy ) NSString *lastVideoID;



+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
