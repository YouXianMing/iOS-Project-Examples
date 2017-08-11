//
//  MathSort.m
//  MathAlgorithms
//
//  Created by YouXianMing on 2017/8/11.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "MathSort.h"

@implementation MathSort

#pragma mark - 选择排序

+ (NSMutableArray <NSNumber *> *)selectionSort:(NSMutableArray <NSNumber *> *)array {
    
    /*
     简单选择排序的基本思想：第1趟，在待排序记录r[1]~r[n]中选出最小的记录，将它与r[1]交换；第2趟，在待排序记录r[2]~r[n]中选出最小的记录，
     将它与r[2]交换；以此类推，第i趟在待排序记录r[i]~r[n]中选出最小的记录，将它与r[i]交换，使有序序列不断增长直到全部排序完毕。
     */
    
    for (int outerIndex = 0; outerIndex < array.count; outerIndex++) {
        
        NSNumber *min   = array[outerIndex]; // 初始假设的最小值
        NSInteger index = outerIndex;        // 初始假设的最小值数组下标
        
        for (int innerIndex = outerIndex + 1; innerIndex < array.count; innerIndex++) {
            
            if (min.integerValue > array[innerIndex].integerValue) {
                
                min   = array[innerIndex]; // 更新最小值
                index = innerIndex;        // 更新最小值数组下标
            }
        }
        
        // 如果最小值下标与比较的不一致,则进行交换
        outerIndex != index ? [array exchangeObjectAtIndex:outerIndex withObjectAtIndex:index] : 0;
    }
    
    return array;
}

#pragma mark - 冒泡排序

+ (NSMutableArray <NSNumber *> *)bubbleSort:(NSMutableArray <NSNumber *> *)array {
    
    /*
     冒泡排序算法的运作如下：（从后往前）
     1. 比较相邻的元素。如果第一个比第二个大，就交换他们两个。
     2. 对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数。
     3. 针对所有的元素重复以上的步骤，除了最后一个。
     4. 持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
     */
    
    for (int outerIndex = 0; outerIndex < array.count; outerIndex++) {
        
        for (int innerIndex = outerIndex + 1; innerIndex < array.count; innerIndex++) {
            
            if (array[outerIndex].integerValue > array[innerIndex].integerValue) {
                
                [array exchangeObjectAtIndex:outerIndex withObjectAtIndex:innerIndex];
            }
        }
    }
    
    return array;
}

#pragma mark - 插入排序

+ (NSMutableArray <NSNumber *> *)insertionSort:(NSMutableArray <NSNumber *> *)array {
    
    /*
     插入排序法 所谓插入排序法乃是将一个数目插入该占据的位置。
     
     假设我们输入的是 “5，1，4，2，3” 我们从第二个数字开始，这个数字是1，我们的任务只要看看1有没有正确的位置，我们的做法是和这个数字左边的数字来比，
     因此我们比较1和5，1比5小，所以我们就交换1和5，原来的排列就变成了“1，5，4，2，3 ”
     
     接下来，我们看第3个数字有没有在正确的位置。这个数字是4，它的左边数字是5，4比5小，所以我们将4和5交换，排列变成了 “1，4，5，2，3 "我们必须继续
     看4有没有在正确的位置，4的左边是1，1比4小，4就维持不动了。
     
     再来看第四个数字，这个数字是2，我们将2和它左边的数字相比，都比2大，所以就将2一路往左移动，一直移到2的左边是1，这时候排序变成了 “1，2，4，5，3 ”
     最后，我们检查第五个数字，这个数字是3，3必须往左移，一直移到3的左边是2为止，所以我们的排列就变成了 “1，2，3，4，5 ”排序因此完成了。
     
     所谓插入排序法，就是检查第i个数字，如果在它的左边的数字比它大，进行交换，这个动作一直继续下去，直到这个数字的左边数字比它还要小，就可以停止了。插
     入排序法主要的回圈有两个变数：i和j，每一次执行这个回圈，就会将第i个数字放到左边恰当的位置去。
     */
    
    for (int index = 1; index < array.count; index++) {
        
        int point = index;
        while ((point >= 1) && (array[point - 1].integerValue > array[point].integerValue)) {
            
            [array exchangeObjectAtIndex:point - 1 withObjectAtIndex:point];
            point -= 1;
        }
    }
    
    return array;
}

#pragma mark - 归并排序

+ (NSMutableArray *)mergeSort:(NSMutableArray <NSNumber *> *)array {
    
    [self sort:array leftIndex:0 rightIndex:array.count - 1 tmpArray:[NSMutableArray arrayWithCapacity:array.count - 1]];
    return array;
}

