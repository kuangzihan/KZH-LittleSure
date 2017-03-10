//
//  AppDelegate+KZHMob.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/2/28.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (KZHMob)<EMContactManagerDelegate>

- (void)kzhmobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                   appkey:(NSString *)appkey
             apnsCertName:(NSString *)apnsCertName
              otherConfig:(NSDictionary *)otherConfig;

@end
