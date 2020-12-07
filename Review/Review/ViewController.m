//
//  ViewController.m
//  复习
//
//  Created by PC on 2020/8/31.
//  Copyright © 2020 PC. All rights reserved.
//

#import "ViewController.h"
#import "AA.h"


@interface ViewController ()
@property(nonatomic, assign) NSInteger picNum;
@end

@implementation ViewController

- (void)viewDidLoad1 {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_async(dispatch_get_main_queue(), ^{
       NSLog(@"main 1");
    });

    NSLog(@"2");
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0);

//    dispatch_queue_t queue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_sync(queue, ^{
       NSLog(@"3");
    });

    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"main 4");
    });

    dispatch_async(queue, ^{
        NSLog(@"5");
    });

    NSLog(@"6");

    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0];

    NSLog(@"8");
    [self delayMethod1];

    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"main 9");
    });
}

- (void)delayMethod{
    NSLog(@"7");
}

- (void)delayMethod1{
    NSLog(@"10");

    NSOperation *q;
    NSOperationQueue *m;
}


/**
 * 使用 addOperation: 将操作加入到操作队列中
 */
- (void)addOperationToQueue {

    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.创建操作
    // 使用 NSInvocationOperation 创建操作1
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(delayMethod) object:nil];

    // 使用 NSInvocationOperation 创建操作2
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(delayMethod1) object:nil];

    // 使用 NSBlockOperation 创建操作3
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 3.使用 addOperation: 添加所有操作到队列中
    [queue addOperation:op1]; // [op1 start]
    [queue addOperation:op2]; // [op2 start]
    [queue addOperation:op3]; // [op3 start]
}

/**
 * 使用 addOperationWithBlock: 将操作加入到操作队列中
 */

- (void)addOperationWithBlockToQueue {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;

    // 2.使用 addOperationWithBlock: 添加操作到队列中
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
}


/**
 * 线程间通信
 */
- (void)communication {

    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];

    // 2.添加操作
    [queue addOperationWithBlock:^{
        // 异步进行耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }

        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 进行一些 UI 刷新等操作
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
            }
        }];
    }];


}

// 这两个方法名字是不一样的，虽然都是writeToFile开头
-(void) writeToFile:(NSString *)path {

}
-(void) writeToFile1:(NSObject *)path {

}


- (void)down
{
    NSString *url = @"https://upload.jianshu.io/users/upload_avatars/18569867/3b131785-ff53-455d-a095-b53bcbb3cd86.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp";

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{ /*加载图片1 */
        dispatch_group_enter(group);
        NSLog(@"加载图片1");
        [TKSDKAFNetworkTool DataGetWithUrl:url success:^(id  _Nullable data) {
            NSLog(@"down 1...");
            [self numberImageCount];
            dispatch_group_leave(group);
        } fail:^(NSError * _Nullable error) {
            NSLog(@"error");
            dispatch_group_leave(group);
        }];
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER); // 顺序执行与同步执行的不同点
    });
    dispatch_group_async(group, queue, ^{ /*加载图片2 */
        dispatch_group_enter(group);
        NSLog(@"加载图片2");
        [TKSDKAFNetworkTool DataGetWithUrl:url success:^(id  _Nullable data) {
            NSLog(@"down 2...");
            [self numberImageCount];
            dispatch_group_leave(group);
        } fail:^(NSError * _Nullable error) {
            NSLog(@"error");
            dispatch_group_leave(group);
        }];
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER); // 顺序执行与同步执行的不同点
    });
    dispatch_group_async(group, queue, ^{ /*加载图片3 */
        dispatch_group_enter(group);
        NSLog(@"加载图片3 ");
        [TKSDKAFNetworkTool DataGetWithUrl:url success:^(id  _Nullable data) {
            NSLog(@"down 3...");
            [self numberImageCount];
            dispatch_group_leave(group);
        } fail:^(NSError * _Nullable error) {
            NSLog(@"error");
            dispatch_group_leave(group);
        }];
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER); // 顺序执行与同步执行的不同点
    });
    dispatch_group_notify(group, queue, ^{
            // 合并图片
        NSLog(@"图片合并。。");
    });
    NSLog(@"ccc");
}


