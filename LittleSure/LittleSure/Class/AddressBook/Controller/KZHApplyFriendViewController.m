//
//  KZHApplyFriendViewController.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/6.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHApplyFriendViewController.h"
#import "KZHSearchView.h"
#import "KZHLoginButton.h"
@interface KZHApplyFriendViewController ()

@property (nonatomic, weak) KZHSearchView *textFView;

// 注册按钮
@property (nonatomic, weak) KZHLoginButton *addBtn;
@end

@implementation KZHApplyFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KZH_Back_Gray;
    self.titleLabel.text = @"发送请求";
    
    [self setupBarButtonItem];
}

#pragma mark - 添加好友按钮
- (void)setupBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(addFirendAction)];
    
    [self setupView];
}

#pragma mark - 创建textF
- (void)setupView {
    KZHSearchView *textFView = [KZHSearchView defaultWithFrame:CGRectZero];
    textFView.text = [NSString stringWithFormat:@"我是%@",[KZHManager getMyUserName]];
    [self.view addSubview:textFView];
    self.textFView = textFView;
    // 赋值message
    self.userInfo.message = textFView.text;
    
    [textFView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(0);
        make.right.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.view).offset(10);
        make.height.mas_equalTo(KZHSearchViewH);
    }];
}


- (void)addFirendAction {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient].contactManager addContact:self.userInfo.userName message:self.textFView.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                SHOW(@"发送成功,等待好友同意后将添加到您的通讯录");
//                [[KZHFMDBUserInfoTool sharedFMDBDManager] insertMyUserInfo:self.userInfo withFriendType:KZHFriend_Wait];
                
                self.userInfo.friendType = KZHFriend_Wait;
                
                [[KZHFMDBTool tool] DataBase:FMDB_GetLittleSureDataBase insertKeyValues:[self.userInfo toDictionary] intoTable:FMDB_AddressTable];
                
               
            } else {
                NSString *err = [NSString stringWithFormat:@"发送失败,原因:%@ 错误码:%d",error.errorDescription, error.code];
                SHOW(err);
            }
        });
    });
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
