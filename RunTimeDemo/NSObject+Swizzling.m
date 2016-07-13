//
//  NSObject+Swizzling.m
//  RunTimeDemo
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 Dingduola. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)
+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    //可能方法不在这个类中,可能在父类中,因此尝试添加方法实现
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    //尝试添加方法实现 成功
    if (didAddMethod) {
        
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
    } else {//尝试添加方法实现 失败,说明已经存在这个方法,则可以直接交换方法的实现
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
    }
    
    
}
@end
