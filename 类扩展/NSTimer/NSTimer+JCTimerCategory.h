//
//  NSTimer+JCTimerCategory.h
//
//  Created by molin on 16/5/18.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (JCTimerCategory)

// ******** 下面四个类方法，是在原本的基础上修改的，添加了加入到NSRunLoop的代码。 ****************

+ (nonnull NSTimer *)runLoopAddTimerWithTimeInterval:(NSTimeInterval)ti invocation:(nonnull NSInvocation *)invocation repeats:(BOOL)yesOrNo;

+ (nonnull NSTimer *)runLoopAddScheduledTimerWithTimeInterval:(NSTimeInterval)ti invocation:(nonnull NSInvocation *)invocation repeats:(BOOL)yesOrNo;

+ (nonnull NSTimer *)runLoopAddTimerWithTimeInterval:(NSTimeInterval)ti target:(nonnull id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

+ (nonnull NSTimer *)runLoopAddScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(nonnull id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

// ********************** end **************************

// *********** 将selector(设定方法)回调改成Block回调 *****************

+ (nonnull NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo action:(nullable void (^)(void))block;

+ (nonnull NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo action:(nullable void (^)(void))block;

+ (nonnull NSTimer *)runLoopAddTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo action:(nullable void (^)(void))block;

+ (nonnull NSTimer *)runLoopAddscheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo action:(nullable void (^)(void))block;

// ********************** end **************************

@end
