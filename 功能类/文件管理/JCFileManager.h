//
//  JCFileManager.h
//  File
//
//  Created by ibokan on 15/8/14.
//  Copyright (c) 2015年 molin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCFileManager : NSObject
/**
 *  获取沙盒
 *
 *  @return 沙盒
 */
- (NSString *)getDocumentsPath;
/**
 *  创建文件夹
 *
 *  @param directory 文件夹名
 *
 *  @return 是否创建成功
 */
- (BOOL)createDirectory:(NSString *)directory;
/**
 *  在某文件夹下创建文件
 *
 *  @param file      文件
 *  @param directory 文件夹 （为nil时直接在沙盒下创建）
 *
 *  @return 是否成功
 */
- (BOOL)createFile:(NSString *)file andDirectory:(NSString *)directory;
/**
 *  写文件
 *
 *  @param file      文件
 *  @param string    内容
 *  @param directory 文件夹
 *
 *  @return 是否写入成功
 */
- (BOOL)writeFile:(NSString *)file andData:(NSString *)string andDirectory:(NSString *)directory;
/**
 *  读取文件
 *
 *  @param file      文件
 *  @param directory 文件夹
 *
 *  @return 内容
 */
- (NSString *)readFile:(NSString *)file andDirectory:(NSString *)directory;
/**
 *  判断文件是否存在
 *
 *  @param file      文件
 *  @param directory 文件夹
 *
 *  @return 是否存在
 */
- (BOOL)isSxistAtPath:(NSString *)file andDirectory:(NSString *)directory;
/**
 *  计算文件大小
 *
 *  @param file      文件
 *  @param directory 文件夹
 *
 *  @return 文件大小
 */
- (unsigned long long)fileSizeAtPath:(NSString *)file andDirectory:(NSString *)directory;
/**
 *  计算整个文件夹中所有文件大小
 *
 *  @param folderPath 文件夹
 *
 *  @return 大小
 */
- (unsigned long long)folderSizeAtPath:(NSString *)folderPath;
/**
 *  删除文件
 *
 *  @param file      文件
 *  @param directory 文件夹
 *
 *  @return 是否删除成功
 */
- (BOOL)deleteFile:(NSString *)file andDirectory:(NSString *)directory;
/**
 *  移动文件
 *
 *  @param file          文件
 *  @param directory     移动前文件夹
 *  @param moveDirectory 移动后文件夹
 *
 *  @return 是否移动成功
 */
- (BOOL)moveFile:(NSString *)file andDirectory:(NSString *)directory andMoveDirectory:(NSString *)moveDirectory;
/**
 *  重命名文件
 *
 *  @param file      文件
 *  @param fileName  重命名
 *  @param directory 文件夹
 *
 *  @return 是否重命名成功
 */
- (BOOL)renameFile:(NSString *)file andFileName:(NSString *)fileName andDirectory:(NSString *)directory;
@end
