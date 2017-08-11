//
//  ViewController.m
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "ViewController.h"
#import "RegexManager.h"

#import "MathSort.h"

#import "PostfixExpression.h"
#import "Stack.h"
#import "Number.h"
#import "Mark.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 将字符串转换成Number与Mark并存储到数组中(存储的中序表达式)
    NSMutableArray *strings = [NSMutableArray array];
    [[@"4 * 3 + 5 / 2" matchStringsArrayWithRegexPattern:@"\\d+|[()+\\-*\\/]"] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        
        if ([self isPureInt:obj]) {
            
            Number *number = [Number numberWithString:obj];
            [strings addObject:number];
            
        } else {
            
            Mark *mark = [Mark markWithString:obj];
            [strings addObject:mark];
        }
    }];
    
    // 后序表达式
    PostfixExpression *postfixExpression = [PostfixExpression new];
    postfixExpression.originalDataArray  = strings;
    
    // 将中序表达式转换为后序表达式
    [postfixExpression startTransform];
    
    NSLog(@"%@", postfixExpression.calculate.number);
}

- (BOOL)isPureInt:(NSString *)string {
    
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

@end


