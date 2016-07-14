//
//  JCCaptureCrash.m
//  JCLog
//
//  Created by molin on 16/1/27.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCCaptureCrash.h"

@implementation JCCaptureCrash

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
    NSString *name = [exception name];//异常类型
    NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];  // 项目名
    NSString *crash = @"";
    for (NSString *str in arr) {   // 拿到项目名的那条崩溃信息
        NSRange range = [str rangeOfString:executableFile];
        if (range.location != NSNotFound) {
            if (crash.length == 0) {
                crash = str;
            }else {
                crash = [NSString stringWithFormat:@" %@\n\t%@",crash,str];
            }
        }
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path = [path stringByAppendingString:@"/JCCrash.txt"];
    NSString *olgCrash = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    crash = [NSString stringWithFormat:@"%@ {\n异常类型:%@\n崩溃原因:%@\n崩溃信息:%@\n}\n",date,name,reason,crash];
    if (olgCrash.length != 0) {
        crash = [NSString stringWithFormat:@"%@%@",olgCrash,crash];
    }
    [crash writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"path:%@",path);
}

@end
