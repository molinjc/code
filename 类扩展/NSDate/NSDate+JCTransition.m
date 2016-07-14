//
//  NSDate+JCTransition.m
//  SHBracelet_iOS
//
//  Created by molin on 16/5/3.
//  Copyright © 2016年 ChenShuaiPeng. All rights reserved.
//

#import "NSDate+JCTransition.h"

@implementation NSDate (JCTransition)

@dynamic stringDate;
@dynamic stringDateWithFormat;

+ (NSDate *)dateWithString:(NSString *)stringDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    // 时间格式，hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 将字符串按formatter转成nsdate
    NSDate *date = [formatter dateFromString:stringDate];
    return date;
}

+ (NSDate *)dateWithString:(NSString *)stringDate format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    // 时间格式，hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:format];
    
    // 将字符串按formatter转成nsdate
    NSDate *date = [formatter dateFromString:stringDate];
    return date;
}

#pragma mark - Set/Get

- (NSString *)stringDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    // 时间格式，hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 将字符串按formatter转成nsdate
    NSString *date = [formatter stringFromDate:self];
    return date;
}

- (NSString * (^)(NSString *))stringDateWithFormat {
    return ^(NSString *format){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:format];
         NSString *stringDate = [formatter stringFromDate:self];
        return stringDate;
    };
}

@end
