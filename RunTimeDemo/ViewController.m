//
//  ViewController.m
//  RunTimeDemo
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 Dingduola. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+Swizzling.h"
#import "NSMutableDictionary+Swizzling.h"
#import "UIButton+Swizzling.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *string;
    
    [dic setObject:string forKey:@"44"];
    [dic setValue:string forKey:@"dsad"];
//    [dic removeObjectForKey:@"44"];
    NSLog(@"%@",dic);
    
    
    
    NSMutableArray *array = [@[@"value", @"value1"]     mutableCopy];
    [array lastObject];
    
    [array removeObject:@"value"];
    [array removeObject:nil];
    [array addObject:@"12"];
    [array addObject:nil];
    [array insertObject:nil atIndex:0];
    [array insertObject:@"sdf" atIndex:10];
    [array objectAtIndex:100];
    [array removeObjectAtIndex:10];
    
    NSMutableArray *anotherArray = [[NSMutableArray alloc] init];
    [anotherArray objectAtIndex:0];
    
    NSString *nilStr = nil;
    NSArray *array1 = @[@"ara", @"sdf", @"dsfdsf", nilStr];
    NSLog(@"array1.count = %lu", array1.count);
    
    // 测试数组中有数组
    NSArray *array2 = @[@[@"12323", @"nsdf", nilStr],     @[@"sdf", @"nilsdf", nilStr, @"sdhfodf"]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 70, 70);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    button.timeInterval = 3;
    [self.view addSubview:button];
    
}
- (void)click
{
    NSLog(@"click");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
