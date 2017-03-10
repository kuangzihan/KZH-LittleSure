//
//  KZHUserInfoModel.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/3.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHUserInfoModel.h"

@implementation KZHUserInfoModel

- (instancetype)initDataWitDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSError *error = nil;
        self = [self initWithDictionary:dictionary error:&error];
    }
    return self;
}


+ (KZHUserInfoModel *)setDataWithDictionary:(NSDictionary *)dictionary{
    return [[KZHUserInfoModel alloc] initDataWitDictionary:dictionary];
}



@end
