//
//  UIButton+Swizzling.h
//  RunTimeDemo
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 Dingduola. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultInterval 0.5  //默认时间间隔

@interface UIButton (Swizzling)
@property (nonatomic, assign) NSTimeInterval timeInterval;
@end
