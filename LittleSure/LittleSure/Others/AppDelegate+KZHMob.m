//
//  AppDelegate+KZHMob.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/2/28.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "AppDelegate+KZHMob.h"
#import "KZHLoginViewController.h"
#import "KZHMainModel.h"
@implementation AppDelegate (KZHMob)


- (void)kzhmobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                   appkey:(NSString *)appkey
             apnsCertName:(NSString *)apnsCertName
              otherConfig:(NSDictionary *)otherConfig {
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    
    
    BOOL isAutoLogin = [EMClient sharedClient].isAutoLogin;
    if (isAutoLogin){
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }
    
    
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}

- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage {
    [[KZHUserInfoTool sharedManager] getUserInfoWithUserName:aUsername success:^(NSArray *array) {
        BmobObject *userInfo = array[0];
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary getUserInfoWithBmobObject:userInfo]];
        [dataDic setValue:aMessage forKey:@"message"];
        [dataDic setValue:KZHFriend_NEW forKey:@"friendType"];
        
//        KZHMainModel *userModel = [KZHMainModel getDataForDictionary:dataDic];
        
        
//        [[KZHFMDBUserInfoTool sharedFMDBDManager] insertMyUserInfo:userModel withFriendType:KZHFriend_NEW];
        
        [[KZHFMDBTool tool] DataBase:FMDB_GetLittleSureDataBase insertKeyValues:dataDic intoTable:FMDB_AddressTable];
        
        
        NSLog(@"%@ %@", aUsername, aMessage);
        
    } failure:^(NSError *error) {
    }];
}


- (void)loginStateChange:(NSNotification *)notification {
    BOOL loginSuccess = [notification.object boolValue];
    KZHBaseNavigationController *navigationController = nil;
    
    if (loginSuccess) {
        if (self.mainController == nil) {
            self.mainController = [[KZHBaseTabBarController alloc] init];
        }
        self.window.rootViewController = self.mainController;
    } else {
        if (self.mainController) {
            [self.mainController.navigationController popToRootViewControllerAnimated:NO];
        }
        self.mainController = nil;
        
        KZHLoginViewController *loginController = [[KZHLoginViewController alloc] init];
        navigationController = [[KZHBaseNavigationController alloc] initWithRootViewController:loginController];
        self.window.rootViewController = navigationController;
    }
    
    
}



@end
