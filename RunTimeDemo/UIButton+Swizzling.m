//
//  UIButton+Swizzling.m
//  RunTimeDemo
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 Dingduola. All rights reserved.
//

#import "UIButton+Swizzling.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

@interface UIButton()
/**bool 类型 YES 不允许点击   NO 允许点击   设置是否执行点UI方法*/
@property (nonatomic, assign) BOOL isIgnoreEvent;
@end
@implementation UIButton (Swizzling)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [objc_getClass("UIButton") swizzleSelector:@selector(sendAction:to:forEvent:) withSwizzledSelector:@selector(customSendAction:to:forEvent:)];
        
    });
}

- (void)customSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{

    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        
        self.timeInterval =self.timeInterval ==0 ?defaultInterval:self.timeInterval;
        if (self.isIgnoreEvent){
            return;
        }else if (self.timeInterval > 0){
            [self performSelector:@selector(resetState) withObject:nil afterDelay:self.timeInterval];
        }
    }
    //此处 methodA和methodB方法IMP互换了，实际上执行 sendAction；所以不会死循环
    self.isIgnoreEvent = YES;
    [self customSendAction:action to:target forEvent:event];
}

- (NSTimeInterval)timeInterval
{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
//runtime 动态绑定 属性
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    // 注意BOOL类型 需要用OBJC_ASSOCIATION_RETAIN_NONATOMIC 不要用错，否则set方法会赋值出错
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent{
    //_cmd == @select(isIgnore); 和set方法里一致
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)resetState{
    [self setIsIgnoreEvent:NO];
}
@end
