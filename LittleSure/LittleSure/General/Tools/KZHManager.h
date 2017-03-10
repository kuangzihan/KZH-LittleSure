//
//  KZHManager.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/3.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZHManager : NSObject

+ (instancetype)sharedManager;

// 用户名
@property (nonatomic, copy)  NSString  *userName;
// 昵称
@property (nonatomic, copy)  NSString  *nickName;
// 头像链接
@property (nonatomic, copy)  NSString  *iconURL;


// 插入用户名
+ (void)insertMyUserName:(NSString *)userName;
// 获取账号
+ (NSString *)getMyUserName;
// 删除当前登录账号
+ (void)deleteMyUserName;


@end
