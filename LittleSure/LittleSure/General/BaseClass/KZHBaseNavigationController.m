//
//  KZHBaseNavigationController.m
//  环信Demo
//
//  Created by 邝子涵 on 2017/2/24.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHBaseNavigationController.h"

@interface KZHBaseNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic,getter=isPushing) BOOL pushing;

@end

@implementation KZHBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    if (self.childViewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //~下面代码是解决页面的多次 push 使用———————————————————— ~
    if (self.pushing ==  YES) {
        LSLog(@"Push被拦截");
        return;
    }else{
        self.pushing = YES;
        //在切换界面的过程中禁止滑动手势，避免界面卡死
        if ([super respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            super.interactivePopGestureRecognizer.enabled = NO;
        }
        [super pushViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.pushing = NO;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
