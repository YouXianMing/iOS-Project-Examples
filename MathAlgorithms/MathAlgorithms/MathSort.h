//
//  MathSort.h
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLINE_METHOD.h"

@interface MathSort : NSObject

+ (NSMutableArray <NSNumber *> *)selectionSort:(NSMutableArray <NSNumber *> *)array;
+ (NSMutableArray <NSNumber *> *)bubbleSort:(NSMutableArray <NSNumber *> *)array;
+ (NSMutableArray <NSNumber *> *)insertionSort:(NSMutableArray <NSNumber *> *)array;
+ (NSMutableArray *)mergeSort:(NSMutableArray <NSNumber *> *)array;
+ (NSMutableArray <NSNumber *> *)quickSort:(NSMutableArray <NSNumber *> *)array;

@end
