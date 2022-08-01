//
//  ClassTypeModel.h
//  ExampleProject
//
//  Created by PC on 2022/7/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassTypeModel : NSObject
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *cls;

+ (instancetype)initWithName:(NSString *)name cls:(NSString *)cls;
@end

NS_ASSUME_NONNULL_END
