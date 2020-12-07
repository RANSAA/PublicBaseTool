//
//  ViewController.m
//  BaseTool
//
//  Created by PC on 2020/4/26.
//  Copyright © 2020 PC. All rights reserved.
//

#import "ViewController.h"
#import "JumpToAppStore.h"



@interface ViewController ()
@property(nonatomic, strong) JumpToAppStore *jump;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.jump = [JumpToAppStore new];
    [self.jump jumpWithPresentVC:self];
}


@end
