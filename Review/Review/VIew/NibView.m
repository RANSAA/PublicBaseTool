//
//  NibView.m
//  Review
//
//  Created by PC on 2020/9/13.
//  Copyright © 2020 PC. All rights reserved.
//

#import "NibView.h"

@implementation NibView{

    UIView *_xibChildView;
    BOOL isSetupXibUI;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)tapBtnAction:(UIButton *)sender {
    NSLog(@"nibView TapButton....");
}

+ (instancetype)newXib
{

//    return [NibView new];

    return [[NibView alloc] init];
}



- (void)loadView1{
    if (!isSetupXibUI) {
        isSetupXibUI = YES;

        NSString *xibName = [NSString stringWithFormat:@"%@",self.class];
        UIView *subView = [[[NSBundle mainBundle]loadNibNamed:xibName owner:self options:nil] objectAtIndex:0];
        [self addSubview:subView];
        subView.frame = CGRectMake(0, 0, 200, 200);

    }

}

- (UIView *)vi_1
{
    NSString *xibName = [NSString stringWithFormat:@"%@",self.class];
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:xibName owner:self options:nil] objectAtIndex:0];
    return view;
}

- (UIView *)vi_2
{
    NSBundle *bundle =[NSBundle bundleWithPath: [[NSBundle bundleForClass:self.class] bundlePath]];
    NSString *xibName = [NSString stringWithFormat:@"%@",self.class];
    UINib *nib = [UINib nibWithNibName:xibName bundle:bundle];
    return [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
}

- (void)loadView{
    if (!isSetupXibUI) {
        @try {
            isSetupXibUI =YES;


//            NSBundle *bundle =[NSBundle bundleForClass:self.class];
//            NSLog(@"bundle:%@",bundle);

            UIView *view = [self vi_2];

               [self addSubview:view];
               view.translatesAutoresizingMaskIntoConstraints = NO;
               NSDictionary *dic = @{@"view":view};
               [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:dic]];
               [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:dic]];
               _xibChildView = view;


        } @catch (NSException *exception) {
            NSString *string = [NSString stringWithFormat:@"ERROR:XIB文件加载错误：请将xib文件的名字与类名保持一致：className:%@",self.class];
            NSLog(@"\nXib\n%@\nXib\n",string);
        } @finally {
        }
    }

}

- (instancetype)init
{
    if (self = [super init]) {
        [self loadView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    
    if (self = [super initWithCoder:coder]) {
//        NSLog(@"111");
        [self loadView];
    }
    return self;;


}




@end
