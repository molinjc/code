//
//  NSObject+JCJSON.m
//  JianShu
//
//  Created by molin on 16/3/21.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "NSObject+JCJSON.h"

@implementation NSObject (JCJSON)

+ (instancetype)modelWithJSONName:(NSString *)name {
    NSData *data = [self dataWithJSONName:name];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    if (![dic isKindOfClass:[NSDictionary class]]) {
//        dic = nil;
//    }
    Class className = [self class];
    NSObject *model = [className new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

+ (instancetype)modelWithJSON:(id)json {
    if (!json || json == (id)kCFNull) {
        return nil;
    }
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    }else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding:NSUTF8StringEncoding];
    }else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if (![dic isKindOfClass:[NSDictionary class]]) {
            dic = nil;
        }
    }
    Class className = [self class];
    NSObject *model = [className new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

+ (NSData *)dataWithJSONName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    return [NSData dataWithContentsOfFile:path];
}



@end
