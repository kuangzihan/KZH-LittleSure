//
//  KZHAddressModel.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/1.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHAddressModel.h"

@implementation KZHAddressModel
- (instancetype)initDataWitDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSError *error = nil;
        self = [self initWithDictionary:dictionary error:&error];
    }
    return self;
}


+ (KZHAddressModel *)setDataWitDictionary:(NSDictionary *)dictionary{
    return [[KZHAddressModel alloc] initDataWitDictionary:dictionary];
}


- (void)setUserName:(NSString<Optional> *)userName {
    if (_userName != userName) {
        _userName = userName;
    }
    _pinyin = _userName.firstCharactor;
}

@end
