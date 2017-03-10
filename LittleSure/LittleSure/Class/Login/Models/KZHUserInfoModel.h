//
//  KZHUserInfoModel.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/3.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZHUserInfoModel : JSONModel

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *iconURL;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *isOnline;

// 好友请求状态
@property (nonatomic, assign) NSInteger friendType;

+ (KZHUserInfoModel *)setDataWithDictionary:(NSDictionary *)dictionary;

@end
