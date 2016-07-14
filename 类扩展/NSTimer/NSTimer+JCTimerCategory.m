//
//  NSTimer+JCTimerCategory.m
//
//  Created by molin on 16/5/18.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "NSTimer+JCTimerCategory.h"

@implementation NSTimer (JCTimerCategory)

+ (NSTimer *)runLoopAddTimerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo {
    NSTimer *timer = [NSTimer timerWithTimeInterval:ti invocation:invocation repeats:yesOrNo];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

+ (NSTimer *)runLoopAddTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    NSTimer *timer = [NSTimer runLoopAddTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

+ (NSTimer *)runLoopAddScheduledTimerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti invocation:invocation repeats:yesOrNo];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

+ (NSTimer *)runLoopAddScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo action:(void (^)(void))block {
    NSTimer *timer = [NSTimer timerWithTimeInterval:ti target:self selector:@selector(timerSelector:) userInfo:[block copy] repeats:yesOrNo];
    return timer;
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo action:(void (^)(void))block {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(timerSelector:) userInfo:[block copy] repeats:yesOrNo];
    return timer;
}

+ (nonnull NSTimer *)runLoopAddTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo action:(void (^)(void))block {
    NSTimer *timer = [NSTimer timerWithTimeInterval:ti target:self selector:@selector(timerSelector:) userInfo:[block copy] repeats:yesOrNo];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

+ (nonnull NSTimer *)runLoopAddscheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo action:(void (^)(void))block {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(timerSelector:) userInfo:[block copy] repeats:yesOrNo];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

/**
 *  定时器回调方法
 *
 *  @param timer 定时器
 */
+ (void)timerSelector:(NSTimer *)timer {
    void (^actionBlock)(void) = [timer userInfo];
    if (actionBlock) {
        actionBlock();
    }
}


@end