//线程串行，依次请求
- (void)downQueue
{
    NSString *url = @"https://upload.jianshu.io/users/upload_avatars/18569867/3b131785-ff53-455d-a095-b53bcbb3cd86.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp";
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i=1; i<4; i++) {
            dispatch_group_enter(group);
            [TKSDKAFNetworkTool DataGetWithUrl:url success:^(id  _Nullable data) {
                NSLog(@"down index:%ld",i);
                dispatch_group_leave(group);
            } fail:^(NSError * _Nullable error) {
                NSLog(@"error");
                dispatch_group_leave(group);
            }];
            dispatch_group_wait(group, DISPATCH_TIME_FOREVER); // 顺序执行与同步执行的不同点
        }
    });
}


- (void)numberImageCount
{
    @synchronized (self) {
        self.picNum++;
    }

    if (self.picNum == 3) {
        NSLog(@"图片下载完毕，开始合并！");
    }
}

- (void)main1
{
    char str[20] = {"12333df0g4"};
    int i,num[256]={0};
    for(i=0;i<strlen(str);i++){
        num[(int)str[i]]++;
        printf("i:%d  c:%d \n",i,(int)str[i]);
    }

    for(i=0;i<256;i++){
        if(num[i]!=0)
            printf("字符%c出现%d次\n",(char)i,num[i]);
        else{
//            printf("end\n");
//            break;;
        }
    }

    NSString *string = @"122fgf334分割成单个字符的数组分割成单个字符的数组";
    NSCountedSet *set =[[NSCountedSet alloc] init];
    [string enumerateSubstringsInRange:NSMakeRange(0, string.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [set addObject:substring];
    }];
    for (NSString *obj in set) {
        NSLog(@"无序  字符:%@ 出现了%ld次",obj,[set countForObject:obj]);
    }
    NSLog(@"\n\n");


    NSMutableArray *charAry = @[].mutableCopy;
    NSCountedSet   *countSet = [[NSCountedSet alloc] init];
    for (NSInteger i=0; i<string.length; i++) {
        NSString *c = [string substringWithRange:NSMakeRange(i, 1)];
        if (![countSet containsObject:c]) {
            [charAry addObject:c];
        }
        [countSet addObject:c];
    }

    for (NSString *obj in charAry) {
        NSLog(@"有序  字符:%@ 出现了%ld次",obj,[countSet countForObject:obj]);
    }
    NSInteger ic = +1111;

    NSString *ipStr = @"+922337203685477.5807100";
//    ipStr = @"+12g";
    NSLog(@"ipStr:%d",[AA deptNumInputShouldNumber:ipStr]);
    NSLog(@"ipVale:%ld , count:%ld",[ipStr integerValue],ipStr.length);

}


- (void)addShortAry
{
    NSMutableArray *A = [NSMutableArray arrayWithObjects:@4,@5,@8,@10,@15, nil];
    NSMutableArray *B = [NSMutableArray arrayWithObjects:@2,@5,@6,@7,@9,@11,@12,@13, nil];
    NSMutableArray *C = [NSMutableArray array];
    [C addObjectsFromArray:A];
    [C addObjectsFromArray:B];
    [C sortUsingSelector:@selector(compare:)];
    NSLog(@"C:%@",C);

    NSLog(@"main loop:%@",[NSRunLoop mainRunLoop]);

//    / 2. 开启一个新的RunLoop
//    [[NSRunLoop currentRunLoop] run];

    NSLog(@"run....");

//    NSLog(@"tast---%@", [NSThread currentThread]);
//    NSLog(@"loop:%@",[NSRunLoop currentRunLoop]);
    // 开启子线程，执行task方法
//        [NSThread detachNewThreadSelector:@selector(task) toTarget:self withObject:nil];

    NSLog(@"tast-0--%@", [NSThread currentThread]);
    [self performSelector:@selector(task)];

//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//    [self applicationDidBecomeActive];



}
- (void)task {

    /* 子线程和RunLoop
     1. 每一个子线程，都对应一个自己的RunLoop
     2. 主线程的RunLoop在程序运行的时候就已经创建了，而子线程的RunLoop则需要手动开启
     3. [NSRunLoop currentRunLoop]，此方法会开启一个新的RunLoop
     4. RunLoop需要执行run方法，来开启，但如果RunLoop中没有任何任务，就会关闭
     */

    // 1. 当前RunLoop
    NSLog(@"%p--%p", [NSRunLoop currentRunLoop], [NSRunLoop mainRunLoop]);


    // 2. 开启一个新的RunLoop
    [[NSRunLoop currentRunLoop] run];

    NSLog(@"tast-1--%@", [NSThread currentThread]);
}

