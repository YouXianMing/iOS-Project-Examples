//
//  PostfixExpression.m
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "PostfixExpression.h"
#import "Number.h"
#import "Mark.h"

@interface PostfixExpression ()

@property (nonatomic, strong) Stack          *markStack;
@property (nonatomic, strong) Stack          *calculateStack;
@property (nonatomic, strong) NSMutableArray *postfixExpression;

@end

@implementation PostfixExpression

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.markStack         = [Stack stack];
        self.calculateStack    = [Stack stack];
        self.postfixExpression = [NSMutableArray array];
    }
    
    return self;
}

- (void)startTransform {
    
    [self.postfixExpression removeAllObjects];
    
    NSMutableString *mutableString = [NSMutableString string];
    [self.originalDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
        if ([obj isKindOfClass:[Number class]]) {
            
            Number *number = obj;
            [self.postfixExpression addObject:number];
            
            [mutableString appendFormat:@"%@", number.number];
            
        } else {
            
            Mark *mark = obj;
            [self manageMark:mark];
            
            [mutableString appendFormat:@"%@", mark.mark];
        }
    }];
    
    while (self.markStack.topElement) {
        
        [self.postfixExpression addObject:self.markStack.pop];
    }
    
    NSLog(@"OriginalDataArray %@", mutableString);
    
    mutableString = [NSMutableString string];
    [self.postfixExpression enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[Number class]]) {
            
            Number *number = obj;
            [mutableString appendFormat:@"%@", number.number];
            
        } else {
            
            Mark *mark = obj;
            [mutableString appendFormat:@"%@", mark.mark];
        }
    }];
    
    NSLog(@"PostfixExpression %@", mutableString);
}

- (void)manageMark:(Mark *)mark {

    if /* 如果栈为空,则直接入栈 */ (self.markStack.size <= 0) {
        
        [self.markStack push:mark];
        
    } /* 如果栈不为空 */ else {
        
        if /* 如果符号为 '(' ,直接入栈 */ ([mark.mark isEqualToString:@"("]) {
            
            [self.markStack push:mark];
            
        } /* 如果符号为 ')', 弹栈, 直到栈顶为 '(' 停止弹栈,并将栈顶 '(' 删除  */ else if ([mark.mark isEqualToString:@")"]) {

            Mark *pop = self.markStack.pop;
            while ([pop.mark isEqualToString:@"("] == NO) {
                
                [self.postfixExpression addObject:pop];
                pop = self.markStack.pop;
            }
            
        } /* 如果符号为 '*' 或者 '/' */ else if (mark.priority == EMarkPriorityNormal) {
            
            Mark *top = self.markStack.topElement;
            if /* 栈顶元素优先级高 */ (top.priority == EMarkPriorityHigh) {
                
                [self.markStack push:mark];
                
            } /* 栈顶元素优先级中等 */ else if (top.priority == EMarkPriorityNormal) {
                
                [self.postfixExpression addObject:self.markStack.pop];
                [self.markStack push:mark];
                
            } /* 栈顶元素优先级低 */ else if (top.priority == EMarkPriorityLow) {
                
                [self.markStack push:mark];
            }
            
        } /* 如果符号为 '+' 或者 '-' */ else if (mark.priority == EMarkPriorityLow) {
            
            Mark *top = self.markStack.topElement;
            if /* 栈顶元素优先级高 */ (top.priority == EMarkPriorityHigh) {
                
                [self.markStack push:mark];
                
            } /* 栈顶元素优先级中等 */ else if (top.priority == EMarkPriorityNormal) {
                
                [self.postfixExpression addObject:self.markStack.pop];
                [self.markStack push:mark];
                
            } /* 栈顶元素优先级低 */ else if (top.priority == EMarkPriorityLow) {
                
                [self.postfixExpression addObject:self.markStack.pop];
                [self.markStack push:mark];
            }
        }
    }
}

- (Number *)calculate {
    
    while (self.postfixExpression.count) {
        
        id obj = self.postfixExpression.firstObject;
        [self.postfixExpression removeObjectAtIndex:0];
        
        if ([obj isKindOfClass:[Number class]]) {
            
            [self.calculateStack push:obj];
            
        } else if ([obj isKindOfClass:[Mark class]]) {
            
            Number *numberTop    = self.calculateStack.pop;
            Number *numbetSecond = self.calculateStack.pop;
            
            Number *calculate    = [Number numberA:numbetSecond numberB:numberTop mark:obj];
            [self.calculateStack push:calculate];
        }
    }
    
    return self.calculateStack.pop;
}

@end
