//
//  PostfixExpression.h
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Number.h"

@interface PostfixExpression : NSObject

@property (nonatomic, strong) NSMutableArray *originalDataArray;

/**
 符号栈(只存储运算符的栈)
 */
@property (nonatomic, strong, readonly) Stack *markStack;

/**
 将中序表达式转换为后序表达式
 */
- (void)startTransform;

/**
 后序表达式
 */
@property (nonatomic, strong, readonly) NSMutableArray *postfixExpression;

/**
 计算栈(存储数值,遇到符号后,将栈中两个元素弹出并计算)
 */
@property (nonatomic, strong, readonly) Stack *calculateStack;

/**
 计算后续表达式

 @return 计算后的结果
 */
- (Number *)calculate;

@end
