//
//  KZHAddressModel.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/1.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "JSONModel.h"

@interface KZHAddressModel : JSONModel

@property (nonatomic,copy) NSString<Optional> *userName;
@property (nonatomic, copy) NSString<Optional> *nickName;
@property (nonatomic, copy) NSString<Optional> *iconURL;
@property (nonatomic,copy) NSString <Ignore>*pinyin; //拼音


+ (KZHAddressModel *)setDataWitDictionary:(NSDictionary *)dictionary;

@end
