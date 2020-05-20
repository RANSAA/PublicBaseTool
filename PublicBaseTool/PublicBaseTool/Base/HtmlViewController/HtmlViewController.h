//
//  HtmlViewController.h
//  CreaditCard
//
//  Created by Mac on 2018/1/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

/*! 网页视图控制器
 https://developer.mozilla.org/en-US/docs/Web/CSS/WebKit_Extensions
 **/
#import "BaseViewController.h"
#import "NSString+TKWeb.h"


@interface HtmlViewController : BaseViewController
/**是否显示导航条上右边的按钮*/
@property(nonatomic, assign) BOOL isShowNavRightItem;
/**是否直接返回到上一级页面-默认直接返回  */
@property(nonatomic, assign) BOOL isDirectBack;
/** 加载文件类型：0：HTML   1：PDF等文件  默认html类型 **/
@property(nonatomic, assign) NSInteger loadType;

#pragma mark 自定义请求
/**
 WK获取数据请求方式：
 POST   (默认)
 GET
 **/
@property(nonatomic, copy) NSString *HTTPMethod;
/**
 request header
 **/
@property(nonatomic, copy) NSDictionary *header;
/**
 附加的请求参数，位于Body中,POST
 **/
@property(nonatomic, copy) NSDictionary *par;
/**
 是否使用自定义的方式进行请求
 即使用：HTTPMethod ，header，par
 **/
@property(nonatomic, assign) BOOL isCustomRequest;




/** 实例方法-加载url*/
+ (instancetype)instanceWithTitle:(NSString *)title urlString:(NSString *)urlString;
/** 实例方法-加载HTML标签字符串 */
+ (instancetype)instanceWithTitle:(NSString *)title htmlString:(NSString *)htmlString baseURL:(NSString *)baseURL;


/**
 实例方法-加载pdf,word文档等，支持本地与远程路径
 title:标题
 readerURL:文档路径url，注意加载本地文件应该使用(file:///)前缀
 **/
+ (instancetype)instanceWithTitle:(NSString *)title readerURL:(NSString *)readerURL;




@end
