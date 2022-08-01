//
//  UIControl+Factory.m
//  ExampleProject
//
//  Created by PC on 2022/7/31.
//

#import "UIControl+Factory.h"
#import <objc/runtime.h>

@implementation UIControl (Factory)

+ (void)load
{
    [self factorySwap];
}

+ (void)factorySwap
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = self.class;
        [TKMethodSwap swizzleMethod:cls originSel:@selector(sendAction:to:forEvent:) swizzSel:@selector(factory_sendAction:to:forEvent:)];
    });
}

- (void)factory_sendAction:(SEL)action to:(id)target forEvent:(UIEvent*)event
{
    if(self.ignoreEvent){
        NSLog(@"btnAction is intercepted");
        return;
    }
    if(self.acceptEventInterval>0){
        self.ignoreEvent=YES;
        [self performSelector:@selector(setIgnoreEventWithNo)  withObject:nil afterDelay:self.acceptEventInterval];
    }
    [self factory_sendAction:action to:target forEvent:event];
}

-(void)setIgnoreEventWithNo{
    self.ignoreEvent=NO;
}


#pragma mark - property
- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval
{
    objc_setAssociatedObject(self,@selector(acceptEventInterval), @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimeInterval)acceptEventInterval {
    return [objc_getAssociatedObject(self,@selector(acceptEventInterval)) doubleValue];
}

-(void)setIgnoreEvent:(BOOL)ignoreEvent{
    objc_setAssociatedObject(self,@selector(ignoreEvent), @(ignoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)ignoreEvent{
    return [objc_getAssociatedObject(self,@selector(ignoreEvent)) boolValue];
}





@end
