//
//  JCArraySequence.m
//  Array
//
//  Created by molin on 15/10/16.
//  Copyright © 2015年 molin. All rights reserved.
//

#import "JCArraySequence.h"

@implementation JCArraySequence

/**
 *  冒泡排序
 *  对数组中每个位置的数据，从后往前推，依次比较相邻的两个数，如果后面的数较小，则交换两者位置
 *  如果一次遍历没有发生任何数据交换，则排序直接完成
 *  @param array 数组
 */
+ (void)bubbleSort:(NSMutableArray *)list {
    if (list.count <= 1) {
        return;
    }
    int i, y;
    BOOL bFinish = YES; //是否发生数据交换
    for (i = 1; i<= [list count] && bFinish; i++) {
        bFinish = NO; //每次遍历时，重置标志
        //从最后一位开始，依次跟前一位相比，如果较小，则交换位置
        //当一次遍历没有任何数据交换时，则说明已经排序完成(bFinish=YES)，则不再进行循环
        for (y = (int)[list count]-1; y>=i; y--) {
            if ([[list objectAtIndex:y] intValue] < [[list objectAtIndex:y-1] intValue]) {
                //交换位置
                [list exchangeObjectAtIndex:y-1 withObjectAtIndex:y];
                bFinish = YES; //发生数据交换，则继续进行下一次遍历，直到未发生数据交换或者循环完成为止
            }
            
        }
    }
}

/**
 *  冒泡排序(降序)
 *
 *  @param list 待排序的数组
 */
+ (void)bubbleSortDesc:(NSMutableArray *)list {
    if (list.count <= 1) {
        return;
    }
    int i, y;
    BOOL bFinish = YES; //是否发生数据交换
    for (i = 1; i<= [list count] && bFinish; i++) {
        bFinish = NO; //每次遍历时，重置标志
        //从最后一位开始，依次跟前一位相比，如果较小，则交换位置
        //当一次遍历没有任何数据交换时，则说明已经排序完成(bFinish=YES)，则不再进行循环
        for (y = (int)[list count]-1; y>=i; y--) {
            if ([[list objectAtIndex:y] intValue] > [[list objectAtIndex:y-1] intValue]) {
                //交换位置
                [list exchangeObjectAtIndex:y-1 withObjectAtIndex:y];
                bFinish = YES; //发生数据交换，则继续进行下一次遍历，直到未发生数据交换或者循环完成为止
                
            }
            
        }
    }
}

/**
 *  快速排序
 *
 *  @param list array
 */
+ (void)quickSort:(NSMutableArray *)list {
    if (list.count <= 1) {
        return;
    }
    [self quickSort:list startIndex:0 endIndex:list.count-1];
}

/**
 *  快速排序
 *  任意选取一个数据（通常选用数组的第一个数）作为关键数据，然后将所有比它小的数都放到它前面，所有比它大的数都放到它后面
 *  再分别对两边的数据进行快速排序
 *  @param list  数组
 *  @param start 低位索引
 *  @param end   高位索引
 */
+ (void)quickSort:(NSMutableArray *)list startIndex:(NSInteger)start endIndex:(NSInteger)end{
    if (start >= end) { //低位大于高位，排序结束
        return;
    }
    NSInteger low = start;
    NSInteger high = end;
    NSInteger key = [[list objectAtIndex:start] integerValue]; //取第一个数作为关键数据
    while (low < high) {
        
        //从后往前推，直到找到第一个比关键数据小的值
        while ([[list objectAtIndex:high] integerValue] >= key && low < high) {
            high--;
        }
        //将这个值与关键数据对调（关键数据处于low位置），对调完关键数据处于high位置
        [list exchangeObjectAtIndex:low withObjectAtIndex:high];
        
        //从前往后推，直到找到第一个比关键数据大的值
        while ([[list objectAtIndex:low] integerValue] <= key && low < high) {
            low++;
        }
        //将这个值与关键数据（关键数据已经处于high位置）对调，对调完关键数据处于low位置
        [list exchangeObjectAtIndex:high withObjectAtIndex:low];
    }
    //对关键数据前面的数据进行快速排序
    [self quickSort:list startIndex:start endIndex:low-1];
    //对关键数据后面的数据进行快速排序
    [self quickSort:list startIndex:low+1 endIndex:end];
}

/**
 *  直接插入排序
 *  把待排序的纪录按其关键码值的大小逐个插入到一个已经排好序的有序序列中，直到所有的纪录插入完为止
 *
 *  @param list 待排序的数组
 */
+ (void)insertionSort:(NSMutableArray *)list {
    if (list.count <= 1) {
        return;
    }
    
    //从第1位开始，依次将数组分成2部分：前一部分可以视为已经排好序的，后一部分是未排序的
    //对后一部分的数据依次遍历，插入到前一部分中的合适位置
    for (int i=1; i<list.count; i++) {
        int j=i;
        //待排序的数（是未排序部分的第1个数，它的上一位数就是已经排序的部分的最后一位数）
        NSInteger temp = [[list objectAtIndex:i] integerValue];
        //从已排序部分的最后一位开始依次往前推，如果比待排序的数大，则将其位置往后移一位
        while (j>0 && [[list objectAtIndex:(j-1)]integerValue] > temp) {
            [list replaceObjectAtIndex:j withObject:[list objectAtIndex:(j-1)]];
            j--;
        }
        //循环结束后的j即为待排序的数需要插入的位置
        [list replaceObjectAtIndex:j withObject:@(temp)];
    }
}

