//
//  CoreDataManager.m
//  TKSDKXibView
//
//  Created by kimi on 2023/5/18.
//

#import "CoreDataManager.h"



@implementation CoreDataManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize concurrencyType = _concurrencyType;


//MARK： -
+ (instancetype)shared
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self.class alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    });
    return obj;
}


/**
 初始化
 concurrencyType: 创建类型，是在主线程还是私有线程创建。
 */
- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType
{
    if(self = [super init]){
        _concurrencyType = concurrencyType;
    }
    return self;
}



/** sqlite存储文件路径*/
- (NSURL *)fileCoreDataURL
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingString:@"/CoreDataTest_v1.0.0.db"];
    NSLog(@"Core Data DB path:%@",path);
    return  [NSURL fileURLWithPath:path];
}

//MARK: - Core Data Property
- (NSManagedObjectContext *)managedObjectContext
{
    if(_managedObjectContext){
        return _managedObjectContext;
    }
    //获取持久化存储协调器
    NSPersistentStoreCoordinator *storeCooedinator = self.persistentStoreCoordinator;
    if(storeCooedinator){
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:self.concurrencyType];
        //设置持久化存储协调器
        [_managedObjectContext setPersistentStoreCoordinator:storeCooedinator];
    }
    return _managedObjectContext;;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if(_persistentStoreCoordinator){
        return _persistentStoreCoordinator;;
    }
    //以持久化对象模型为基础，创建NSPersistentStoreCoordinator对象
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    //请求自动轻量级迁移
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@(YES),
                              NSInferMappingModelAutomaticallyOption:@(YES)
    };
    
    //设置持久化存储协调器底层采用SQLite存储机制，如果错误打印log
    NSError *err = nil;
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.fileCoreDataURL options:options error:&err]){
        NSLog(@"Core Data 设置持久化存储失败！ error：%@",err);
        assert(!err);
    }
    return _persistentStoreCoordinator;;
}


