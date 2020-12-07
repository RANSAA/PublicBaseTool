//MHYPerson.m 通过位运算实现三个属性的set、get方法
#import "MHYPerson.h"

// 掩码，一般用来按位与(&)运算的
//#define MHYTallMask 1
//#define MHYRichMask 2
//#define MHYHandsomeMask 4

//#define MHYTallMask 0b00000001
//#define MHYRichMask 0b00000010
//#define MHYHandsomeMask 0b00000100


#define MHYTallMask (1<<0)
#define MHYRichMask (1<<1)
#define MHYHandsomeMask (1<<2)
@interface MHYPerson()
{
    char _tallRichHansome;//定义一个char类型，Bool类型的值是0和1，只需一个二进制位就可以存储，char类型占1个字节，1个字节8位；（一个字节足以存储3个属性的值）
}
@end

@implementation MHYPerson{
    char tall : 1;
}


- (instancetype)init
{
    if (self = [super init]) {
        _tallRichHansome = 0b00000000;
    }
    return self;
}

- (void)setTall:(BOOL)tall
{

    if (tall) {
        _tallRichHansome |= MHYTallMask;
    } else {
        _tallRichHansome &= ~MHYTallMask;
    }
}

- (BOOL)isTall
{
    return !!(_tallRichHansome & MHYTallMask);
}

- (void)setRich:(BOOL)rich
{
    if (rich) {
        _tallRichHansome |= MHYRichMask;
    } else {
        _tallRichHansome &= ~MHYRichMask;
    }
}

- (BOOL)isRich
{
    return !!(_tallRichHansome & MHYRichMask);
}

- (void)setHandsome:(BOOL)handsome
{
    if (handsome) {
        _tallRichHansome |= MHYHandsomeMask;
    } else {
        _tallRichHansome &= ~MHYHandsomeMask;
    }
}

- (BOOL)isHandsome
{
    return !!(_tallRichHansome & MHYHandsomeMask);
}

 
@end
