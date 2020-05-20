//
//  NotifactionManager.h
//  AdultLP
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

/**
文件说明：管理通知使用的key
*/


#ifndef NotifactionManager_h
#define NotifactionManager_h


#pragma mark 通知key

/** 注册成功 **/
static NSString *kNotifactionRegisterSuccess = @"kNotifactionRegisterSuccessKey";
/** 登录成功 */
static NSString *kNotifactionLoginSuccess = @"kNotifactionLoginSuccessKey";
/** 忘记密码修改成功  */
static NSString *kNotifactionForgetPwdSuccess = @"kNotifactionForgetPwdSuccessKey";
/** 过期需要重新登录 */
static NSString *kNotifactionReLogin = @"kNotifactionReLoginKey";
/** 通知跳转登录页面  **/
static NSString *kNotifactionJumpLoginPage = @"kNotifactionJumpLoginPage";


/** 从相册中选中图片--修改头像  **/
static NSString *kNotifactionSelectedPictureFromAlbum = @"kNotifactionSelectedPictureFromAlbum";
/** 通知更新获取用户信息  */
static NSString *kNotifactionUpdateUserInfo = @"kNotifactionUpdateUserInfo";


/** 视频播放器页面进行VC 跳转操作时，通知播放器页面暂停视频播放   **/
static NSString *kNotifactionVideoPlayerControllerJumpNewController = @"kNotifactionVideoPlayerControllerJumpNewController";
/** 通知保存视频进度-seek跳转 **/
static NSString *kNotifactionSaveVideoPlayCurrentTimeWithSeek = @"kNotifactionSaveVideoPlayCurrentTimeWithSeek";
/** 通知保存视频进度-播放完毕 **/
static NSString *kNotifactionSaveVideoPlayCurrentTimeWithPlayEnd = @"kNotifactionSaveVideoPlayCurrentTimeWithPlayEnd";

#pragma mark 字符串区域
/** 视频进度保存timeID **/
static NSString *kTimerIdSaveVideoPlayTime = @"LearnDetailsViewController-saveVideoTime";
/** 视频详情人脸校验时间检测通知  **/
static NSString *kTimerIdVideoCheckFaceTime = @"kTimerIdVideoCheckFaceTime";




/**  通知更新课程详情评价  **/
static NSString *kNotifactionUpdateCourseCommnet = @"kNotifactionUpdateCourseCommnet";
/**  刷新收藏的问答 **/
static NSString *kNotifactionUpdateKeepAsk = @"kNotifactionUpdateKeepAsk";



/**  课程详情页面-通知更新笔记列表 **/
static NSString *kNotifactionUpdateNoteList = @"kNotifactionUpdateNoteList";
/**  课程详情页面-通知更新试卷列表 **/
static NSString *kNotifactionUpdatePaperList = @"kNotifactionUpdatePaperList";



/**  通知跳转到首页对应的模块 **/
static NSString *kNotifactionJumpHomeModule = @"kNotifactionJumpHomeModule";

/**  通知更新获取未读消息数量 **/
static NSString *kNotifactionUpdateMsgNum = @"kNotifactionUpdateMsgNum";
/**  获取未读消息数量后更新个人中心消息数量显示 **/
static NSString *kNotifactionUpdateCenterMsgNumTips = @"kNotifactionUpdateCenterMsgNumTips";


/**  通知用户试卷列表记录更新 **/
static NSString *kNotifactionUpdateUserPaperRecordList = @"kNotifactionUpdateUserPaperRecordList";



#endif /* NotifactionManager_h */
