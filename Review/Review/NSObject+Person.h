//
//  NSObject+Person.h
//  Review
//
//  Created by PC on 2020/9/1.
//  Copyright © 2020 PC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Person)
//添加一个新属性
@property(nonatomic,copy)NSString *urlString;
- (void)clearAssociatedObjcet;
@end

NS_ASSUME_NONNULL_END
