//
//  JCMD5.h
//  MD5Demo
//
//  Created by ibokan on 15/7/30.
//
//

#import <Foundation/Foundation.h>

@interface JCMD5 : NSObject

+ (NSString *)md5_32:(NSString *)original;
+ (NSString *)md5_16:(NSString *)original;
+ (NSString *)to_32_secondEncryption:(NSString *)original;
+ (NSString *)to_16_secondEncryption:(NSString *)original;
@end
