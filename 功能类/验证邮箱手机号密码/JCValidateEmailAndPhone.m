//
//  JCValidateEmailAndPhone.m
//  验证邮箱和手机号
//
//  Created by ibokan on 15/8/19.
//  Copyright (c) 2015年 molin. All rights reserved.
//

#import "JCValidateEmailAndPhone.h"

@implementation JCValidateEmailAndPhone
/**
 *  验证邮箱
 *
 *  @param email 邮箱
 *
 *  @return 是否正确
 */
+ (BOOL)validateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:email];
}
/**
 *  验证手机号
 *
 *  @param phone 手机号
 *
 *  @return 是否正确
 */
+ (BOOL)validatePhone:(NSString *)phone{
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    // 中国移动 China Mobile
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    // 中国联通 China Unicom
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    // 中国电信 China Telecom
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSPredicate *regextestMOBILE = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    NSPredicate *regextestCM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    NSPredicate *regextestCU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    NSPredicate *regextestCT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    if (([regextestMOBILE evaluateWithObject:phone]==YES)||([regextestCM evaluateWithObject:phone]==YES)||([regextestCT evaluateWithObject:phone]==YES)||([regextestCU evaluateWithObject:phone]==YES)) {
        return YES;
    }else{
        return NO;
    }
}
/**
 *  验证手机运营商
 *
 *  @param phone 手机号
 *
 *  @return 是否正确
 */
+ (NSString *)validatePhoneOperator:(NSString *)phone{
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    // 中国移动 China Mobile
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    // 中国联通 China Unicom
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    // 中国电信 China Telecom
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSPredicate *regextestMOBILE = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    NSPredicate *regextestCM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    NSPredicate *regextestCU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    NSPredicate *regextestCT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    if (([regextestMOBILE evaluateWithObject:phone]==YES)||([regextestCM evaluateWithObject:phone]==YES)||([regextestCT evaluateWithObject:phone]==YES)||([regextestCU evaluateWithObject:phone]==YES)) {
        NSString *str;
        if ([regextestCM evaluateWithObject:phone]) {
            str = @"中国移动";
        }else if ([regextestCT evaluateWithObject:phone]){
            str =  @"中国电信";
        }else if ([regextestCU evaluateWithObject:phone]){
            str =  @"中国联通";
        }
        return str;
    }else{
        return @"号码错误";
    }
}
/**
 *  验证密码
 *
 *  @param password 密码
 *
 *  @return 是否正确
 */
+ (BOOL)validatePassword:(NSString *)password{
    NSString *pattern = @"^([+-+]|[*-*]|[~-~]|[.-.]|[ - ]|[/-/]|[,-,]|[?-?]|[!-!]|[@-@]|[#-#]|[|-|]|[$-$]|[%-%]|[&-&]|[(-(]|[)-)]|[0-9]|[A-Z]|[a-z])+([+-+]|[*-*]|[~-~]|[.-.]|[ - ]|[/-/]|[,-,]|[?-?]|[!-!]|[@-@]|[#-#]|[|-|]|[$-$]|[%-%]|[&-&]|[(-(]|[)-)]|[0-9]|[A-Z]|[a-z]){6,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:password];
}
@end
