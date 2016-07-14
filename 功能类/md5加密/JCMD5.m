//
//  JCMD5.m
//  MD5Demo
//
//  Created by ibokan on 15/7/30.
//
//CommonCrypto/CommonDigest.h

#import "JCMD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation JCMD5
/**
 *  32位加密
 *
 *  @param original 原始文本
 *
 *  @return 加密文本
 */
+ (NSString *)md5_32:(NSString *)original{
    const char *cStr = [original UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x",digest[i]];
    }
    return result;
}
/**
 *  16位加密
 *
 *  @param original 原始文本
 *
 *  @return 加密文本
 */
+ (NSString *)md5_16:(NSString *)original{
    NSString *str = [JCMD5 md5_32:original];
    return [[str substringToIndex:24] substringFromIndex:8];
}
/**
 *  32位第二次加密
 *
 *  @param original 原始文本
 *
 *  @return 加密文本
 */
+ (NSString *)to_32_secondEncryption:(NSString *)original{
    NSString *str = [JCMD5 md5_32:original];
    str = [JCMD5 md5_32:str];
    return str;
}
/**
 *  16位第二次加密
 *
 *  @param original 原始文本
 *
 *  @return 加密文本
 */
+ (NSString *)to_16_secondEncryption:(NSString *)original{
    NSString *str = [JCMD5 md5_16:original];
    str = [JCMD5 md5_16:str];
    return str;
}
@end
