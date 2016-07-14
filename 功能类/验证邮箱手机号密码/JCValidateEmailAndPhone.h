//
//  JCValidateEmailAndPhone.h
//  验证邮箱和手机号
//
//  Created by ibokan on 15/8/19.
//  Copyright (c) 2015年 molin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCValidateEmailAndPhone : NSObject
/**
 *  验证邮箱
 *
 *  @param email 邮箱
 *
 *  @return 是否正确
 */
+ (BOOL)validateEmail:(NSString *)email;
/**
 *  验证手机号
 *
 *  @param phone 手机号
 *
 *  @return 是否正确
 */
+ (BOOL)validatePhone:(NSString *)phone;
/**
 *  验证手机运营商
 *
 *  @param phone 手机号
 *
 *  @return 是否正确
 */
+ (NSString *)validatePhoneOperator:(NSString *)phone;
/**
 *  验证密码
 *
 *  @param password 密码
 *
 *  @return 是否正确
 */
+ (BOOL)validatePassword:(NSString *)password;
@end
