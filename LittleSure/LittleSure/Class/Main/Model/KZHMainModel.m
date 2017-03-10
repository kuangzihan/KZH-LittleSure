//
//  KZHMainModel.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/2.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHMainModel.h"

@implementation KZHMainModel

- (instancetype)initWithDataForDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSError *error = nil;
        self = [self initWithDictionary:dictionary error:&error];
    }
    return self;
}

+ (KZHMainModel *)getDataForDictionary:(NSDictionary *)dictionary {
    return [[KZHMainModel alloc] initWithDataForDictionary:dictionary];
}

- (void)setUserName:(NSString<Optional> *)userName {
    if (_userName != userName) {
        _userName = userName;
    }
    _pinyin = _userName.firstCharactor;
    LSLog(@"%@", _pinyin);
}

// 全部参数可选
+(BOOL)propertyIsOptional:(NSString*)propertyName{
    return YES;
}

@end
