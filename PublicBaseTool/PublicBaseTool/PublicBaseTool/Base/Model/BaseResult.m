//
//  BaseResult.m
//  Orchid
//
//  Created by Mac on 2019/1/11.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BaseResult.h"

@implementation BaseResult

- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"msg" : @[@"msg",@"message"]};
}




//+ (BOOL)checkResultModelWithJson:(id)json
//{
//    BaseResult *checkModel = [BaseResult yy_modelWithJSON:json];
//    return [self checkResultCode:checkModel];
//}

/**
 检查响应结果code的值--防止请求异常时-出现数据接口错误的问题
 code:的值为200 时返回YES， 其它情况都返回NO
  PS:具体的code值由具体的项目解释
 */
//+ (BOOL)checkResultCode:(BaseResult *)checkModel
//{
//    if (checkModel) {
//        if (checkModel.code == ResultCodeStatusSuccess) {
//            return YES;
//        }else if (checkModel.code == ResultCodeStatusRelogin){//在其他设备上登录，重新登录
//            return NO;
//        }else if (checkModel.code == ResultCodeStatusTokenInvalid){//token失效，刷新token
//            return NO;
//        }else{
//            [TKMBProgressHUD showText:checkModel.msg];
//            return NO;
//        }
//    }else{
//        [TKMBProgressHUD showText:@"数据错误"];
//
//        return NO;
//    }
//}


///** 显示返回200(正常数据)的提示信息 */
//+ (void)showResultModelTipsWithJson:(id)json
//{
//    BaseResult *checkModel = [BaseResult yy_modelWithJSON:json];
//    if (checkModel.code == ResultCodeStatusSuccess) {
//        [TKMBProgressHUD showText:checkModel.msg];
//    }
//}


@end



@implementation BaseModel

- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }

@end




//YYModel解析实例方法
/**
 
 //属性重命名：
 + (NSDictionary *)modelCustomPropertyMapper {
     return @{@"name" : @"n",
             @"page" : @"p",
             @"desc" : @"ext.desc",
             @"bookID" : @[@"id",@"ID",@"book_id"]};
 }
 
 //属性为Array,其中嵌套其它数据模型时，需要实现的方法：
 // value should be Class or Class name.

 + (NSDictionary *)modelContainerPropertyGenericClass {
     return @{@"shadows" : [Shadow class],
             @"borders" : Border.class,
             @"attachments" : @"Attachment" };
 }
 
 //白名单-直接洗白名单中的属性
 + (NSArray *)modelPropertyBlacklist {
     return @[@"test1", @"test2"];
 }
 
 //黑名单-不解析黑名单中的属性
 + (NSArray *)modelPropertyWhitelist {
     return @[@"name"];
 }
 @
 
 
 //Coding/Copying/hash/equal/description 实现方法:
 - (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
 - (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
 - (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
 - (NSUInteger)hash { return [self yy_modelHash]; }
 - (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
 - (NSString *)description { return [self yy_modelDescription]; }
 
 **/
 
 
 
 
 
 
