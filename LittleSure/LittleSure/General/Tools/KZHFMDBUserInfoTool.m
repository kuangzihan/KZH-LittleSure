//
//  KZHFMDBUserInfoTool.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/3.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHFMDBUserInfoTool.h"


@interface KZHFMDBUserInfoTool()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation KZHFMDBUserInfoTool

+ (instancetype)sharedFMDBDManager {
    static KZHFMDBUserInfoTool *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KZHFMDBUserInfoTool alloc] init];
    });
    return manager;
}

// Open
#pragma mark - 创建数据库
- (void)createDatabase {
    NSString *filePath = [self setDocumentPath];
    _db = [FMDatabase databaseWithPath:filePath];
    if (![_db open]) {
        LSLog(@"打开失败");
        return;
    }else {
        LSLog(@"打开成功");
        [self createMyUserInfoTable];
    }
}

#pragma mark - 创建添加好友表
- (void)createMyUserInfoTable {
    BOOL flag = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS MyUserInfoTable (userName text PRIMARY KEY NOT NULL, nickName text, iconURL text, message text, friendType integer);"];
    if (flag) {
        LSLog(@"创建MyUserInfoTable成功");
    } else {
        LSLog(@"创建MyUserInfoTable失败");
    }
}

#pragma mark - 添加好友
- (void)insertMyUserInfo:(KZHMainModel *)userInfo withFriendType:(int)friendType {
    LSLog(@"%@%@%@%d",userInfo.userName,userInfo.nickName,userInfo.iconURL,friendType);
    BOOL flag = [_db executeUpdate:@"insert into MyUserInfoTable(userName, nickName, iconURL, message, friendType) values(?,?,?,?,?)", userInfo.userName, userInfo.nickName, userInfo.iconURL, userInfo.message, @(friendType)];
    if (flag) {
        LSLog(@"插入MyUserInfoTable成功");
    }else{
        LSLog(@"插入MyUserInfoTable失败");
    }
}

#pragma mark - 修改个人资料
- (void)updateMyUserInfoWithKey:(NSString *)key withValue:(id)value withUserName:(NSString *)name {
    BOOL flag = [_db executeUpdate:[NSString stringWithFormat:@"update MyUserInfoTable set %@=%@ where userName=%@",
                                    key,
                                    value,
                                    name]];
    if (flag) {
        LSLog(@"修改MyUserInfoTable成功");
    } else { 
        LSLog(@"修改MyUserInfoTable失败");
    }
}

#pragma mark - 修改新的朋友状态
- (void)updateFriendWithType:(NSInteger)type withUserName:(NSString *)name {
    BOOL flag = [_db executeUpdate:@"update MyUserInfoTable set friendType = ? where userName = ?", @(type), name];
    if (flag) {
        LSLog(@"修改MyUserInfoTable成功");
    } else {
        LSLog(@"修改MyUserInfoTable失败");
    }
}

#pragma mark - 获取当前新的朋友列表
- (NSArray *)getNewFriendList {
    // 查找
    FMResultSet *set = [_db executeQuery:@"select * from MyUserInfoTable"];
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        NSString *userName = [set stringForColumn:@"userName"];
        NSString *nickName = [set stringForColumn:@"nickName"];
        NSString *iconURL = [set stringForColumn:@"iconURL"];
        NSString *message = [set stringForColumn:@"message"];
        NSInteger friendType = [set intForColumn:@"friendType"];
        NSDictionary *tempDic = @{@"userName":userName, @"nickName":nickName, @"iconURL":iconURL, @"message":message, @"friendType":@(friendType)};
        KZHMainModel *model = [KZHMainModel getDataForDictionary:tempDic];
        [dataArray addObject:model];
    }
    return dataArray;
}



// Private
#pragma mark - 获取数据库路径
- (NSString *)setDocumentPath {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"LittleSure_userInfo.sqlite"];
    return filePath;
}


@end
