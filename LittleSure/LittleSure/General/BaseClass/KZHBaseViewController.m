//
//  KZHBaseViewController.m
//  环信Demo
//
//  Created by 邝子涵 on 2017/2/24.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHBaseViewController.h"

@interface KZHBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation KZHBaseViewController

// 下面目的是开启屏幕边侧滑手势的一些控制 ———————————————————— ~
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    if ([self.navigationController.viewControllers count] >= 2) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //代理置空
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //只有在二级页面生效
        if ([self.navigationController.viewControllers count] >= 2) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.navigationController.viewControllers count] >= 2) {
        if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景色
    self.view.backgroundColor = [UIColor whiteColor];
    // 关闭navbar半透明
    self.navigationController.navigationBar.translucent = NO;
    // 关闭半自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 自定义返回按钮
    [self backBarButton];
    // Nav 标题
    [self navTitle];
}

// Nav 标题
- (void)navTitle {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.titleLabel = title;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = KZH_TITLE_COLOR;
    title.font = KZHFONT_16;
    self.navigationItem.titleView = title;
}

// 删除Nav左按钮
- (void)base_removeLiftBarButton {
    self.navigationItem.leftBarButtonItems = nil;
}

// 自定义返回按钮
- (void)backBarButton {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"main_backBarButton"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(baseVC_backBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -20;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, backButton, nil];
}

// 返回按钮触发
- (void)baseVC_backBarButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// 改变状态栏颜色(白色)
- (void)baseVC_changeStatusBarWhite {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
// 改变状态栏颜色(黑色)
- (void)baseVC_changeStatusBarBlack {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


//// 内存警告
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    
//    // 防止SDWebimage加载图片过大出现的内存警告
//    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
//    
//    if (self.isViewLoaded && !self.view.window){
//        
//        //释放其他可复现的资源&&保存数据
//        
//        self.view = nil;//目的是再次进入时能够重新加载调用viewDidLoad函数。
//        
//    }
//}

@end
