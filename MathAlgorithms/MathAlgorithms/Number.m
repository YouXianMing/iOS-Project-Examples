//
//  Number.m
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "Number.h"
#import <UIKit/UIKit.h>

@implementation Number

+ (instancetype)numberWithString:(NSString *)number {
    
    Number *value = [[self class] new];
    value.number  = number;
    
    return value;
}

+ (instancetype)numberA:(Number *)numberA numberB:(Number *)numberB mark:(Mark *)mark {

    CGFloat valueA = numberA.number.floatValue;
    CGFloat valueB = numberB.number.floatValue;
    
    CGFloat retValue = 0;
    
    if ([mark.mark isEqualToString:@"+"]) {
        
        retValue = valueA + valueB;
        
    } else if ([mark.mark isEqualToString:@"-"]) {
        
        retValue = valueA - valueB;
        
    } else if ([mark.mark isEqualToString:@"*"]) {
        
        retValue = valueA * valueB;
        
    } else if ([mark.mark isEqualToString:@"/"]) {
        
        retValue = valueA / valueB;
    }
    
    Number *value = [[self class] new];
    value.number  = [NSString stringWithFormat:@"%f", retValue];
    
    return value;
}

@end
