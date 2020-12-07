//
//  Student.h
//  Review
//
//  Created by PC on 2020/9/2.
//  Copyright © 2020 PC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) void (^study)(void);
@end

NS_ASSUME_NONNULL_END
