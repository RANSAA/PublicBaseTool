//
//  ViewController+AlertTips.m
//  CC
//
//  Created by PC on 2020/12/20.
//  Copyright © 2020 PC. All rights reserved.
//

#import "ViewController+AlertTips.h"
#import <objc/runtime.h>

@implementation ViewController (AlertTips)

//添加一个自定义方法，用于清除所有关联属性
- (void)clearAssociatedObjcet{
    objc_removeAssociatedObjects(self);
}

- (UIButton *)btnAlert{
    UIButton *_btnAlert = objc_getAssociatedObject(self, @selector(btnAlert));
    if (!_btnAlert) {
        NSLog(@"新建btnAlert....");
        _btnAlert = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _btnAlert.backgroundColor = UIColor.grayColor;
        [_btnAlert setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_btnAlert setTitle:@"title" forState:UIControlStateNormal];
        [self.view addSubview:_btnAlert];
        [self setBtnAlert:_btnAlert];
    }
    return _btnAlert;
}

- (void)setBtnAlert:(UIButton *)btnAlert
{
    objc_setAssociatedObject(self, @selector(btnAlert), btnAlert, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