+ (void)sort:(NSMutableArray <NSNumber *> *)array leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex tmpArray:(NSMutableArray <NSNumber *> *)tmpArray {
    
    /*
     归并排序（MERGE-SORT）是建立在归并操作上的一种有效的排序算法,该算法是采用分治法（Divide and Conquer）的一个非常典型的应用。将已有序的子序列合并，
     得到完全有序的序列；即先使每个子序列有序，再使子序列段间有序。若将两个有序表合并成一个有序表，称为二路归并。
     归并过程为：比较a[i]和b[j]的大小，若a[i]≤b[j]，则将第一个有序表中的元素a[i]复制到r[k]中，并令i和k分别加上1；否则将第二个有序表中的元素b[j]复制到
     r[k]中，并令j和k分别加上1，如此循环下去，直到其中一个有序表取完，然后再将另一个有序表中剩余的元素复制到r中从下标k到下标t的单元。归并排序的算法我们通常
     用递归实现，先把待排序区间[s,t]以中点二分，接着把左边子区间排序，再把右边子区间排序，最后把左区间和右区间用一次归并操作合并成有序的区间[s,t]。
     */
    
    if (leftIndex < rightIndex) {
        
        NSInteger midIndex = (leftIndex + rightIndex) / 2;
        
        NSLog(@"-- left:%ld right:%ld mid:%ld", leftIndex, rightIndex, midIndex);
        [self sort:array leftIndex:leftIndex rightIndex:midIndex tmpArray:tmpArray];
        
        NSLog(@"++ left:%ld right:%ld mid:%ld", leftIndex, rightIndex, midIndex);
        [self sort:array leftIndex:midIndex + 1 rightIndex:rightIndex tmpArray:tmpArray];
        
        NSLog(@"===> left:%ld right:%ld mid:%ld", leftIndex, rightIndex, midIndex);
        [self merge:array leftIndex:leftIndex midIndex:midIndex rightIndex:rightIndex tmpArray:tmpArray];
    }
}

+ (void)merge:(NSMutableArray <NSNumber *> *)array
    leftIndex:(NSInteger)leftIndex midIndex:(NSInteger)midIndex rightIndex:(NSInteger)rightIndex
     tmpArray:(NSMutableArray <NSNumber *> *)tmpArray {
    
    // 清空数组(非必须,便于调试观察)
    [tmpArray removeAllObjects];
    
    NSLog(@"-----------------------");
    showArray(array);
    
    // 左边数组与右边数组最多只相差一个元素
    NSInteger i = leftIndex;    // 左边'数组'下标
    NSInteger j = midIndex + 1; // 右边'数组'下标
    NSInteger t = 0;            // 临时数组的下标,用来存储比较后的结果
    
    // 左边数组与右边数组数据的挨个比较,并将比较后的数据存储在临时数组里面
    while (i <= midIndex && j <= rightIndex) {
        
        if (array[i].integerValue <= array[j].integerValue) {
            
            tmpArray[t++] = array[i++];
            
        } else {
            
            tmpArray[t++] = array[j++];
        }
    }
    
    while (i <= midIndex) {
        
        tmpArray[t++] = array[i++];
    }
    
    while (j <= rightIndex) {
        
        tmpArray[t++] = array[j++];
    }
    
    // 将临时数组中的数据覆盖到原始数组中指定的比较区域
    t = 0;
    while (leftIndex <= rightIndex) {
        
        array[leftIndex++] = tmpArray[t++];
    }
    
    showArray(array);
    showArray(tmpArray);
    NSLog(@"-----------------------");
    NSLog(@" ");
}

#pragma mark - 快速排序

+ (NSMutableArray <NSNumber *> *)quickSort:(NSMutableArray <NSNumber *> *)array {
    
    [self quickSort:array leftIndex:0 rightIndex:array.count - 1];
    return array;
}

+ (void)quickSort:(NSMutableArray <NSNumber *> *)array leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex {
    
    if (leftIndex >= rightIndex) {
        
        return;
    }
    
    NSInteger partition = [self partition:array leftIndex:leftIndex rightIndex:rightIndex];
    [self quickSort:array leftIndex:leftIndex rightIndex:partition - 1];
    [self quickSort:array leftIndex:partition + 1 rightIndex:rightIndex];
}

+ (NSInteger)partition:(NSMutableArray <NSNumber *> *)array leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex {
    
    NSInteger anchorPoint = leftIndex; // 基准点
    NSInteger partition   = leftIndex; // 分割点
    
    for (NSInteger move = leftIndex + 1; move <= rightIndex; move++) {
        
        if (array[move].integerValue < array[anchorPoint].integerValue) {
            
            partition += 1;
            partition != move ? [array exchangeObjectAtIndex:partition withObjectAtIndex:move] : 0;
        }
    }
    
    partition != anchorPoint ? [array exchangeObjectAtIndex:partition withObjectAtIndex:anchorPoint] : 0;
    return partition;
}

@end
