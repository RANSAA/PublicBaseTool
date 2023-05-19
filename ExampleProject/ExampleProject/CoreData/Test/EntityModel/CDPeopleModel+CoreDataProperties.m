//
//  CDPeopleModel+CoreDataProperties.m
//  TKSDKXibView
//
//  Created by kimi on 2023/5/18.
//
//

#import "CDPeopleModel+CoreDataProperties.h"

@implementation CDPeopleModel (CoreDataProperties)

+ (NSFetchRequest<CDPeopleModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Entity_People"];
}

@dynamic age;
@dynamic name;
@dynamic sex;
@dynamic books;


- (NSString*)description
{
    return [NSString stringWithFormat:@"CDPeopleModel: name:%@  sex:%d  age:%d",self.name,self.sex,self.age];
}

@end
