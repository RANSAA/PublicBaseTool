//
//  CoreDataService.m
//  TKSDKXibView
//
//  Created by kimi on 2023/5/19.
//

#import "CoreDataService.h"

@interface CoreDataService ()

@end

@implementation CoreDataService
@synthesize manager = _manager;

//MARK: - init

+ (instancetype)shared
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CoreDataManager *manager = CoreDataManager.shared;
        obj = [[self.class alloc] initWithCoreDataManager:manager];
    });
    return  obj;
}

- (instancetype)initWithCoreDataManager:(CoreDataManager *)manager
{
    if(self = [super init]){
        _manager = manager;
    }
    return self;;
}

- (void)saveContext
{
    [_manager saveContext];
}




//MARK: - Test

- (CDPeopleModel *)testEntityModel
{
    //根据实体名创建model
    CDPeopleModel *model = (CDPeopleModel *)[self.manager createModelWithEntityName:@"Entity_People"];
    
//    CDPeopleModel *model = (CDPeopleModel *)[self createModelWithClass:CDPeopleModel.class];
    
    //为具体实体设置属性
    model.name = @"张三";
    model.sex = 1;
    model.age = 25;
    
    return model;
}


- (void)testInsetModel
{
    CDPeopleModel *model = [[ CDPeopleModel alloc] initWithContext:self.manager.managedObjectContext];
    
    model.name = [NSString stringWithFormat:@"Name-%d",arc4random()%2550];
    model.sex = arc4random()%3;
    model.age = 25;
    

    [self.manager saveContext];
}


/**
 测试创建CDPeopleModel并关联N个CDBookModel对象
 */
- (void)testAddPeopelAssociateBook
{
    CDPeopleModel *model = [[ CDPeopleModel alloc] initWithContext:self.manager.managedObjectContext];
    model.name = [NSString stringWithFormat:@"Name-Book-%d",arc4random()%2550];
    model.sex = arc4random()%3;
    model.age = 25;
    
    
    CDBookModel *book1 = [[ CDBookModel alloc] initWithContext:self.manager.managedObjectContext];
    book1.name = @"iOS";
    
    CDBookModel *book2 = [[ CDBookModel alloc] initWithContext:self.manager.managedObjectContext];
    book2.name = @"Android";
    
    
    
//    book1.people = model;
//    book2.people = model;

    [model addBooksObject:book1];
    [model addBooksObject:book2];

    
    [self.manager saveContext];
}




- (void)updateModel:(NSManagedObject*)model
{
    [self.manager updateModel:model];
}

- (void)deleteModel:(NSManagedObject*)model
{
    [self.manager deleteModel:model];
}









- (NSArray *)testQuary
{
    NSPredicate *predicate = nil;
    //predicate为nil时，查询结果为实体中的所有对象
    //predicate不为空时，查询结果为predicate筛选的。
    //查询条件是:sex的值等于2的对象，Tip:通过xcdatamodld文件的Fetch Requests中有一定的谓词条件选项。
    predicate = [NSPredicate predicateWithFormat:@"sex == 2 "];
    
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    NSArray *arry = [self.manager quaryWithEntityName:@"Entity_People" predicate:predicate sortDescriptors:@[sort1]];
    NSLog(@"Core Data Quary Test:%@",arry);
    return arry;
}

- (NSArray *)testQuaryAll
{
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *arry = [self.manager quaryWithEntityName:@"Entity_People" predicate:nil sortDescriptors:@[sort1]];
    NSLog(@"Core Data Quary Test:%@",arry);
    return  arry;
}



@end
