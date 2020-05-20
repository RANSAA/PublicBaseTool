//
//  AddressManager.h
//  AdultLP
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

/**
 文件说明：用于管理url地址
 */

#ifndef AddressManager_h
#define AddressManager_h

/** 服务器HTTP请求通用头 */
//static NSString *ApiPublicHost = @"http://admin.study.wdjyzk.com/api/";
static NSString *ApiPublicHost = @"http://prostudy.wdjyzk.com/api/";//没有长连接
//static NSString *ApiPublicHost = @"http://swoole.wdjyzk.com/api/";//有长连接的域名
/** 服务器HTML请求通用头 */
static NSString *HTMLPublicHost = @"";
/** webSocket ws地址 **/
static NSString *ApiSocketWS = @"ws://swoole.wdjyzk.com/ws";


/** AliyunOSS  **/
static NSString *URLAliyunOSSEndPoint = @"http://oss-cn-shenzhen.aliyuncs.com";
/** AliyunOSS-上传资源路径前缀  **/
static NSString *URLAliyunOSSBucketUrl = @"http://pro-study.oss-cn-shenzhen.aliyuncs.com/";

#pragma mark token 刷新
/** token刷新 **/
static NSString *URLRefreshToken = @"refresh";
/** 阿里对象存储Token相关请求  **/
static NSString *URLAliyunOSSToken = @"file/token";
/** 图片上传  **/
static NSString *URLUpdateImage = @"util/upload-img";


#pragma mark 登录，注册
/**  登录 **/
static NSString *URLLogin = @"login";
/**  发送验证码 **/
static NSString *URLCodeSend  = @"code";
/**  校验验证码 **/
static NSString *URLCodeCheck = @"code/check";
/**  学校列表,专业机构列表 **/
static NSString *URLSchoolList = @"schools";
/**  注册验证码 **/
static NSString *URLRegisterCodeSend  = @"register/code";
/**  注册 **/
static NSString *URLRegister = @"user/register";
/**  用户资料有效性检测 **/
static NSString *URLRegisterCheck = @"user/data/check";
/**  重置密码 **/
static NSString *URLForgetPwd = @"password/reset";
/**  添加人脸信息 **/
static NSString *URLRegisterFace = @"user/face/supply";



#pragma mark 首页-我的课程
/** 我的课程-交流中心-班级列表  **/
static NSString *URLPlatformHomeClassList = @"discuss/my-classes";
/** 我的课程-交流中心-交流日程列表  **/
static NSString *URLPlatformHomeExchangeList = @"discuss/discuss-date";
/** 我的课程-交流中心-交流详情列表  **/
static NSString *URLPlatformHomeExchangeInfoList = @"discuss/list";
/** 我的课程-交流中心-发表交流  **/
static NSString *URLPlatformHomeExchangeInfoSumbit = @"discuss/send";
/** 我的课程-课程资讯列表  **/
//static NSString *URLPlatformHomeInformationList = @"course/news";
static NSString *URLPlatformHomeInformationList = @"home/news";
/** 我的课程-课程资讯-资讯详情 **/
static NSString *URLPlatformHomeInformationInfo = @"course/news";


/** 我的课程-首页  **/
static NSString *URLPlatformHomeIndex = @"home/index";
/** 我的课程-首页-赛选  **/
static NSString *URLPlatformHomeIndexChange = @"home/index-change";
/** 我的课程-交流列表  **/
static NSString *URLPlatformHomePageExchangeList = @"discuss/home-date-list";
/** 我的课程-报考事项列表  **/
static NSString *URLPlatformHomeBeCarefulList = @"home/matters";



#pragma mark 课程详情
/** 课程详情-课程基本信息  **/
static NSString *URLCourseInfo = @"course-info/course-basic/";
/** 课程详情-课程章节列表  **/
static NSString *URLCourseChapterList = @"course-info/course-list/";
/** 课程详情-获取视频地址  **/
static NSString *URLCourseVideoUrl = @"course-info/course-video";
/** 课程详情-更新视频观看记录  **/
static NSString *URLCourseVideoUpdateSeek = @"course-info/record-video-logo";
/** 课程详情-教师详情  **/
static NSString *URLCourseTeacherInfo = @"course-info/teacher-detail/";
/** 课程详情-课程评价列表  **/
static NSString *URLCourseCommentList = @"course-info/get-course-comment";
/** 课程详情-发布课程评价  **/
static NSString *URLCourseCommentSend = @"course-info/add-course-comment";
/** 课程详情-获取课程笔记  **/
static NSString *URLCourseNoteList = @"course-info/get-course-note";
/** 课程详情-发布课程笔记  **/
static NSString *URLCourseNoteSend = @"course-info/add-course-note";
/** 课程详情-获取问答列表  **/
static NSString *URLCourseAskList = @"course-info/get-course-qa";
/** 课程详情-发布问答接口  **/
static NSString *URLCourseAskSend = @"course-info/add-course-qa";
/** 课程详情-获取问答回复列表  **/
static NSString *URLCourseAskDetailsList = @"course-info/get-reply-course-qa";
/** 课程详情-回复指定问答  **/
static NSString *URLCourseAskDetailsSend = @"course-info/add-reply-course-qa";
/** 课程详情-获取课程下面的试卷(注意视频播放完毕也会调用，只是只有一道题)  **/
static NSString *URLCourseTestPaperList = @"courses/get-papers/";
/** 课程详情-获取资料列表  **/
static NSString *URLCourseEnclosureList = @"course-info/material";




