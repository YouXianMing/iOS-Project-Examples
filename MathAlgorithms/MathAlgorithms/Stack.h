//
//  Stack.h
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

/**
 获取顶部栈元素

 @return 顶部栈元素
 */
- (__kindof NSObject *)topElement;

/**
 出栈操作

 @return 出栈的对象
 */
- (__kindof NSObject *)pop;

/**
 入栈操作

 @param element 入栈的对象
 */
- (void)push:(__kindof NSObject *)element;

/**
 将栈清空
 */
- (void)empty;

/**
 栈大小

 @return 栈大小
 */
- (NSInteger)size;

#pragma mark - Constructor

+ (instancetype)stack;

@end
