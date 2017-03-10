//
//  NSDictionary+Extension.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/2.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

// 用户信息转换字典
+ (NSDictionary *)getUserInfoWithBmobObject:(BmobObject *)bmobObject;

@end