- (void)timerAction{
 NSLog(@"tast-2--%@", [NSThread currentThread]);
}

- (void)applicationDidBecomeActive
{
    NSObject *testObject2 = [[NSObject alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    NSLog(@"Simulate busy");
    [self performSelector:@selector(simulateBusy) withObject:nil afterDelay:3];
}
// 模拟当前线程正好繁忙的情况
- (void)simulateBusy
{
    NSLog(@"start simulate busy!");
    NSUInteger caculateCount = 0x0FFFFFFF;
    CGFloat uselessValue = 0;
    for (NSUInteger i = 0; i < caculateCount; ++i)
    {
         uselessValue = i / 0.3333;
    }
    NSLog(@"finish simulate busy!");
 }

- (void)sessionUrl
{
    NSURLSession *session = [NSURLSession sharedSession];



}

- (void)gcdTimer
{
    __strong dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));

    // 2. 设置定时器
    /*
     dispatch_source_t source,  定时器的对象
     dispatch_time_t start,     定时器什么时候开始
     uint64_t interval,         定时器多长时间执行一次
     uint64_t leeway            精准度，0为绝对精准
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);

    // 3. 设置定时器的任务
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"---GCD---%@", [NSThread currentThread]);
    });

    // 4. 恢复定时器
    dispatch_resume(timer);
}

- (void)pp
{
    MHYPerson *person = [[MHYPerson alloc] init];
       person.tall = YES;
       person.rich = YES;
       person.handsome = YES;
       NSLog(@"tall:%d rich:%d hansome:%d", person.isTall, person.isRich, person.isHandsome);
}

- (void)imageTools
{
    NSObject *img = [[NSObject alloc] init];
    img.urlString = @"urlString set";
    NSLog(@"u:%@",img.urlString);
    NSLog(@"%s",__func__);
}

- (void)addVC
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        StudentViewController *vc = [[StudentViewController alloc] init];
        __weak typeof(vc) weakVC = vc;
        vc.backBlock = ^{
            NSLog(@"back... dealloc:%@",weakVC);
        };
        [self presentViewController:vc animated:YES completion:nil];

    });

}


/**
 获取CPU核心数
 */
- (NSInteger)TK_getCpuCores
{
    unsigned int ncpu;
    size_t len = sizeof(ncpu);
    sysctlbyname("hw.ncpu", &ncpu, &len, NULL, 0);
    printf("ncpu:%d",ncpu);
    return ncpu;;
}


- (void)addNibView
{
    NibView *vi = [NibView newXib];
    vi.frame = CGRectMake(40, 40, 200, 200);
    vi.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:vi];
}

- (void)addTestListVC
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TestListVC *vc = [[TestListVC alloc] initWithStyle:UITableViewStylePlain];
        [self presentViewController:vc animated:NO completion:nil];
    });
}


- (void)addTestGridVC
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TestGridVC *vc = [[TestGridVC alloc] init];
        [self presentViewController:vc animated:NO completion:nil];
    });
}

- (void)addImageToolVC
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ImageToolVC *vc = [[ImageToolVC alloc] init];
        [self presentViewController:vc animated:NO completion:nil];
    });
}


- (void)viewDidLoad {
[super viewDidLoad];
//    [self addOperationToQueue];
//    [self addOperationWithBlockToQueue];
//    [self down];
    [self downQueue];

//    [self main1];
//    [self addShortAry];


//    NSLog(@"start timer");
//     [TKTimerManager shared].timeTnterval = 1;
//     [[TKTimerManager shared] timerStart];
//    CFRunLoopRun();

//    [self gcdTimer];
//    [self pp];
//    [self imageTools];

//    [self addVC];

//    [self TK_getCpuCores];

//    [self addNibView];
//    [self addTestListVC];
//    [self addTestGridVC];
//    [self addImageToolVC];
}










@end
