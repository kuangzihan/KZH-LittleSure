//
//  KZHCallViewController.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/7.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHCallViewController.h"

@interface KZHCallViewController (){
//    OpenGLView20 *_openGLView;
}

@end

@implementation KZHCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.大窗口显示层
//    _openGLView = [[OpenGLView20 alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    _openGLView.backgroundColor = [UIColor clearColor];
//    _openGLView.sessionPreset = AVCaptureSessionPreset640x480;
//    [self.view addSubview:_openGLView];
    
    EMCallLocalView *view = [[EMCallLocalView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:view];
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
