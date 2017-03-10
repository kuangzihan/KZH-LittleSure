//
//  KZHMainModel.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/2.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZHMainModel : JSONModel

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *iconURL;

@property (nonatomic, copy) NSString *message;

@property (nonatomic,copy) NSString <Ignore>*pinyin; //拼音

// 好友请求状态
@property (nonatomic, copy) NSString *friendType;

+ (KZHMainModel *)getDataForDictionary:(NSDictionary *)dictionary;

@end
