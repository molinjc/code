//
//  JCXMLParser.m
//  JCNSXMLParser
//
//  Created by molin on 16/5/12.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCXMLParser.h"

#define kXMLELEMENTCONTENT @"string"
#define kXMLELEMENTATtTRIBUTE @"attribute"
#define kXMLELEMENTNAME @"name"

@class NSMutableDictionary;

@interface JCXMLParser () <NSXMLParserDelegate> {
    NSInteger count;
}

@property (nonatomic, strong) NSData *XMLData;

@property (nonatomic, copy) void (^contentsBlock)(NSMutableDictionary *contents);

@property (nonatomic, strong) NSMutableArray *elementContents;

@property (nonatomic, strong) NSMutableDictionary *contentsDictionary;

@end

@implementation JCXMLParser

/**
 *  初始化方法，获取项目里的XML文件
 *
 *  @param name XML文件名
 *
 *  @return 对象
 */
- (instancetype)initWithContentsOfName:(NSString *)name {
    if (self = [super init]) {
        _XMLData = [self XMLDataOfName:name];
    }
    return self;
}

/**
 *  初始化方法，获取沙盒里的XML文件
 *
 *  @param path 沙盒路径
 *
 *  @return 对象
 */
- (instancetype)initWithContentsOfPath:(NSString *)path {
    if (self = [super init]) {
        _XMLData = [NSData dataWithContentsOfFile:path];
    }
    return self;
}

/**
 *  初始化方法，获取网络上的XML文件
 *
 *  @param url 地址
 *
 *  @return 对象
 */
- (instancetype)initWithContentsOfURL:(NSURL *)url {
    if (self = [super init]) {
        _XMLData = [NSData dataWithContentsOfURL:url];
    }
    return self;
}

/**
 *  初始化方法，字符串转换XML数据
 *
 *  @param string XML的字符串
 *
 *  @return 对象
 */
- (instancetype)initWithContentsOfString:(NSString *)string {
    if (self = [super init]) {
        _XMLData = [string dataUsingEncoding:NSUTF8StringEncoding];
    }
    return self;
}

/**
 *  根据名字获取XML数据
 *
 *  @param name XML的文件名
 *
 *  @return XML数据
 */
- (NSData *)XMLDataOfName:(NSString *)name {
    if (!name.length) {
        return nil;
    }
    if ([name hasSuffix:@"/"]) {
        return nil;
    }
    NSString *fileName = name.stringByDeletingPathExtension;
    NSString *fileExtension = name.pathExtension;
    if (!fileExtension.length) {
        fileExtension = @"xml";
    }
    NSString *XMLFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension];
    return [NSData dataWithContentsOfFile:XMLFilePath];
}

/**
 *  开始解析XML
 *
 *  @param content 解析内容（通过代码块回调）
 */
- (void)startParseXML:(void (^)(NSMutableDictionary *contents))content {
    self.contentsBlock = content;
    NSXMLParser *XMLParser = [[NSXMLParser alloc] initWithData:_XMLData];
    XMLParser.delegate = self;
    [XMLParser parse];
}

/*
  实现方法：
  1、创建一个数组，来存储每个节点的节点名、属性、值
  2、定义一个计数变量
  3、一个节点解析完会回调didEndElement，在didEndElement的回调方法里判断当前解析完的节点是否是计数记录的节点，不是的话那就是这个块的根节点。开始处理该块的数据。
  4、拿到该块的根节点的下标，从这个下标开始处理。有的节点有属性，有的有值。
  5、块处理完，加到字典，若字典已经存在该根节点，说明这个块可能多个，那换成数组。
 */

/**
 *  处理节点
 *
 *  @param elementName 节点名
 */
- (void)disposeWithElementName:(NSString *)elementName {
    NSInteger __block index;
    [_elementContents enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = obj[kXMLELEMENTNAME];
        if ([elementName isEqualToString:name]) {
            index = idx;
        }
    }];
    NSMutableDictionary *mutableContentDic = [NSMutableDictionary new];
    
    for (NSInteger i = index; i < _elementContents.count; i++) {
        NSMutableDictionary *mutableDic = _elementContents[i];
        NSDictionary *attributeDict = mutableDic[kXMLELEMENTATtTRIBUTE];
        NSString *value = mutableDic[kXMLELEMENTCONTENT];
        NSString *elementName_0 = mutableDic[kXMLELEMENTNAME];
        if (i == index) {
            if (attributeDict.allKeys.count > 0) {
                [mutableContentDic setObject:attributeDict forKey:kXMLELEMENTATtTRIBUTE];
            }
            if (value.length) {
                [mutableContentDic setObject:value forKey:elementName_0];
            }
        }else {
            if (attributeDict.allKeys.count > 0) {
                if (value.length) {
                    NSDictionary *dic = @{elementName_0:value,kXMLELEMENTATtTRIBUTE:attributeDict};
                    [mutableContentDic setObject:dic forKey:elementName_0];
                }else {
                    [mutableContentDic setObject:attributeDict forKey:elementName_0];
                }
            }else if (value.length) {
                [mutableContentDic setObject:value forKey:elementName_0];
            }
        }
    }
    
    NSInteger leng = _elementContents.count  - index;
    [_elementContents removeObjectsInRange:NSMakeRange(index, leng)];
    count -= leng;
    NSArray *keys = self.contentsDictionary.allKeys;
    if ([keys containsObject:elementName]) {
        id equalObject = self.contentsDictionary[elementName];
        if (![equalObject isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray *mutableArray = [NSMutableArray new];
            [mutableArray addObject:equalObject];
            [mutableArray addObject:mutableContentDic];
            [self.contentsDictionary removeObjectForKey:elementName];
            [self.contentsDictionary setObject:mutableArray forKey:elementName];
        }else {
            [equalObject addObject:mutableContentDic];
        }
    }else {
        [self.contentsDictionary setObject:mutableContentDic forKey:elementName];
    }
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    _elementContents = [NSMutableArray new];
    self.contentsDictionary = [NSMutableDictionary new];
    count = -1;
}
// 只要解析完毕XML文档就会调用
-(void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.contentsDictionary) {
        self.contentsBlock(self.contentsDictionary);
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(nonnull NSDictionary<NSString *,NSString *> *)attributeDict {
    NSMutableDictionary *mutableDic = [NSMutableDictionary new];
    [mutableDic setObject:elementName forKey:kXMLELEMENTNAME];
    [mutableDic setObject:attributeDict forKey:kXMLELEMENTATtTRIBUTE];
    [_elementContents addObject:mutableDic];
    count ++;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(nonnull NSString *)string {
    NSMutableDictionary *mutableDic = _elementContents[count];
    if (!string.length || [string hasPrefix:@"\n"] || [string hasPrefix:@"\n\t"]) {
        string = @"";
    }
    if (mutableDic.allKeys.count == 2) {
        [mutableDic setObject:string forKey:kXMLELEMENTCONTENT];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSString *beforeElementName = _elementContents[count][kXMLELEMENTNAME];
    if (![beforeElementName isEqualToString:elementName]) {
        [self disposeWithElementName:elementName];
    }
}

// 解析出现错误时调用
-(void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError{
}

@end