#pragma mark 平台课程
/** 平台课程-首页banner  **/
static NSString *URLPlatformHomeBanner = @"plantform/slideShow";
/** 平台课程-首页数据  **/
static NSString *URLPlatformHomeList = @"plantform/spec-course-list";
/** 平台课程-首页数据  **/
static NSString *URLPlatformHomeListPage = @"plantform/course-list";
/** 平台课程-首页数据  **/
static NSString *URLPlatformHomeSearch = @"search/course";
/** 平台课程-根据本科专科获取对应专业  **/
static NSString *URLPlatformCourseSwitch = @"plantform/specialty";
/** 平台课程-获取平台课程列表  **/
static NSString *URLPlatformCourseList = @"plantform/courses";


#pragma mark 人脸对比
/**  课程详情抓取人脸对比接口  **/
static NSString *URLFaceCheckCourseVideo = @"user/face/check";
/**  试卷抓取人脸识别接口  **/
static NSString *URLFaceCheckTestPaper = @"user/paper/face/check";
/**  人脸对比失败留图  **/
static NSString *URLFaceCheckErrorUpdate = @"user/face/fail";


#pragma mark 我的学习
/** 我的学习-我的课程  **/
static NSString *URLMyLearnCourseList = @"user/user-course";




#pragma mark 我的试卷
/** 我的试卷-新开试卷或打开未完成试卷接口
 添加：only_check=1    :查询试卷是否可以作答
 **/
static NSString *URLExamCheck = @"papers/open/";
/** 我的试卷-打开用户试卷记录  **/
static NSString *URLExamRecordOpen = @"papers/get-record/";
/** 我的试卷-提交试卷或保存试卷  **/
static NSString *URLExamPaperSave = @"papers/submit-record/";
/** 我的试卷-加入错题本  **/
static NSString *URLExamPaperWrongAdd = @"user-behavior/add-wrongs";
/** 我的试卷-删除错题本  **/
static NSString *URLExamPaperWrongRemove = @"user-behavior/delete-wrongs";
/** 我的试卷-用户试卷记录列表  **/
static NSString *URLExamPaperRecordList = @"paper-records";
/** 我的试卷-我的错题本  **/
static NSString *URLExamPaperWrongList = @"user-center/wrong";


#pragma mark 消息中心
/** 消息中心-列表 **/
static NSString *URLMsgCenterMsgList = @"messages";
/** 消息中心-详情 **/
static NSString *URLMsgCenterMsgInfo = @"messages/";//:注意这个
/** 消息中心-获取未读消息数量 **/
static NSString *URLMsgCenterUnreadMsgNum = @"user-center/new-message";


#pragma mark 个人中心
/** 个人中心-意见反馈 **/
static NSString *URLCenterFeedBack = @"user-center/send-feedback";
/** 个人中心-获取平台协议 **/
static NSString *URLCenterAgreementPlatform = @"user-center/get-privacy";
/** 个人中心-获取隐私协议 **/
static NSString *URLCenterAgreementPrivacy = @"user-center/get-user-privacy";
/** 个人中心-获取关于我们 **/
static NSString *URLCenterAgreementAbout = @"user-center/get-aboutme";
/** 个人中心-更新检测 **/
static NSString *URLCenterCheckUpdate = @"user-center/check-package";
/** 个人中心-获取订单列表 **/
static NSString *URLCenterMyOrder = @"user-center/orders";
/** 个人中心-我的笔记 **/
static NSString *URLCenterMyNote = @"user-center/notes";
/** 个人中心-我的问答 **/
static NSString *URLCenterMyAsk = @"user-center/qas";
/** 个人中心-收藏(通用) **/
static NSString *URLCenterKeep = @"user-behavior/collect";
/** 个人中心-我的收藏 **/
static NSString *URLCenterMyCollect = @"user-center/collect";
/** 个人中心-获取用户信息 **/
static NSString *URLCenterUserInfo = @"user/info";
/** 个人中心-更新用户信息 **/
static NSString *URLCenterUserInfoUpdate = @"user/info/update";
/** 个人中心-我的成绩 **/
static NSString *URLCenterMyGrade = @"user-center/grade";


















