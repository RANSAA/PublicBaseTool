#import "UIImage+Tools.h"
#import <objc/runtime.h>
/*
 typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy) {
     OBJC_ASSOCIATION_ASSIGN = 0,             //关联对象的属性是弱引用
     OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,   //关联对象的属性是强引用并且关联对象不使用原子性
     OBJC_ASSOCIATION_COPY_NONATOMIC = 3,     //关联对象的属性是copy并且关联对象不使用原子性
     OBJC_ASSOCIATION_RETAIN = 01401,         //关联对象的属性是copy并且关联对象使用原子性
     OBJC_ASSOCIATION_COPY = 01403            //关联对象的属性是copy并且关联对象使用原子性
 };
 */
@implementation UIImage (Tools)

- (void)setUrlString:(NSString *)urlString {
    objc_setAssociatedObject(self, @selector(urlString), urlString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)urlString {
    return objc_getAssociatedObject(self, @selector(urlString));
}
//添加一个自定义方法，用于清除所有关联属性
- (void)clearAssociatedObjcet{
    objc_removeAssociatedObjects(self);
}
@end