/**
 *  二分排序（插入排序）
 *
 *  @param list 待排序的数组
 */
+ (void)binaryInsertionSort:(NSMutableArray *)list {
    if (list.count <= 1) {
        return;
    }
    //从第1位开始，依次将数组分成2部分：前一部分可以视为已经排好序的，后一部分是未排序的
    //对后一部分的数据依次遍历，插入到前一部分中的合适位置
    for (int i=1; i<list.count; i++) {
        int left = 0;
        int right = i-1;
        int middle;
        //待排序的数（是未排序部分的第1个数，它的上一位数就是已经排序的部分的最后一位数）
        NSInteger temp = [[list objectAtIndex:i] integerValue];
        
        while (left <= right) {
            //每次从已经排序的部分中取中间位置的数进行比较
            middle = (left+right)/2;
            //如果跟待排序数相等，则直接插入到此位置即可
            if ([[list objectAtIndex:middle]integerValue] == temp){
                left = middle;
                break;
            }
            //如果比待排序数大，则从中间位置左边范围内再次取中间数查找（下一循环）
            else if ([[list objectAtIndex:middle]integerValue] > temp) {
                right = middle-1;
            }
            //如果比待排序数小，则从中间位置右边范围再次取中间数查找（下一循环）
            else{
                left = middle+1;
            }
        }
        //循环结束，找到待插入位置left
        //依次将left右边（比left位置数据都大）的数据向右移动一位
        for (int j=i; j>left; j--) {
            [list replaceObjectAtIndex:j withObject:[list objectAtIndex:j-1]];
        }
        //在left位置插入待排序数
        [list replaceObjectAtIndex:left withObject:@(temp)];
    }
}

/**
 *  希尔排序（插入排序）
 *  先取一个正整数d1<n，把所有序号相隔d1的数组元素放一组，组内进行直接插入排序；然后取d2<d1，重复上述分组和排序操作；直至di=1， 即所有记录放进一个组中排序为止
 *
 *  @param list 待排序的数组
 */
+ (void)shellInsertionSort:(NSMutableArray *)list {
    if (list.count <= 1) {
        return;
    }
    NSInteger delt = list.count / 2; //增量：取数组长度一半，以后每次减半，直到增量为1
    NSInteger i;
    while (delt >= 1) {
        //对位置距离=增量的组分别进行直接插入排序
        for (i=delt; i<list.count; i++) {
            NSInteger k=i;
            //待排序的数
            NSInteger temp = [[list objectAtIndex:i] integerValue];
            //从已排序部分的最后一位开始依次往前推(间隔=增量)，如果比待排序的数大，则将其位置往后移“增量”位
            while (k>=delt && [[list objectAtIndex:k-delt]integerValue] > temp) {
                [list replaceObjectAtIndex:k withObject:[list objectAtIndex:k-delt]];
                k -= delt; //按增量递推
            }
            //循环结束后的j即为待排序的数需要插入的位置
            [list replaceObjectAtIndex:k withObject:@(temp)];
        }
        delt = delt/2; //增量：每次减半
    }
}

/**
 *  堆排序
 *  利用堆的特性（堆顶肯定是最大或者最小值），将堆顶数据与堆尾数据交换（相当于删除堆顶数据并保存到堆尾），再重新构造堆，直到堆中只剩下1个数据
 *
 *  @param list 待排序的数组
 */
+ (void)heapSort:(NSMutableArray *)list {
    if (list.count <= 1) {
        return;
    }
    NSInteger i;
    //初始化堆，取父节点和左右子节点中最大（或者最小）值作为堆顶
    //因为堆节点i的叶子节点是2*i+1，因此初始化是从length/2-1处开始整理堆即可
    for(i=list.count/2-1;i>=0;i--){
        [self heapAdjust:list withIndex:i andLength:list.count];
    }
    //    NSLog(@"构造堆:%@", [list componentsJoinedByString:@" "]);
    //整理完堆后，第0位数肯定是最大（或者最小）值，将它跟第n-1位交换，相当于从堆中删除第0位，再对剩下的数据重新整理堆
    //依次执行上述交换操作，直到只剩下1个数
    for(i=list.count-1;i>0;i--){
        [list exchangeObjectAtIndex:0 withObjectAtIndex:i];
        [self heapAdjust:list withIndex:0 andLength:i];
        //        NSLog(@"构造堆:%@", [list componentsJoinedByString:@" "]);
    }
}
/**
 *  构造堆（最大堆）
 *
 *
 *  @param list   待整理的数组
 *  @param index  待整理的位置
 *  @param length 待整理的数组的长度（这里因为待排序的数据和已排序的数据共用了一个数组）
 */
