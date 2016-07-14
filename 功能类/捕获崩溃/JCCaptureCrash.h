//
//  JCCaptureCrash.h
//  JCLog
///Users/molin/Desktop/JC/self-未成熟/JCLog/JCLog.xcodeproj
//  Created by molin on 16/1/27.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EXCEPTIONHANDLER NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);

@interface JCCaptureCrash : NSObject

void UncaughtExceptionHandler(NSException *exception);

@end
