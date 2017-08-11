//
//  Stack.m
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "Stack.h"

@interface Stack ()

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation Stack

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.array = [NSMutableArray array];
    }
    
    return self;
}

- (__kindof NSObject *)topElement {
    
    return self.array.count ? self.array.firstObject : nil;
}

- (__kindof NSObject *)pop {

    NSObject *obj = nil;
    
    if (self.array.count) {
        
        obj = self.array.firstObject;
        [self.array removeObjectAtIndex:0];
    }
    
    return obj;
}

- (void)push:(NSObject *)element {
    
    [self.array insertObject:element atIndex:0];
}

- (void)empty {
    
    [self.array removeAllObjects];
}

- (NSInteger)size {
    
    return self.array.count;
}

#pragma mark - Constructor

+ (instancetype)stack {
    
    Stack *stack = [[[self class] alloc] init];
    return stack;
}

@end
