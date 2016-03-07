//
//  UIViewController+swizzling.m
//  method_Swizzling
//
//  Created by 张恒瑜 on 16/1/30.
//  Copyright © 2016年 张恒瑜. All rights reserved.
//

#import "UIViewController+swizzling.h"

@implementation UIViewController (swizzling)

+(void)load{
    [super load];
    
    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    
    Method toMethod = class_getInstanceMethod([self class], @selector(swizzlingViewDidLoad));
    
    if (!class_addMethod([self class], @selector(viewDidLoad), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {//为什么用的是toMethod的IMP而不是fromMethod的IMP？
        method_exchangeImplementations(fromMethod, toMethod);
    }
    
}


-(void)swizzlingViewDidLoad{
    NSLog(@"swizzlingViewDidLoad");
    [self swizzlingViewDidLoad];//在这里调用swizzlingViewDidLoad方法并不会引起循环引用，因为viewDidLoad和swizzlingViewDidLoad的IMP已经调换，这里调用swizzlingViewDidLoad其实实际上是指向viewDidLoad的。所以不会引起死循环。
}
@end
