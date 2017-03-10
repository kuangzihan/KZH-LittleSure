//
//  KZHFMDBUserInfoTool.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/3.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "KZHMainModel.h"
@interface KZHFMDBUserInfoTool : NSObject

+ (instancetype)sharedFMDBDManager;

// 创建数据库
- (void)createDatabase;

// 创建个人信息表
- (void)createMyUserInfoTable;

// 添加好友
- (void)insertMyUserInfo:(KZHMainModel *)userInfo withFriendType:(int)friendType;

// 修改个人资料
- (void)updateMyUserInfoWithKey:(NSString *)key withValue:(id)value withUserName:(NSString *)name;

// 修改新的朋友状态
- (void)updateFriendWithType:(NSInteger)type withUserName:(NSString *)name;

// 获取当前新的朋友列表
- (NSArray *)getNewFriendList;





@end