#pragma mark 首页-学习中心
/** 获取学期和课程类型 */
static NSString *URLHomeSemester = @"Specialty/ourse_types";
/** 学期类别对应的课程列表 */
static NSString *URLHomeSemesterList = @"lesson/postLesson";
/** 首页-课时详情
 id:课程id
 **/
static NSString *URLHomeStudyDetail = @"user/studyDetail";


#pragma mark 考试相关
/**  申请新的考试记录 **/
static NSString *URLNewExamRecord = @"exam/newExamRecord";


#pragma mark 课程学习-视频区域
/** 登录次数(查看课程)
 les_id:课程id
 */
static NSString *URLLessonLoginNum = @"lesson/LoginLogs";
/** 课程详情        ps:概览
 id : 课程id
 **/
static NSString *URLLessonInfo = @"lesson/postLessonAll";
/** 课程评价展示      ps:概览-学员评价
 les_id: 课程ID --> 不传则是所有评价
 type : 程度 0好评 1中评 2差评
 **/
static NSString *URLLessonComment = @"Evaluates/getEvaluates";
/** 课程课时页面      ps:目录
 id: 课程id
 **/
static NSString *URLLessonHour = @"lesson/getLessonHour";
/** 课程试卷        ps:试卷
 les_id:课程id
 **/
static NSString *URLLessonPapers = @"lesson/postPapers";
/** 课时详情        ps:拿到播放相关信息
 id: 课时id
 **/
static NSString *URLLessonHourAll = @"lesson/getLessonHourAll";
/** 获取课程课时进度
 hour_id: 课时id
 **/
static NSString *URLLessonUserHour = @"lesson/getUserHour";
/** 保存课程课时进度
 hour_id: 课时ID
 play_time :播放进度
 **/
static NSString *URLLessonSaveUserHour = @"lesson/saveUserHour";




#pragma mark 学习记录
/**  学习记录-学习记录列表 */
static NSString *URLRecordStudyList = @"user/studyRecord";
/**  学习记录-考试记录列表 */
static NSString *URLRecordExamList  = @"exam/myExamRecordLists";


#pragma mark 考试/试卷相关
/** 获取试卷详情接口    PS:试卷名称，考试时间，分数等信息*/
static NSString *URLExamGetExamDetails = @"exam/getExam";
/** 获取试卷记录信息(试卷数据)接口  */
static NSString *URLExamGetUserAnswer  = @"exam/getUserAnswer";
/** 提交试卷答案接口  */
static NSString *URLExamSaveUserAnswer  = @"exam/submitUserAnswer";





#pragma mark 个人中心
/** 个人中心-获取用户信息 **/
static NSString *URLUserGetInfo = @"user/getUserInfo";
/** 个人中心-设置个人信息(包括头像)，参数可选 */
static NSString *URLUserSetting = @"user/setting";
/** 个人中心-密码修改 **/
static NSString *URLUserPwdModifty = @"user/repassword";
/** 个人中心-密码修改-图片验证码 */
static NSString *URLUserPwdReCode = @"user/captcha";
/** 个人中心-获取验证码  */
static NSString *URLUserGetCode = @"user/getcode";
/** 个人中心-绑定/修改手机号  */
static NSString *URLUserBindTel = @"user/setMobile";


/** 在校成绩  **/
static NSString *URLUserScore = @"user/score";
/** 学籍-显示学籍表 **/
static NSString *URLStudentDetail = @"user/getUserDetail";
/** 学籍-学籍核对 **/
static NSString *URLStudentCheckDetail= @"user/detail";
/** 学籍-图像采集 **/
static NSString *URLUserImg= @"user/imgs";
/** 教学-通知公告,教学安排(多类型)  **/
static NSString *URLUserArticleList= @"article/getArticleList";




#pragma mark 协议相关
/** html 关于我们  **/
static NSString *URLHtmlAgreementAboutMe = @"user-center/get-aboutme-content";
/** html 隐私协议  **/
static NSString *URLHtmlAgreementPrivacy = @"user-center/get-user-privacy-content";
/** html 平台协议  **/
static NSString *URLHtmlAgreementPlatform = @"user-center/get-privacy-content";



#endif /* AddressManager_h */