+ (void)heapAdjust:(NSMutableArray *)list withIndex:(NSInteger)index andLength:(NSInteger)length {
    //左子节点，右子节点为lchild+1
    NSInteger lchild = index*2+1;
    
    while (lchild < length) {
        //判断是否有右子节点，如果有则判断右子节点是否比左节点大，如果比左节点大则用右子节点于父节点进行比较
        if (lchild+1 < length && [[list objectAtIndex:lchild+1]integerValue] > [[list objectAtIndex:lchild] integerValue]) {
            lchild++; //++表示将左节点位置移到右节点位置,为的是下面跟父节点进行比较
        }
        //如果父节点比子节点小，则说明本身就是一个堆，无需再整理
        if ([[list objectAtIndex:lchild]integerValue] < [[list objectAtIndex:index]integerValue]) {
            break;
        }
        //交换父节点和子节点的值（将父节点下沉）
        [list exchangeObjectAtIndex:index withObjectAtIndex:lchild];
        //父节点位置下沉到子节点的位置，再继续整理下面的堆
        index = lchild;
        lchild = index*2+1;
    }
}

/**
 *  选择排序
 *  每一次从待排序的数据元素中选出最小（或最大）的一个元素，存放在序列的起始位置，直到全部待排序的数据元素排完
 *
 *  @param list 待排序的数组
 */
+ (void)selectSort:(NSMutableArray *)list { 
    if (list.count <= 1) {
        return;
    }
    NSInteger i,j;
    //从第0位开始排序，直到最后一位（最后一位无需再排序）
    for (i=0; i<list.count-1; i++) {
        j=i;//记录当前位置，作为对比的关键元素
        //依次遍历后面的元素
        for (NSInteger k=i+1; k<list.count; k++) {
            //如果元素比关键元素小，则将关键元素位置指向此位置，再继续遍历
            if ([[list objectAtIndex:k]integerValue] < [[list objectAtIndex:j]integerValue]) {
                j=k;
            }
        }
        //遍历结束后，得到最小元素位置j，如果不是初始位置，则交换2个位置的值
        if (i!=j) {
            [list exchangeObjectAtIndex:i withObjectAtIndex:j];
        }
    }
}

/**
 *  归并排序
 *  将数组分割成2部分，使左右2部分都有序，再合并成一个
 *  为了使左右2部分都有序，可通过递归的方式，再对其进行分割，直至分割后只剩1个元素，可以视其为已经有序的，再将左右2部分进行合并
 *  合并时，分别从2部分中取第0个数进行比较，将较小（或者较大）的数保存到临时数组里，再用下一个数和上次比较中较大者进行比较，直到某一边没有数据，再将另外一边中剩余的数复制到临时数组里
 *  最后生成的临时数组就是已经排好序的结果
 *
 *  @param list 待排序的数组
 */
+ (void)mergeSort:(NSMutableArray *)list {
    if (list.count <= 1) {
        return;
    }
    [self mergeSort:list startIndex:0 endIndex:list.count-1];
}
+ (void)mergeSort:(NSMutableArray *)list startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    
    if (startIndex < endIndex) {
        
        //取中间位置，将左右两边分别递归进行归并，直至左右两边只剩1个元素
        NSInteger middle = (startIndex + endIndex) / 2;
        [self mergeSort:list startIndex:startIndex endIndex:middle];
        [self mergeSort:list startIndex:middle+1 endIndex:endIndex];
        //对左右2边的数据进行合并
        NSInteger i=startIndex; //左边数据的起始位置
        NSInteger j= middle+1; //右边数据的起始位置
        NSMutableArray *temp = [NSMutableArray array]; //临时数组
        while (i<=middle && j <= endIndex) {
            //如果左边数据较小，则将其放到临时数组里，并将左边位置向后移一位
            if ([[list objectAtIndex:i]integerValue] < [[list objectAtIndex:j]integerValue]) {
                [temp addObject:[list objectAtIndex:i]];
                i++;
            }
            //否则将右边数据放到临时数组里，并将右边位置向后移一位
            else{
                [temp addObject:[list objectAtIndex:j]];
                j++;
            }
        }
        //如果左边还有数据，则将剩余的部分全都复制到临时数组里
        while (i<=middle) {
            [temp addObject:[list objectAtIndex:i]];
            i++;
        }
        //如果右边还有数据（左右两边只可能存在一边有剩余数据的情况），则将剩余的部分全都复制到临时数组里
        while (j<=endIndex) {
            [temp addObject:[list objectAtIndex:j]];
            j++;
        }
        //再将临时数组里的数据（已经排好序了）保存到原始数据中，以达到对原始数据的排序
        for (i=0; i<temp.count; i++) {
            //注意：需要从startIndex位置开始，因为这里是递归调用的
            [list replaceObjectAtIndex:startIndex withObject:[temp objectAtIndex:i]];
            startIndex++;
        }
    }
}

@end
