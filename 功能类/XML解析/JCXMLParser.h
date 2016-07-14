//
//  JCXMLParser.h
//  JCNSXMLParser
//
//  Created by molin on 16/5/12.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCXMLParser : NSObject

/**
 *  初始化方法，获取项目里的XML文件
 *
 *  @param name XML文件名
 *
 *  @return 对象
 */
- (instancetype)initWithContentsOfName:(NSString *)name;

/**
 *  初始化方法，获取沙盒里的XML文件
 *
 *  @param path 沙盒路径
 *
 *  @return 对象
 */
- (instancetype)initWithContentsOfPath:(NSString *)path;

/**
 *  初始化方法，获取网络上的XML文件
 *
 *  @param url 地址
 *
 *  @return 对象
 */
- (instancetype)initWithContentsOfURL:(NSURL *)url;

/**
 *  初始化方法，字符串转换XML数据
 *
 *  @param string XML的字符串
 *
 *  @return 对象
 */
- (instancetype)initWithContentsOfString:(NSString *)string;

/**
 *  开始解析XML
 *
 *  @param content 解析内容（通过代码块回调）
 */
- (void)startParseXML:(void (^)(NSMutableDictionary *contents))content;

@end

