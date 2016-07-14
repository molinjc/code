//
//  JCReckonByTime.m
//  计时！
//
//  Created by ibokan on 15/7/30.
//  Copyright (c) 2015年 molin. All rights reserved.
//

#import "JCReckonByTime.h"
static JCReckonByTime *reckonByTime = nil; // 创建对象，为空
@implementation JCReckonByTime
/**
 *  创建对象
 *
 *  @return 对象
 */
+ (JCReckonByTime *)getJCReckonByTime{
    if (reckonByTime == nil) {
        reckonByTime = [JCReckonByTime new];
    }
    return reckonByTime;
}
/**
 *  开始计时（类方法)
 *
 *  @return 开始时间
 */
+ (NSString *)startReckonByTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    reckonByTime.startTiem = dateTime;
    return dateTime;
}
/**
 *  开始计时
 *
 *  @return 开始时间
 */
- (NSString *)startReckonByTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    self.startTiem = dateTime;
    return dateTime;
}
/**
 *  结束计时（类方法）
 *
 *  @return 结束时间
 */
+ (NSString *)endReckonByTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [formatter dateFromString:reckonByTime.startTiem];
    NSDate *data2 = [NSDate date];
    NSTimeInterval timeInterval = [data2 timeIntervalSinceDate:date1];
    int hour = (int) timeInterval/3600;
    int minute = (int)(timeInterval - hour*3600)/60;
    int second = timeInterval - hour*3600 - minute*60;
    reckonByTime.endTiem = [NSString stringWithFormat:@"%d时%d分%d秒", hour, minute,second];
    reckonByTime.endHour = [NSString stringWithFormat:@"%d",hour];
    reckonByTime.endMinute = [NSString stringWithFormat:@"%d",minute];
    reckonByTime.endMinute = [NSString stringWithFormat:@"%d",second];
    return reckonByTime.endTiem;
}
/**
 *  结束计时
 *
 *  @return 结束时间
 */
- (NSString *)endReckonByTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [formatter dateFromString:reckonByTime.startTiem];
    NSDate *data2 = [NSDate date];
    NSTimeInterval timeInterval = [data2 timeIntervalSinceDate:date1];
    int hour = (int) timeInterval/3600;
    int minute = (int)(timeInterval - hour*3600)/60;
    int second = timeInterval - hour*3600 - minute*60;
    self.endTiem = [NSString stringWithFormat:@"%d时%d分%d秒", hour, minute,second];
    self.endHour = [NSString stringWithFormat:@"%d",hour];
    self.endMinute = [NSString stringWithFormat:@"%d",minute];
    self.endMinute = [NSString stringWithFormat:@"%d",second];
    return self.endTiem;
}

@end
