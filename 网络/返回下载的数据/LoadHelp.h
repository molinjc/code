//
//  LoadHelp.h
//  TestSBJSON
//
//  Created by guan song on 15/6/10.
//  Copyright (c) 2015年 guan song. All rights reserved.
//

#import <Foundation/Foundation.h>
//服务器地址
#define URL_SERVER @"http://112.74.105.205/upload/mapi/index.php"
@interface LoadHelp : NSObject


/**
 *声明get请求方法
 *
 *  @param param   请求参数
 *  @param handler 请求解析数据成功回调的代码块
 *  @param fail    请求失败或解析失败回调的代码块
 */
+(void)getLoadDataParam:(NSString *)param and:(void (^)(NSDictionary *dic)) handler  and:(void (^)(NSError *error))fail;

/**
 *声明POST请求方法
 *
 *  @param param   请求参数
 *  @param handler 请求解析数据成功回调的代码块
 *  @param fail    请求失败或解析失败回调的代码块
 */
+(void)postLoadDataParam:(NSString *)param and:(void (^)(NSDictionary *dic)) handler  and:(void (^)(NSError *error))fail;


@end
