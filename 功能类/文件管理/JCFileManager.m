//
//  JCFileManager.m
//  File
//
//  Created by ibokan on 15/8/14.
//  Copyright (c) 2015年 molin. All rights reserved.
//

#import "JCFileManager.h"

@implementation JCFileManager
/**
 *  获取沙盒
 *
 *  @return 沙盒
 */
- (NSString *)getDocumentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}
/**
 *  创建文件夹
 *
 *  @param directory 文件夹名
 *
 *  @return 是否创建成功
 */
- (BOOL)createDirectory:(NSString *)directory{
    NSString *documentsPath = [self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *iOSDirectory = [documentsPath stringByAppendingPathComponent:directory];
    BOOL isSuccess = [fileManager createDirectoryAtPath:iOSDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    return isSuccess;
}
/**
 *  在某文件夹下创建文件
 *
 *  @param file      文件
 *  @param directory 文件夹 （为nil时直接在沙盒下创建）
 *
 *  @return 是否成功
 */
- (BOOL)createFile:(NSString *)file andDirectory:(NSString *)directory{
    NSString *documentsPath = [self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath;
    if (directory != nil) {
       filePath = [NSString stringWithFormat:@"/%@/%@",directory,file];
    }else{
        filePath = file;
    }
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:filePath];
    BOOL isSuccess = [fileManager createFileAtPath:iOSPath contents:nil attributes:nil];
    return isSuccess;
}

/**
 *  写文件
 *
 *  @param file      文件
 *  @param string    内容
 *  @param directory 文件夹
 *
 *  @return 是否写入成功
 */
- (BOOL)writeFile:(NSString *)file andData:(NSString *)string andDirectory:(NSString *)directory{
    NSString *documentsPath = [self getDocumentsPath];
    NSString *filePath;
    if (directory != nil) {
        filePath = [NSString stringWithFormat:@"%@/%@",directory,file];
    }else{
        filePath = file;
    }
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:filePath];
    BOOL isSuccess = [string writeToFile:iOSPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return isSuccess;
}
/**
 *  读取文件
 *
 *  @param file      文件
 *  @param directory 文件夹
 *
 *  @return 内容
 */
- (NSString *)readFile:(NSString *)file andDirectory:(NSString *)directory{
    NSString *documentsPath = [self getDocumentsPath];
    NSString *filePath;
    if (directory != nil) {
        filePath = [NSString stringWithFormat:@"%@/%@",directory,file];
    }else{
        filePath = file;
    }
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:filePath];
    NSString *contents = [NSString stringWithContentsOfFile:iOSPath encoding:NSUTF8StringEncoding error:nil];
    return contents;
}
/**
 *  判断文件是否存在
 *
 *  @param file      文件
 *  @param directory 文件夹
 *
 *  @return 是否存在
 */
- (BOOL)isSxistAtPath:(NSString *)file andDirectory:(NSString *)directory{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath;
    if (directory != nil) {
        filePath = [NSString stringWithFormat:@"%@/%@",directory,file];
    }else{
        filePath = file;
    }
    NSString *filePath1=[self  getDocumentsPath];
    NSString  *newFilePath=[NSString  stringWithFormat:@"%@/%@",filePath1,filePath];
    
    return [fileManager fileExistsAtPath:newFilePath];
}
/**
 *  计算文件大小
 *
 *  @param file      文件
 *  @param directory 文件夹
 *
 *  @return 文件大小
 */
- (unsigned long long)fileSizeAtPath:(NSString *)file andDirectory:(NSString *)directory{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [self isSxistAtPath:file andDirectory:directory];
    NSString *filePath;
    if (directory != nil && file != nil) {
        filePath = [NSString stringWithFormat:@"%@/%@",directory,file];
    }else if(file != nil){
        filePath = directory;
    }
    NSString *filePath1=[self  getDocumentsPath];
    NSString  *newFilePath=[NSString  stringWithFormat:@"%@/%@",filePath1,filePath];
    if (isExist) {
        unsigned long long fileSize = [[fileManager attributesOfItemAtPath:newFilePath error:nil] fileSize];
        return fileSize;
    }else{
        return 0;
    }
}
/**
 *  计算整个文件夹中所有文件大小
 *
 *  @param folderPath 文件夹
 *
 *  @return 大小
 */
- (unsigned long long)folderSizeAtPath:(NSString *)folderPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString  *newFilePath=[NSString  stringWithFormat:@"%@/%@",[self  getDocumentsPath],folderPath];
    NSEnumerator *childFileEnumerator = [[fileManager subpathsAtPath:newFilePath] objectEnumerator];
    unsigned long long folderSize = 0;
    NSString *fileName = @"";
    while ((fileName = [childFileEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [newFilePath stringByAppendingPathComponent:fileName];
        folderSize += [[fileManager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
    }
    return folderSize;
}
/**
 *  删除文件
 *
 *  @param file      文件
 *  @param directory 文件夹
 *
 *  @return 是否删除成功
 */
- (BOOL)deleteFile:(NSString *)file andDirectory:(NSString *)directory{
    NSString *documentsPath = [self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",directory,file];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:filePath];
    BOOL isSuccess = [fileManager removeItemAtPath:iOSPath error:nil];
    return isSuccess;
}
/**
 *  移动文件
 *
 *  @param file          文件
 *  @param directory     移动前文件夹
 *  @param moveDirectory 移动后文件夹
 *
 *  @return 是否移动成功
 */
- (BOOL)moveFile:(NSString *)file andDirectory:(NSString *)directory andMoveDirectory:(NSString *)moveDirectory{
    NSString *documentsPath = [self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",directory,file];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:filePath];
    NSString *moveFilePath = [NSString stringWithFormat:@"%@/%@",moveDirectory,file];
    NSString *iOSMovePath = [documentsPath stringByAppendingPathComponent:moveFilePath];
    BOOL isSuccess = [fileManager moveItemAtPath:iOSPath toPath:iOSMovePath error:nil];
    return isSuccess;
}
/**
 *  重命名文件
 *
 *  @param file      文件
 *  @param fileName  重命名
 *  @param directory 文件夹
 *
 *  @return 是否重命名成功
 */
- (BOOL)renameFile:(NSString *)file andFileName:(NSString *)fileName andDirectory:(NSString *)directory{
    NSString *documentsPath = [self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",directory,file];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:filePath];
    NSString *moveFilePath = [NSString stringWithFormat:@"%@/%@",directory,fileName];
    NSString *iOSMovePath = [documentsPath stringByAppendingPathComponent:moveFilePath];
    BOOL isSuccess = [fileManager moveItemAtPath:iOSPath toPath:iOSMovePath error:nil];
    return isSuccess;
}
@end
