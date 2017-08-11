//
//  Number.h
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"

@interface Number : NSObject

@property (nonatomic, strong) NSString *number;

+ (instancetype)numberWithString:(NSString *)number;

+ (instancetype)numberA:(Number *)numberA numberB:(Number *)numberB mark:(Mark *)mark;

@end
