//
//  SQLHelp.h
//  UI_6.17_SQL
//
//  Created by ibokan on 15/6/17.
//  Copyright (c) 2015年 molin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SQLHelp : NSObject

//创建对象
{
    sqlite3 *db;//要操作数据库的对象
}

- (BOOL)insert:(NSDictionary *)dic;
//声明查询方法
- (NSMutableArray *)select:(NSString *)goods_id;
//声明更新数据方法
-(BOOL)update:(NSString *)is andSelect:(NSString *)select;
-(BOOL)update_2:(NSString *)num andSelect:(NSString *)select;


-(BOOL)del:(NSString *)goods_id;

@end
