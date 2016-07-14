//
//  JCReckonByTime.h
//  计时！
//
//  Created by ibokan on 15/7/30.
//  Copyright (c) 2015年 molin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCReckonByTime : NSObject

@property (nonatomic, strong) NSString *startTiem;//起点时间
@property (nonatomic, strong) NSString *endTiem; //结束时间
@property (nonatomic, strong) NSString *endHour; // 结束时间小时
@property (nonatomic, strong) NSString *endMinute; //结束时间分钟
@property (nonatomic, strong) NSString *endSecond; //结束时间秒
//获取单例对象
+ (JCReckonByTime *)getJCReckonByTime;
//开始计时
+ (NSString *)startReckonByTime;
- (NSString *)startReckonByTime;
//结束计时
+ (NSString *)endReckonByTime;
- (NSString *)endReckonByTime;
@end
