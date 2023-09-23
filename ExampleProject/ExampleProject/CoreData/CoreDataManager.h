//
//  CoreDataManager.h
//  TKSDKXibView
//
//  Created by kimi on 2023/5/18.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


//MARK: -  Core Data 数据操作管理
/**
 Core Data 数据操作管理
 
 
 多线程相关:
     简单来说，就是不同的线程使用不同的context进行操作，当一个线程的context发生变化后，利用notification来通知另一个线程Context，另一个线程调用mergeChangesFromContextDidSaveNotification来合并变化。
 参考：
     https://www.cnblogs.com/ederwin/articles/10800941.html
     https://blog.csdn.net/weixin_30315435/article/details/96575543
     https://blog.csdn.net/weixin_33704234/article/details/92078997
 
 
 版本迁移:
 1. 轻量级迁移：只是针对增加和改变实体、属性这样的一些简单操作。只需要简单设置options即可。
 2. 复杂级迁移：有更复杂的迁移需求，就需要Mapping Model 文件文件辅助
 注意:
    1. 版本迁移时都需要"Add Model Version"创建新的版本，新版本中的数据与之前的完全一样，然后再在新的版本中进行相关的操作。
    2. 将旧的NSManagedObject删除，然后在重新创建新的NSManagedObject模型
 参考:
     https://blog.csdn.net/zhaicaixiansheng/article/details/52121499
     https://blog.csdn.net/weixin_34168700/article/details/86021876
     http://www.manongjc.com/detail/51-xckrftyxsunsxkd.html
 
 */


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




NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject
//定义Core Data 的3个核心API的属性
//
//
//托管对象上下文:对实体执行增删改查等操作
@property(nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
//托管对象模型:负责管理整个应用的所有实体以及实体之间的关联关系
@property(nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
//持久化协调器：负责管理底层的存储文件
@property(nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//实体藐视：NSEntityDescription -> 该对象表示了某个实体的描述信息

//NSManagedObjectContext创建时使用的模式:主线程还是私有线程
@property(nonatomic, assign, readonly) NSManagedObjectContextConcurrencyType concurrencyType;



//MARK: -
/** 在主线程中创建 */
+ (instancetype)shared;
/**
 初始化
 concurrencyType: 创建类型，是在主线程还是私有线程创建。
 */
- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType;



//MARK: -
/** sqlite文件存储地址 */
- (NSURL *)fileCoreDataURL;


/**
 功能::保存到数据库文件中
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
- (void)save;

- (void)undo;
- (void)redo;
- (void)reset;
- (void)rollback;


/**
 添加实体
 1. 根据.xcdatamodeld文件中的实体名称创建对应的实体数据模型
 2. 为实体model设置属性
 3. 通过NSManagedObjectContext的save 方法保存到数据库中
 */
- (NSManagedObject *)createModelWithEntityName:(NSString *)entityName;
/**
 根据class创建实体模型
 注意：cls必须是NSManagedObject或者其子类的class
 */
- (NSManagedObject *)createModelWithClass:(Class)cls;

/**
 删除实体
 1. 获取需要删除的实体
 2. Context调用deleteObject:删除方法
 3. Context调用save方法保存执行结果
 */
- (void)deleteModel:(NSManagedObject *)model;
- (void)deleteModels:(NSArray<NSManagedObject *> *)models;



//MAKR: - 更新(修改)实体
/**
 1. 获取需要修改的实体
 2. Context调用save方法保存执行结果
 */
- (void)updateModel:(NSManagedObject *)model;


/**
 查询实体
 entityName:需要查询实体的名称
 predicate:条件筛选谓词
 sortDescriptors:排序
 */
- (nullable NSArray *)quaryWithEntityName:(NSString *)entityName predicate:(nullable NSPredicate *)predicate sortDescriptors:(nullable NSArray<NSSortDescriptor*> *) sort;






@end

NS_ASSUME_NONNULL_END
