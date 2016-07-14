//
//  SQLHelp.m
//  UI_6.17_SQL
//
//  Created by ibokan on 15/6/17.
//  Copyright (c) 2015年 molin. All rights reserved.
//

#import "SQLHelp.h"

@implementation SQLHelp
/**
 *  获取沙盒地址
 *
 *  @return 沙盒地址
 */
- (NSString *)getFilePath{
    //获取documentluj
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取第0个地址
    NSString *path = paths[0];
    //获取数据库的地址，拼接数据库名称
    NSString *filePath = [path stringByAppendingPathComponent:@"/GoodsList.sqlite"];
    //判断数据库存在不？
    //创建文件管理器
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        //若文件不存在就复制
        NSString *fileSqlPath = [[NSBundle mainBundle]pathForResource:@"GoodsList" ofType:@"sqlite"];
        
        NSError *error = nil;
        //执行文件复制
        [manager copyItemAtPath:fileSqlPath toPath:filePath error:&error];
        
        if (error != nil) {
            
            NSLog(@"%@",error);
            return nil;
        }
    }
    NSLog(@"path:%@",filePath);
    return filePath;
}
/**
 *  打开数据库
 *
 *  @return 打开状态
 */
- (BOOL)openDB{
    
    NSString *path = [self getFilePath];//获取数据库地址
    //打开数据库
    int rst = sqlite3_open([path UTF8String], &db);
    if (rst == SQLITE_OK ) {
        
        NSLog(@"打开成功");
        return YES;
    }else{
        NSLog(@"打开失败");
        return NO;
    }
}
/**
 *  关闭数据库
 */
- (void)closeDB{
    sqlite3_close(db);
}
/**
 *  插入数据
 *
 *  @param dic 数据（字典）
 *
 *  @return 返回插入结果
 */
- (BOOL)insert:(NSDictionary *)dic{
    
    //打开数据库
    BOOL rst = [self openDB];
    if (rst) {
        NSString *sql = [NSString stringWithFormat:@"insert into 'goodsListTable' ('goods_id','title','image','cur_price','cur_price_format','ori_price','ori_price_format','isSelect','number') values ('%@','%@','%@','%@','%@','%@','%@','%@','%@')",dic[@"goods_id"],dic[@"title"],dic[@"image"],dic[@"cur_price"],dic[@"cur_price_format"],dic[@"ori_price"],dic[@"ori_price_format"],@"0",@"0"];
        
        NSLog(@"%@",sql);
        //创建一个存放插入错误信息的变量
        char *err;
        //执行
        int result = sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err);
        
        if (result == SQLITE_OK) {
            NSLog(@"插入成功");
            //关闭数据库
            [self closeDB];
            return YES;
        }else{
            NSLog(@"插入失败：%s",err);
            [self closeDB];
            return NO;
        }
    }else{
        return NO;
    }
}
/**
 *  查询ff
 *
 *  @param str 查询条件
 *
 *  @return 返回查询结果
 */
