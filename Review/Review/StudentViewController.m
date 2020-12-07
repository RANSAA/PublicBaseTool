//
//  StudentViewController.m
//  Review
//
//  Created by PC on 2020/9/2.
//  Copyright © 2020 PC. All rights reserved.
//

#import "StudentViewController.h"

#ifndef weakify
#define weakify(o) __typeof__(o) __weak o##__weak_ = o;
     #define strongify(o) __typeof__(o##__weak_) __strong o =    o##__weak_;
#endif

@interface StudentViewController ()
@property(nonatomic, strong) Student *student;
@property(nonatomic, strong) NSString *name;

@end

@implementation StudentViewController

- (void)dealloc
{
    NSLog(@"dealloc StudentViewController");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.grayColor;
    self.backBlock();

     Student *student = [[Student alloc]init];
     student.name = @"Hello World";
     self.student = student;

    self.name = @"Hello World";


//    weakify(student);
//    __weak typeof(student) weakStu = student;

     NSString *str = @"Hello World";

    NSInteger age;
    str=age?[NSString stringWithFormat:@"%ld",age]:@"";

    student.study = ^{

        /**
         * 三种写法是一样的效果，都是为了防止局部变量`student`在`viewDidLoad `之后销毁。如果不这样写的话，
         * 由于`student`局部变量被销毁，所以为nil，再走到`dispatch_after block`时候，由于weakStu是弱指针，
         * 所以不会强引用，最后打印为null，这不是我们想要的效果，`AFNetWorking`好多第三方库也是这么写的
         * 第1种写法
         * Student *strongStu = weakStu;
         * 第2种写法
         * __strong typeof(weakStu) strongStu = weakStu;
         * 第3种写法
         * typeof(student) strongStu = weakStu;
         */
        //随便取哪一种写法，这里取第一种写法
//         Student *strongStu = weakStu;
//        strongify(student);
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

//            NSLog(@"my name is = %@", student__weak_.name);
//        });

//        self.view.backgroundColor = UIColor.grayColor;
        NSLog(@"text:%@",str);
//        str = @"cc";
        NSLog(@"text:%@",str);

//        _name = @"cc";
    };
    str = @"name";
//    student.study();

//    student = nil;

    self.student.name = @"new1";
    [self.student addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [self.student addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.student.name = @"new";

        self.student = nil;
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.student removeObserver:self forKeyPath:@"name"];
        [self.student removeObserver:self forKeyPath:@"name"];
    });


}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"observeValueForKeyPath");
    NSLog(@"keyPath:%@",keyPath);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
