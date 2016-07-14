//
//  JCGetDate.m
//  JCTest
//
//  Created by molin on 16/3/4.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCGetDate.h"

@implementation JCGetDate

/**
 *  计算某年某月的总天数
 *
 *  @param date 时间
 *
 *  @return 某月的总天数
 */
+ (NSInteger)getNumberOfDaysInMonthWithDate:(NSDate *)date {
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法
    // 只要个时间给日历,就会帮你计算出来。这里的时间取当前的时间。
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit: NSMonthCalendarUnit
                                  forDate:date];
    return range.length;
}

/**
 *  获取某时间的具体信息，如年、月、日、周。。。
 *
 *  @param date 时间
 *
 *  @return JCDate 枚举
 */
+ (JCDate)getDateInfo:(NSDate *)date {
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    
    JCDate jcDate = {comps.year,comps.month,comps.day,comps.hour,comps.minute,comps.second,comps.weekday};
    return jcDate;
}

/**
 *  字符串转换成时间，字符串格式为yyyy-MM-dd HH:mm:ss
 *
 *  @param string 表示时间的字符串
 *
 *  @return 时间类
 */
+ (NSDate *)dateConvertWithString:(NSString *)string {
    NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [JCGetDate dateConvertWithString:string dateFormat:dateFormat];
}

/**
 *  字符串转换成时间，格式自定义
 *
 *  @param string     表示时间的字符串
 *  @param dateFormat 字符串所能转换成时间的格式
 *
 *  @return 时间类
 */
+ (NSDate *)dateConvertWithString:(NSString *)string dateFormat:(NSString *)dateFormat {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSDate * date = [formatter dateFromString:string];
    return date;
}

/**
 *  时间转换成字符串，格式为yyyy-MM-dd HH:mm:ss
 *
 *  @param date 时间
 *
 *  @return 字符串
 */
+ (NSString *)dateConvertWithDate:(NSDate *)date {
    NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [JCGetDate dateConvertWithDate:date dateFormat:dateFormat];
}

/**
 *  时间转换成字符串，格式自定义
 *
 *  @param date       时间类
 *  @param dateFormat 所要表达的时间格式
 *
 *  @return 字符串
 */
+ (NSString *)dateConvertWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString * dateString = [formatter stringFromDate:date];
    return dateString;
}

/**
 *  获取某年的某月里的所有天数的时间信息
 *
 *  @param date 时间
 *
 *  @return 数组
 */
+ (NSMutableArray *)getAllDaysWithCalender:(NSDate *)date {
    NSUInteger dayCount = [self getNumberOfDaysInMonthWithDate:date]; //一个月的总天数
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString * str = [formatter stringFromDate:date];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableArray * allDaysArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= dayCount; i++) {
        NSString * sr = [NSString stringWithFormat:@"%@-%ld",str,i];
        NSDate *suDate = [formatter dateFromString:sr];
        JCDate jcDate = [JCGetDate getDateInfo:suDate];
        NSValue *value = [NSValue value:&jcDate withObjCType:@encode(JCDate)];
        [allDaysArray addObject:value];
    }
   return allDaysArray;
}

/**
 *  获得某天的数据
 *
 *  获取指定的日期是星期几
 */
+ (NSInteger)getweekDayWithDate:(NSDate *)date {
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    
    // 1 是周日，2是周一 3.以此类推
    return comps.weekday;
    
}


@end
