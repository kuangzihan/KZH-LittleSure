//
//  KZHManager.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/3.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHManager.h"

@implementation KZHManager

+ (instancetype)sharedManager {
    static KZHManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KZHManager alloc] init];
    });
    return manager;
}



+ (void)insertMyUserName:(NSString *)userName{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:userName forKey:@"userName"];
}

+ (NSString *)getMyUserName {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user objectForKey:@"userName"];
}

+ (void)deleteMyUserName {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"userName"];
}


@end
