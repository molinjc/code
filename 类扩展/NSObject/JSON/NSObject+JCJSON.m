//
//  NSObject+JCJSON.m
//  JianShu
//
//  Created by molin on 16/3/21.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "NSObject+JCJSON.h"
#import <objc/runtime.h>

@implementation NSObject (JCJSON)

+ (instancetype)modelWithJSONName:(NSString *)name {
    NSData *data = [self dataWithJSONName:name];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    if (![dic isKindOfClass:[NSDictionary class]]) {
//        dic = nil;
//    }
    Class className = [self class];
    NSObject *model = [className new];
//    [model setValuesForKeysWithDictionary:dic];
    [model modelValuesForKeysWithDictionary:dic];
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
//    [model setValuesForKeysWithDictionary:dic];  系统的方法
    [model modelValuesForKeysWithDictionary:dic];
    return model;
}

+ (NSData *)dataWithJSONName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    return [NSData dataWithContentsOfFile:path];
}

- (void)modelValuesForKeysWithDictionary:(NSDictionary<NSString *, id> *)keyedValues {
    NSMutableArray *propertys = [self allPropertys];
    [propertys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = keyedValues[key];
        if (!value) {
            value = nil;
        }
        [self setValue:value forKey:key];
    }];
}

/**
 *  获取属性
 */
- (NSMutableArray *)allPropertys {
    unsigned int count;
    NSMutableArray *propertyArray = [NSMutableArray new];
    // 获取指向该类所有属性的指针
    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    
    for (int i=0; i<count; i++) {
        
        // 获得该类的一个属性的指针
        objc_property_t property = propertys[i];
        
        // 获取属性的名称
        const char *name = property_getName(property);
        
        // 将C的字符串转为OC的
        NSString *key = [NSString stringWithUTF8String:name];
        [propertyArray addObject:key];
    }
    free(propertys);
    return propertyArray;
}

@end
