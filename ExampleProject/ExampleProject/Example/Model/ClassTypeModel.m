//
//  ClassTypeModel.m
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import "ClassTypeModel.h"

@implementation ClassTypeModel


+ (instancetype)initWithName:(NSString *)name cls:(NSString *)cls
{
    ClassTypeModel *obj = [[self.class alloc] init];
    obj.name = name;
    obj.cls = cls;
    return obj;
}
@end
