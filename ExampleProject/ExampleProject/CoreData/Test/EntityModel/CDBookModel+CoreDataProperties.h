//
//  CDBookModel+CoreDataProperties.h
//  TKSDKXibView
//
//  Created by kimi on 2023/5/18.
//
//

#import "CDBookModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CDBookModel (CoreDataProperties)

+ (NSFetchRequest<CDBookModel *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *author;
@property (nonatomic) float price;
@property (nullable, nonatomic, retain) CDPeopleModel *people;

@end

NS_ASSUME_NONNULL_END
