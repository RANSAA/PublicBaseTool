//
//  CoreDataService.h
//  TKSDKXibView
//
//  Created by kimi on 2023/5/19.
//

#import <Foundation/Foundation.h>
#import "CoreDataManager.h"

#import "CDBookModel+CoreDataProperties.h"
#import "CDPeopleModel+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

/**
 用于管理CoreData在项目中的实际操作。
 可以根据具体的项目情况管理项目的CoreData操作
 
 目前是一些示例，使用CoreDataManager单利完成，可根据具体项目修改。
 */
@interface CoreDataService : NSObject
//MARK: -
@property(nonatomic, strong, readonly) CoreDataManager *manager;



//MARK: - init
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)shared;
- (instancetype)initWithCoreDataManager:(CoreDataManager *)manager;

- (void)saveContext;



//MARK: - Test
- (CDPeopleModel *)testEntityModel;
- (void)testInsetModel;
/**
 测试创建CDPeopleModel并关联N个CDBookModel对象
 */
- (void)testAddPeopelAssociateBook;


//update
- (void)updateModel:(NSManagedObject*)model;
- (void)deleteModel:(NSManagedObject*)model;


- (NSArray *)testQuary;
- (NSArray *)testQuaryAll;

@end

NS_ASSUME_NONNULL_END
