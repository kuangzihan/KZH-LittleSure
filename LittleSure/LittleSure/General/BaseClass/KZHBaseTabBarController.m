//
//  KZHBaseTabBarController.m
//  环信Demo
//
//  Created by 邝子涵 on 2017/2/24.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHBaseTabBarController.h"
#import "KZHBaseNavigationController.h"

#import "KZHRootViewController.h"
#import "KZHAddressBookViewController.h"
#import "KZHDiscoverViewController.h"
#import "KZHMainViewController.h"


@interface KZHBaseTabBarController () {
    KZHRootViewController *_rootVC;
    KZHAddressBookViewController *_addressBookVC;
    KZHDiscoverViewController *_discoverVC;
    KZHMainViewController *_mainVC;
}

@end

@implementation KZHBaseTabBarController


+(KZHBaseTabBarController *)sharedRootVC{
    static KZHBaseTabBarController *rootVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rootVC = [[self alloc] init];
    });
    return rootVC;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViewController];
    }
    return self;
}


- (void)setupViewController{
    // 消息
    _rootVC = [[KZHRootViewController alloc] init];
    KZHBaseNavigationController *rootNaVC = [[KZHBaseNavigationController alloc] initWithRootViewController:_rootVC];
    rootNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息"
                                                           image:[UIImage imageNamed:@"tabbar_mainframe"]
                                                   selectedImage:[UIImage imageNamed:@"tabbar_mainframeHL"]];
    rootNaVC.tabBarItem.tag = 0;
    rootNaVC.tabBarItem.accessibilityIdentifier = @"rootVC";
    
    
    
    // 通讯录
    _addressBookVC = [[KZHAddressBookViewController alloc] init];
    KZHBaseNavigationController *addressBookNaVC = [[KZHBaseNavigationController alloc] initWithRootViewController:_addressBookVC];
    addressBookNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"通讯录"
                                                       image:[UIImage imageNamed:@"tabbar_contacts"]
                                               selectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]];
    addressBookNaVC.tabBarItem.tag = 1;
    addressBookNaVC.tabBarItem.accessibilityIdentifier = @"addressBookVC";
    
    
    // 发现
    _discoverVC = [[KZHDiscoverViewController alloc] init];
    KZHBaseNavigationController *discoverNaVC = [[KZHBaseNavigationController alloc] initWithRootViewController:_discoverVC];
    discoverNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现"
                                                              image:[UIImage imageNamed:@"tabbar_discover"]
                                                      selectedImage:[UIImage imageNamed:@"tabbar_discoverHL"]];
    discoverNaVC.tabBarItem.tag = 2;
    discoverNaVC.tabBarItem.accessibilityIdentifier = @"discoverVC";
    
    
    // 我的
    _mainVC = [[KZHMainViewController alloc] init];
    KZHBaseNavigationController *mainNaVC = [[KZHBaseNavigationController alloc] initWithRootViewController:_mainVC];
    mainNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                              image:[UIImage imageNamed:@"tabbar_me"]
                                                      selectedImage:[UIImage imageNamed:@"tabbar_meHL"]];
    mainNaVC.tabBarItem.tag = 1;
    mainNaVC.tabBarItem.accessibilityIdentifier = @"addressBookVC";
    
    
    self.viewControllers = @[rootNaVC, addressBookNaVC, discoverNaVC, mainNaVC];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}



@end
