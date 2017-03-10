//
//  NSDictionary+Extension.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/2.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

+ (NSDictionary *)getUserInfoWithBmobObject:(BmobObject *)bmobObject {
    NSDictionary *dataDic = @{@"iconURL":[bmobObject objectForKey:@"iconURL"],
                              @"nickName":[bmobObject objectForKey:@"nickName"],
                              @"userName":[bmobObject objectForKey:@"userName"],
                              @"isOnline":@([[bmobObject objectForKey:@"isOnline"] boolValue])};
    return dataDic;
}

@end
