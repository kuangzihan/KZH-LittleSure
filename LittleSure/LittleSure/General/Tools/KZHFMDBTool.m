//
//  KZHFMDBTool.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/9.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHFMDBTool.h"

static KZHFMDBTool *tool = nil;

@implementation KZHFMDBTool

+(KZHFMDBTool *)tool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tool == nil) {
            tool = [[self alloc] init];
        }
    });
    return tool;
}


+(instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tool == nil) {
            tool = [super allocWithZone:zone];
        }
    });
    return tool;
}

#pragma mark -- 创建数据库
-(FMDatabase *)getDBWithDBName:(NSString *)dbName{
    NSArray *library = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *dbPath = [library[0] stringByAppendingPathComponent:dbName];
    NSLog(@"%@", dbPath);
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        LSLog(@"无法获取数据库");
        return nil;
    } else {
        LSLog(@"打开%@成功", dbName);
    }
    return db;
}

#pragma mark -- 给指定数据库建表
-(void)DataBase:(FMDatabase *)db createTable:(NSString *)tableName keyTypes:(NSDictionary *)keyTypes {
    if ([self isOpenDatabese:db]) {
        NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (",tableName]];
        int count = 0;
        for (NSString *key in keyTypes) {
            count++;
            [sql appendString:key];
            [sql appendString:@" "];
            [sql appendString:[keyTypes valueForKey:key]];
            if (count != [keyTypes count]) {
                [sql appendString:@", "];
            }
        }
        [sql appendString:@")"];
        LSLog(@"%@", sql);
        BOOL flag = [db executeUpdate:sql];
        [self isFlag:flag];
    }
}

#pragma mark -- 给指定数据库的表添加值
-(void)DataBase:(FMDatabase *)db insertKeyValues:(NSDictionary *)keyValues intoTable:(NSString *)tableName {
    if ([self isOpenDatabese:db]) {
        NSArray *keys = [keyValues allKeys];
        NSArray *values = [keyValues allValues];
        NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"INSERT INTO %@ (", tableName]];
        NSInteger count = 0;
        for (NSString *key in keys) {
            [sql appendString:key];
            count ++;
            if (count < [keys count]) {
                [sql appendString:@", "];
            }
        }
        [sql appendString:@") VALUES ("];
        
        for (int i = 0; i < [values count]; i++) {
            [sql appendString:@"?"];
            if (i < [values count] - 1) {
                [sql appendString:@","];
            }
        }
        [sql appendString:@")"];
        NSLog(@"%@", sql);
        BOOL flag = [db executeUpdate:sql withArgumentsInArray:values];
        [self isFlag:flag];
    }
}

#pragma mark -- 给指定数据库的表更新值
-(void)DataBase:(FMDatabase *)db updateTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues {
    if ([self isOpenDatabese:db]) {
        for (NSString *key in keyValues) {
            NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UPDATE %@ SET %@ = ?", tableName, key]];
            BOOL flag = [db executeUpdate:sql,[keyValues valueForKey:key]];
            [self isFlag:flag];
        }
    }
}

#pragma mark -- 条件更新
-(void)DataBase:(FMDatabase *)db updateTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues whereCondition:(NSDictionary *)condition {
    if ([self isOpenDatabese:db]) {
        for (NSString *key in keyValues) {
            NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UPDATE %@ SET %@ = ? WHERE %@ = ?", tableName, key, [condition allKeys][0]]];
            BOOL flag = [db executeUpdate:sql,[keyValues valueForKey:key],[keyValues valueForKey:[condition allKeys][0]]];
            [self isFlag:flag];
        }
    }
}

#pragma mark -- 查询数据库表中的所有值
-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName {
    FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableName]];
    return [self getArrWithFMResultSet:result keyTypes:keyTypes];
}

#pragma mark -- 条件查询数据库中的数据
-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereCondition:(NSDictionary *)condition {
    if ([self isOpenDatabese:db]) {
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ? LIMIT 10",tableName, [condition allKeys][0]], [condition valueForKey:[condition allKeys][0]]];
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    } else {
        return nil;
    }
}

#pragma mark -- 模糊查询 某字段以指定字符串开头的数据
-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key beginWithStr:(NSString *)str {
    if ([self isOpenDatabese:db]) {
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE %@%% LIMIT 10",tableName, key, str]];
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    } else {
        return nil;
    }
}

#pragma mark -- 模糊查询 某字段包含指定字符串的数据
-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key containStr:(NSString *)str {
    if ([self isOpenDatabese:db]) {
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE %%%@%% LIMIT 10",tableName, key, str]];
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    } else {
        return nil;
    }
}

#pragma mark -- 模糊查询 某字段以指定字符串结尾的数据
-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key endWithStr:(NSString *)str {
    if ([self isOpenDatabese:db]) {
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE %%%@ LIMIT 10",tableName, key, str]];
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    } else {
        return nil;
    }
}

#pragma mark -- 清理指定数据库中的数据
-(void)clearDatabase:(FMDatabase *)db from:(NSString *)tableName {
    if ([self isOpenDatabese:db]) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",tableName]];
    }
}

#pragma mark -- 条件清理指定数据库中的数据
-(void)clearDatabase:(FMDatabase *)db from:(NSString *)tableName whereCondition:(NSDictionary *)condition {
    if ([self isOpenDatabese:db]) {
        for (NSString *key in condition) {
            NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?", tableName, key]];
            BOOL flag = [db executeUpdate:sql, [condition valueForKey:key]];
            [self isFlag:flag];
        }
    }
}

#pragma mark -- CommonMethod
-(NSArray *)getArrWithFMResultSet:(FMResultSet *)result keyTypes:(NSDictionary *)keyTypes {
    NSMutableArray *tempArr = [NSMutableArray array];
    while ([result next]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < keyTypes.count; i++) {
            NSString *key = [keyTypes allKeys][i];
            NSString *value = [keyTypes valueForKey:key];
            if ([value isEqualToString:@"text"]) {
                // 字符串
                [tempDic setValue:[result stringForColumn:key] forKey:key];
            } else if([value isEqualToString:@"blob"]) {
                // 二进制对象
                [tempDic setValue:[result dataForColumn:key] forKey:key];
            } else if ([value isEqualToString:@"integer"]) {
                // 带符号整数类型
                [tempDic setValue:@([result intForColumn:key]) forKey:key];
            } else if ([value isEqualToString:@"boolean"]) {
                // BOOL型
                [tempDic setValue:@([result boolForColumn:key]) forKey:key];
            } else if ([value isEqualToString:@"date"]) {
                // date
                [tempDic setValue:[result dateForColumn:key] forKey:key];
            }
        }
        [tempArr addObject:tempDic];
    }
    return tempArr;
}

-(BOOL)isOpenDatabese:(FMDatabase *)db {
    if (![db open]) {
        [db open];
    }
    return YES;
}

- (void)isFlag:(BOOL)flag {
    if (flag == YES) {
        LSLog(@"打开成功");
    }else{
        LSLog(@"打开失败");
    }
}

@end
