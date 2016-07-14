//
//  NSDate+JCTransition.h
//  SHBracelet_iOS
//
//  Created by molin on 16/5/3.
//  Copyright © 2016年 ChenShuaiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JCTransition)

@property (nonatomic, copy, readonly) NSString *stringDate;

@property (nonatomic, copy, readonly) NSString * (^stringDateWithFormat)(NSString *format);

+ (NSDate *)dateWithString:(NSString *)stringDate;

+ (NSDate *)dateWithString:(NSString *)stringDate format:(NSString *)format;

@end
