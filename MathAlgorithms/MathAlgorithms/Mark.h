//
//  Mark.h
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    EMarkPriorityHigh = 1000, // 括号
    EMarkPriorityNormal,      // 乘法 + 除法
    EMarkPriorityLow,         // 加法 + 减法
    
    EMarkPriorityUnknow,
    
} EMarkPriority;

@interface Mark : NSObject

@property (nonatomic, strong)   NSString *mark;
@property (nonatomic, readonly) EMarkPriority  priority;

+ (instancetype)markWithString:(NSString *)string;

@end