- (NSMutableArray *)select:(NSString *)goods_id{
    
    BOOL rst = [self openDB];
    
    if (rst) {
        
        //初始化数组
        NSMutableArray *arr = [NSMutableArray new];
        //创建sql语句
        NSString *sql;
        if (goods_id == nil) {
            sql = @"select * from goodsListTable";
        }else{
            sql = [NSString stringWithFormat:@"select * from goodsListTable where goods_id=%@",goods_id];
        }
        NSLog(@"%@",sql);
        //创建返回来的结果对象
        sqlite3_stmt  *statement;
        //执行sql语句
        int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
        
        if (result == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                //拿出第0列
                char *goods_id = (char *)sqlite3_column_text(statement, 0);
                char *title = (char *)sqlite3_column_text(statement, 1);
                char *image = (char *)sqlite3_column_text(statement, 2);
                char *ori_price_format = (char *)sqlite3_column_text(statement, 3);
                char *cur_price_format = (char *)sqlite3_column_text(statement, 4);
                char *ori_price = (char *)sqlite3_column_text(statement, 5);
                char *cur_price = (char *)sqlite3_column_text(statement, 6);
                char *isSelect = (char *)sqlite3_column_text(statement, 7);
                char *number = (char *)sqlite3_column_text(statement, 8);
                
                
                //转换数据类型为字符串
                NSString *str_goods_id = [NSString stringWithUTF8String:goods_id];
                NSString *str_title = [NSString stringWithUTF8String:title];
                NSString *str_image = [NSString stringWithUTF8String:image];
                NSString *str_cur_price = [NSString stringWithUTF8String:cur_price];
                NSString *str_cur_price_format = [NSString stringWithUTF8String:cur_price_format];
                NSString *str_ori_price = [NSString stringWithUTF8String:ori_price];
                NSString *str_ori_price_format = [NSString stringWithUTF8String:ori_price_format];
                NSString *str_isSelect = [NSString stringWithUTF8String:isSelect];
                NSString *str_number = [NSString stringWithUTF8String:number];
                
                
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:str_goods_id,@"goods_id",str_title,@"title",str_image,@"image",str_cur_price,@"cur_price",str_cur_price_format,@"cur_price_format",str_ori_price,@"ori_price",str_ori_price_format,@"ori_price_format",str_isSelect,@"isSelect",str_number,@"number",nil];
                
                [arr addObject:dic];
            }
            NSLog(@"查询成功");
            //关闭数据库
            [self closeDB];
            return arr;
        }else{
            NSLog(@"查询失败");
            [self closeDB];
            return nil;
        }
    }else{
        NSLog(@"打开数据库失败");
        [self closeDB];
        return nil;
    }
}


-(BOOL)update:(NSString *)is andSelect:(NSString *)select{
    
    //先查询
    NSMutableArray *arr = [self select:select];
    //判断能不能找到要修改商品
    if (arr.count<1) {
        NSLog(@"不存在要修改的对象");
        return NO;
    }else{
        //打开数据库
        BOOL rst = [self openDB];
        if (rst) {
            
            NSString *sql = [NSString stringWithFormat:@"update 'goodsListTable' set 'isSelect'='%@' where goods_id='%@'",is,select];
            NSLog(@"%@",sql);
            //创建存储存储错误信息的变量
            char *err;
            int result = sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err);
            if (result != SQLITE_OK) {
                [self closeDB];
                NSLog(@"更新失败：%s",err);
                return NO;
            }else{
                NSLog(@"修改成功");
                return YES;
            }
            
        }else{
            NSLog(@"打开失败");
            return NO;
        }
    }
}

-(BOOL)update_2:(NSString *)num andSelect:(NSString *)select{
    
    //先查询
    NSMutableArray *arr = [self select:select];
    //判断能不能找到要修改商品
    if (arr.count<1) {
        NSLog(@"不存在要修改的对象");
        return NO;
    }else{
        //打开数据库
        BOOL rst = [self openDB];
        if (rst) {
            
            NSString *sql = [NSString stringWithFormat:@"update 'goodsListTable' set 'number'='%@' where goods_id='%@'",num,select];
            NSLog(@"%@",sql);
            //创建存储存储错误信息的变量
            char *err;
            int result = sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err);
            if (result != SQLITE_OK) {
                [self closeDB];
                NSLog(@"更新失败：%s",err);
                return NO;
            }else{
                NSLog(@"修改成功");
                return YES;
            }
            
        }else{
            NSLog(@"打开失败");
            return NO;
        }
    }
}

-(BOOL)del:(NSString *)goods_id{
    
    NSMutableArray *arr = [self select:goods_id];
    if (arr.count<1) {
        NSLog(@"没有要删除的对象");
        return NO;
    }else{
        
        NSString *sql = [NSString stringWithFormat:@"delete from 'goodsListTable' where goods_id = %@",goods_id];
        char *err;
        int rst = sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err);
        if (rst == SQLITE_OK) {
            
            NSLog(@"删除成功");
            [self closeDB];
            return YES;
        }else{
            NSLog(@"删除失败%s",err);
            [self closeDB];
            return NO;
        }
    }
}

@end
