//
//  JCGetDate.h
//  JCTest
//
//  Created by molin on 16/3/4.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {      //声明一个结构体类型JCDate
    NSInteger year;
    NSInteger month;
    NSInteger day;
    NSInteger hour;
    NSInteger minute;
    NSInteger second;
    NSInteger week;
}JCDate;

@interface JCGetDate : NSObject

/**
 *   获取该Date的天数
 */
+ (NSInteger)getNumberOfDaysInMonthWithDate:(NSDate *)date;

/**
 *   获取指定日期的年，月，日，星期，时,分,秒信息
 */
+ (JCDate)getDateInfo:(NSDate *)date;

/**
 *  string转换date
 *
 *  @param string yyyy-MM-dd HH:mm:ss格式的字符串
 *
 *  @return date
 */
+ (NSDate *)dateConvertWithString:(NSString *)string;

/**
 *  string转换date
 *
 *  @param string     时间字符串
 *  @param dateFormat 时间格式
 *
 *  @return date
 */
+ (NSDate *)dateConvertWithString:(NSString *)string dateFormat:(NSString *)dateFormat;

/**
 *  date转换string
 *
 *  @param date NSDate对象
 *
 *  @return yyyy-MM-dd HH:mm:ss格式的字符串
 */
+ (NSString *)dateConvertWithDate:(NSDate *)date;

/**
 *  date转换string
 *
 *  @param date       NSDate对象
 *  @param dateFormat 时间格式
 *
 *  @return yyyy-MM-dd HH:mm:ss格式的字符串
 */
+ (NSString *)dateConvertWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 *  获取某日期的当月的所有日期
 *
 *  @param date NSDate
 *
 *  @return 可变数组
 */
+ (NSMutableArray *)getAllDaysWithCalender:(NSDate *)date;

/**
 *  获得某天的数据
 *
 *  获取指定的日期是星期几
 */
+ (NSInteger)getweekDayWithDate:(NSDate *)date;

@end
