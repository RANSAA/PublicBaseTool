//
//  ConfigManager.h
//  AdultLP
//
//  Created by mac on 2019/7/2.
//  Copyright © 2019 mac. All rights reserved.
//

/**
 文件说明：用于管理项目的配置文件
 */

#ifndef ConfigManager_h
#define ConfigManager_h

//声明任何类型参数，返回无类型的 block
typedef void(^BlockValues)(id value0,id value1);

/** 首页-我的课程 **/
#define StoryHome @"Home"
/** 学习记录 **/
#define StoryRecord @"Records"
/** 个人中心 **/
#define StoryUser @"User"
/** 登录页面 **/
#define StoryLogin @"Login"

//新的模块
/** 首页-我的课程 **/
#define StoryHomeCourse @"MyCourse"
/** 平台课程  **/
#define StoryPlatform @"PlatformCourse"
/** 学习记录 **/
#define StoryLearnRecord @"MyLearn"
/** 个人中心-新 **/
#define StoryCenter @"Center"
/** 登录页面-新  **/
#define StoryLoginNew @"LoginNew"



//每个主模块对应的位置小标--用于防止后期项目，几个主模块位置的改变，或者模块数量的改变-->二级三级页面进行过tabbarViewController的位置切换
/** 首页模块-我的课程-对应的位标  */
#define kTabBarIndexHome 0
/** 学习记录模块-对应的位标  */
#define kTabBarIndexTeam 1
/** 个人中心模块-对应的位标  */
#define kTabBarIndexUser 2


/**
 数据模型中，占位的字符串
 **/
#define kModelSpaceDot0 @"．"
#define kModelSpaceDot1 @"."
#define kModelSpaceFillSpace0 @"（{#answer}）"
#define kModelSpaceFillSpace1 @"{#answer}"
#define kModelSpaceFillSplit0 @"※"


// Apple iteuns 中该App对应的ID，用于更新跳转到APP Store
#define AppleAppID @"1477783915"



/** tabbar的4个itemAry  **/
#define kAryItems  ((TabBarViewController *)self.tabBarController).aryItems


/** 图片占位图 */
#define    kImagePlaceholder [UIImage imageNamed:@"Placeholder"]


/** 黑色 */
#define kColorBlack [UIColor blackColor]
/** 白色*/
#define kColorWhite [UIColor whiteColor]
/** 透明颜色 **/
#define kColorAlpha [[UIColor whiteColor] colorWithAlphaComponent:0]
/** 主题原色-用于一些配置 */
#define kColorTheme kHEXColor(@"#00539C")


/** 蓝色-主题导航条相关 */
#define kColorBlueNav  kHEXColor(@"#00539C")
/** 蓝色-答题卡 */
#define kColorBlueDot  kHEXColor(@"#387BEE")
/** 页面(space)背景颜色*/
#define kColorViewBg  kHEXColor(@"#F5F5F5")
/** 草绿色 */
#define kColorGreen  kHEXColor(@"#90DA8F")

/** 字体颜色-黑色-#4D4D4D*/
#define kColorFontBlack kHEXColor(@"#4D4D4D")
/** 字体颜色-灰色-深*/
#define kColorFontGrayLevel1  kHEXColor(@"#696969")
/** 字体颜色-灰色-中度*/
#define kColorFontGrayLevel2  kHEXColor(@"#747474")
/** 字体颜色-灰色-轻*/
#define kColorFontGrayLevel3  kHEXColor(@"#999999")
/** 字体颜色-蓝色*/
#define kColorFontBlue        kHEXColor(@"#639DDB")
/** 字体颜色-黄色*/
#define kColorFontOrange      kHEXColor(@"#FF8850")
/** 字体颜色-黄色*/
#define kColorFontYellow      kHEXColor(@"#F7AA20")
/** 字体颜色-红色  **/
#define kColorFontRed         kHEXColor(@"#CC3300")
/** 字体颜色-绿色  **/
#define kColorFontGreen       kHEXColor(@"#67AC35")
/** 字体背景颜色-红色  */
#define kColorFontBackRed     kHEXColor(@"#FD7169")

/** 答案-背景-红色*/
#define kColorAnswerBgRed           kHEXColor(@"#FFE2DB")
/** 答案-背景-浅绿色*/
#define kColorAnswerBgGreen         kHEXColor(@"#D6EBC2")
/** 答案-font-红色*/
#define kColorAnswerFontRed         kHEXColor(@"#CC3300")
/** 答案-font-绿色*/
#define kColorAnswerFontGreen       kHEXColor(@"#67AC35")
/** 答案-题号-绿色 **/
#define kColorAnswerNumGreen       kHEXColor(@"#83C76F")


/** 图片背景颜色  */
#define kColorImageBg kHEXColor(@"#E6E6E6")
/** 按钮失效颜色  */
#define kColorBtnInvalid  kHEXColor(@"#CACACA")


/** 标记字符串YES */
#define kUploadImageSignString @"YES"
/** 屏幕宽度与UI设计图比例Screen_Width/375.0  */
#define kScreenRatioWithUI Screen_Width/375.0




#pragma mark -------系统key值配合区域---------
//标记-首页是否是第一次加载数据
#define kIsFirstLoadKey @"kIsFirstLoadDataHomeViewControllerKey"


//本APP的url用于外部打开
#define URLSchemes  @"appEasyLianCard"

#endif /* ConfigManager_h */
