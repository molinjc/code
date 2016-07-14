/**
 *
 *   数组排序
 *
 */

#import <Foundation/Foundation.h>

@interface JCArraySequence : NSObject

/**
 *  冒泡排序
 */
+ (void)bubbleSort:(NSMutableArray *)list;

/**
 *  冒泡排序(降序)
 */
+ (void)bubbleSortDesc:(NSMutableArray *)list;

/**
 *  快速排序
 */
+ (void)quickSort:(NSMutableArray *)list;

/**
 *  直接插入排序
 */
+ (void)insertionSort:(NSMutableArray *)list;

/**
 *  二分排序（插入排序)
 */
+ (void)binaryInsertionSort:(NSMutableArray *)list;

/**
 *  希尔排序（插入排序)
 */
+ (void)shellInsertionSort:(NSMutableArray *)list;

/**
 *  堆排序
 */
+ (void)heapSort:(NSMutableArray *)list;

/**
 *  选择排序
 */
+ (void)selectSort:(NSMutableArray *)list;

/**
 *  归并排序
 */
+ (void)mergeSort:(NSMutableArray *)list;

@end
