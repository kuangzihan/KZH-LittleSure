//
//  AppDelegate+KZHBmob.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/2.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "AppDelegate.h"

/* bmob */

@interface AppDelegate (KZHBmob)

- (void)kzhBmobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey;

@end
