//
//  INLINE_METHOD.h
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#ifndef INLINE_METHOD_h
#define INLINE_METHOD_h

#pragma mark - NS_INLINE method.

/**
 显示数组中的元素
 
 @param array 数组
 */
NS_INLINE void showArray(NSMutableArray <NSNumber *> *array) {
    
    NSMutableString *string = [NSMutableString string];
    
    [array enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [string appendFormat:@"%@, ", value];
    }];
    
    if (array.count) {
        
        [string deleteCharactersInRange:NSMakeRange(string.length - 2, 2)];
    }
    
    NSLog(@"%@", string);
}

/**
 获取随机数组
 
 @param count 个数
 @return 随机数组
 */
NS_INLINE NSMutableArray <NSNumber *> * randomsValues(NSInteger count) {
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        
        [array addObject:[NSNumber numberWithInteger:arc4random() % 500 + 10]];
    }
    
    return array;
}

#endif /* INLINE_METHOD_h */
