//
//  NSMutableDictionary+Swizzling.m
//  RunTimeDemo
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 Dingduola. All rights reserved.
//

#import "NSMutableDictionary+Swizzling.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

@implementation NSMutableDictionary (Swizzling)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

   [objc_getClass("__NSDictionaryM") swizzleSelector:@selector(setValue:forKey:) withSwizzledSelector:@selector(safeSetValue:forKey:)];
   [objc_getClass("__NSDictionaryM") swizzleSelector:@selector(setObject:forKey:) withSwizzledSelector:@selector(safeSetObject:forKey:)];
   [objc_getClass("__NSDictionaryM") swizzleSelector:@selector(removeObjectForKey:) withSwizzledSelector:@selector(safeRemoveObjectForKey:)];
        
    });
}
- (void)safeSetValue:(id)value forKey:(NSString *)key
{
    if (key == nil || value == nil || [key isEqual:[NSNull null]] || [value isEqual:[NSNull null]]) {
#if DEBUG
        NSLog(@"%s call -safeSetValue:forKey:, key或vale为nil或null", __FUNCTION__);
#endif
        return;
    }
    
    [self safeSetValue:value forKey:key];
}

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (aKey == nil || anObject == nil || [anObject isEqual:[NSNull null]]) {
#if DEBUG
        NSLog(@"%s call -safeSetObject:forKey:, key或vale为nil或null", __FUNCTION__);
#endif
        return;
    }
    
    [self safeSetObject:anObject forKey:aKey];
}

- (void)safeRemoveObjectForKey:(id)aKey
{
    if (aKey == nil || [aKey isEqual:[NSNull null]] ) {
#if DEBUG
        NSLog(@"%s call -safeRemoveObjectForKey:, aKey为nil或null", __FUNCTION__);
#endif
        return;
    }
    [self safeRemoveObjectForKey:aKey];
}


@end
