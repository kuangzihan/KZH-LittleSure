//
//  AppDelegate+KZHBmob.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/2.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "AppDelegate+KZHBmob.h"

@implementation AppDelegate (KZHBmob)

- (void)kzhBmobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                   appkey:(NSString *)appkey {
    [Bmob registerWithAppKey:appkey];
    
    // 创建
//    [[KZHFMDBUserInfoTool sharedFMDBDManager] createDatabase];
    
    // 创建库
    FMDB_GetLittleSureDataBase;
    [[KZHFMDBTool tool] DataBase:FMDB_GetLittleSureDataBase createTable:FMDB_ChatMessageTable keyTypes:FMDB_ChatMessageTableInfo];
    [[KZHFMDBTool tool] DataBase:FMDB_GetLittleSureDataBase createTable:FMDB_AddressTable keyTypes:FMDB_AddressTableInfo];
    
    LSLog(@"%@", NSHomeDirectory());
}

@end
