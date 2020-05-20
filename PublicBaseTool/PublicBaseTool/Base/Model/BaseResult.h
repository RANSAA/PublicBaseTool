//
//  BaseResult.h
//  Orchid
//
//  Created by Mac on 2019/1/11.
//  Copyright © 2019年 Mac. All rights reserved.
//

/**
 * 第一级响应结果result model， 用于配置一些通用的属性
 **/


@interface BaseResult : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy)   NSString  *msg;


/**
 检查响应结果code的值--防止请求异常时-出现数据接口错误的问题
 code:的值为200 时返回YES， 其它情况都返回NO
 PS:具体的code值由具体的项目解释
 */
+ (BOOL)checkResultModelWithJson:(id)json;

/** 显示返回200(正常数据)的提示信息 */
+ (void)showResultModelTipsWithJson:(id)json;



@end




/**
 * 用于数据模型直接解析部分的model
 **/
@interface BaseModel : NSObject

@end