- (NSManagedObjectModel *)managedObjectModel{
    if(_managedObjectModel){
        return _managedObjectModel;
    }
    //获取实体模型文件对应的url，即.xcdatamodeld文件编译的momdw文件
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


/**
 功能:保存到数据库文件中
 PS:在applicationWillTerminate中也需要保存上下文，因为程序中断时如果不保存，那么可能会造成数据丢失问题。
 注意事项：
 1.NSManagedObject创建对象时就已经插入到了当前的上下文中，这是在context中都可以对当前对象进行操作；
 但是如果不执行save方法那么对应的操作是不会同步到磁盘上的数据库文件中，即数据不会保存到数据库文件中，但是它依然在内存中也可操作。
 2.context还有即可对应的方法:
    undo
    redo
    reset
    rollback
 示例：如果先创建了某个NSManagedObject对象，但是后续条件不满足，需要将当前NSManagedObject对象从上下文中删除时就可以执行reset或rollback方法。
 */
- (void)save
{
    if(_managedObjectContext){
        if(self.concurrencyType == NSMainQueueConcurrencyType){
            NSError *err = nil;
            if([_managedObjectContext hasChanges] && ![_managedObjectContext save:&err]){
                NSLog(@"Core Data 保存出现错误:%@",err);
                assert(!err);
            }
        }else{
            //并发执行
            [_managedObjectContext performBlock:^{
                NSError *err = nil;
                if([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&err]){
                    NSLog(@"Core Data 保存出现错误:%@",err);
                    assert(!err);
                }
            }];
        }
        
    }
}

- (void)undo
{
    if(_managedObjectContext){
        [_managedObjectContext undo];
    }
}

- (void)redo
{
    if(_managedObjectContext){
        [_managedObjectContext redo];
    }
}

- (void)reset
{
    if(_managedObjectContext){
        [_managedObjectContext reset];
    }
}

- (void)rollback
{
    if(_managedObjectContext){
        [_managedObjectContext rollback];
    }
}



//MARK: - 添加实体
/**
 添加实体
 1. 根据.xcdatamodeld文件中的实体名称创建对应的实体数据模型
 2. 为实体model设置属性
 3. 通过NSManagedObjectContext的save 方法保存到数据库中
 */
- (NSManagedObject *)createModelWithEntityName:(NSString *)entityName
{
    /**
     方式1：
        NSManagedObject *model = [[ NSManagedObject alloc] initWithEntity:entityName insertIntoManagedObjectContext:self.managedObjectContext];
     方式2：
        NSManagedObject *model = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
     */
    NSManagedObject *model = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
    return model;
}

/**
 根据class创建实体模型
 注意：cls必须是NSManagedObject或者其子类的class
 */
- (NSManagedObject *)createModelWithClass:(Class)cls
{
    /**
     示例:
        NSManagedObject *model = [[ NSManagedObject alloc] initWithContext:self.managedObjectContext];
     */
    id obj = [[cls alloc] initWithContext:self.managedObjectContext];
    return  obj;
}



//MARK: - 删除实体
/**
 删除实体
 1. 获取需要删除的实体
 2. Context调用deleteObject:删除方法
 3. Context调用save方法保存执行结果
 */
- (void)deleteModel:(NSManagedObject *)model
{
    [self.managedObjectContext deleteObject:model];
    [self save];
}

- (void)deleteModels:(NSArray<NSManagedObject *> *) models
{
    for (NSManagedObject *model in models) {
        [self deleteModel:model];
    }
}



//MARK: - 更新(修改)实体
/**
 1. 获取需要修改的实体
 2. Context调用save方法保存执行结果
 */
- (void)updateModel:(NSManagedObject *)model
{
    //修改实体属性
    //....
    
    [self save];
}



//MARK: - 查询实体
/**
 1. 创建NSFetchRequest对象
 2. 通过NSEntityDescription对象设置NSFetchRequest对象将要抓取的实体
 3. 如果需要筛选，可通过NSPredicate谓词设置筛选条件。如需要排序还需要为NSFetchRequest添加(多个)NSSortDesciptor对象
 4. Context调用executeFetchRequest:error:方法查询，并返回符合条件的实体NSArry集合。
 */


/**
 查询实体
 entityName:需要查询实体的名称
 predicate:条件筛选谓词
 sortDescriptors:排序
 */
- (nullable NSArray *)quaryWithEntityName:(NSString *)entityName predicate:(nullable NSPredicate *)predicate sortDescriptors:(nullable NSArray<NSSortDescriptor*> *) sort
{
    //创建抓取数据的请求对象
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //设置要抓取的那种类型的实体
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    //设置抓取实体
    [request setEntity:entity];
    
    
    //定义抓取条件(可选)，即谓词操作
    request.predicate = predicate;
    
    //排序
    request.sortDescriptors = sort;
    
    
    //执行抓取数据请求
    NSError *err = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&err];
    if(err){
        NSLog(@"Core Data 查询失败:%@",err);
    }
    return result;
}



//MARK: - 实体之间的关联属性 - 描述
/**
 Xcode操作:打开xcdatamodld文件 -> 选中Entity -> Relationships -> 添加属性 -> 设置与其他Entity实体属性关联 -> 选中Relationships的属性 -> 选中Xcode右侧的属性面板即可设置
 
 关联关系:
 To-One: 1-1
 To-Many:1-N
 关联实体的:Delete Rule
 No Action:该选项控制当主实体被删除时,关联的目标实体没有任何改变。
 Nullify:该选项控制当主实体被删除时，关联的目标实体的外键值被设为 null。
 Cascade:该选项控制当主实体被删除时,关联的目标实体也被级联删除。
 Deny：该选项控制当程序试图删除主实体时，如果关联的目标实体依然存在，程序删除失败——必须先删除关联的目标实体,然后才能删除主实体。
 
 */



@end
