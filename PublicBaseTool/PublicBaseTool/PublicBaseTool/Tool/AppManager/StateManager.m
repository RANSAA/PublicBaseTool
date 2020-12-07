//
//  StateManager.m
//  Evaluate
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "StateManager.h"

@implementation StateManager

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static StateManager *obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [StateManager new];
    });
    return obj;
}

@end
