//
//  Mark.m
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "Mark.h"

@interface Mark ()

@property (nonatomic) EMarkPriority  priority;

@end

@implementation Mark

+ (instancetype)markWithString:(NSString *)string {
    
    Mark *mark = [[self class] new];
    mark.mark  = string;
    
    if ([string isEqualToString:@"+"] || [string isEqualToString:@"-"]) {
        
        mark.priority = EMarkPriorityLow;
        
    } else if ([string isEqualToString:@"*"] || [string isEqualToString:@"/"]) {
        
        mark.priority = EMarkPriorityNormal;
        
    } else if ([string isEqualToString:@"("] || [string isEqualToString:@")"]) {
        
        mark.priority = EMarkPriorityHigh;
        
    } else {
        
        mark.priority = EMarkPriorityUnknow;
    }
    
    return mark;
}

@end
