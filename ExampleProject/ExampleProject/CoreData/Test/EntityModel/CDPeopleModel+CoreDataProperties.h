//
//  CDPeopleModel+CoreDataProperties.h
//  TKSDKXibView
//
//  Created by kimi on 2023/5/18.
//
//

#import "CDPeopleModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CDPeopleModel (CoreDataProperties)

+ (NSFetchRequest<CDPeopleModel *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nonatomic) int32_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t sex;
@property (nullable, nonatomic, retain) NSSet<CDBookModel *> *books;

@end

@interface CDPeopleModel (CoreDataGeneratedAccessors)

- (void)addBooksObject:(CDBookModel *)value;
- (void)removeBooksObject:(CDBookModel *)value;
- (void)addBooks:(NSSet<CDBookModel *> *)values;
- (void)removeBooks:(NSSet<CDBookModel *> *)values;

@end

NS_ASSUME_NONNULL_END
