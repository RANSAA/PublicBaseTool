//
//  CDBookModel+CoreDataProperties.m
//  TKSDKXibView
//
//  Created by kimi on 2023/5/18.
//
//

#import "CDBookModel+CoreDataProperties.h"

@implementation CDBookModel (CoreDataProperties)

+ (NSFetchRequest<CDBookModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Entity_Book"];
}

@dynamic name;
@dynamic author;
@dynamic price;
@dynamic people;

@end
