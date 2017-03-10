//
//  KZHUserInfoViewController.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/6.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHUserInfoViewController.h"
#import "KZHApplyFriendViewController.h"
#import "KZHAddFirendCell.h"
#import "KZHLoginButton.h"


#define UserInfoTableViewReuse   @"UserInfoTableViewReuse"

@interface KZHUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
// 创建TableView
@property (nonatomic, weak) UITableView *baseTableView;

// 注册按钮
@property (nonatomic, strong) KZHLoginButton *addBtn;
@end

@implementation KZHUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KZH_Back_Gray;
    self.titleLabel.text = @"添加好友";
    
    [self setupUI];
}

- (void)setupUI {
    UITableView *baseTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    baseTableView.backgroundColor = [UIColor clearColor];
    baseTableView.separatorStyle = NO;
    baseTableView.delegate = self;
    baseTableView.dataSource = self;
    baseTableView.sectionIndexColor = KZH_Black;
    [self.view addSubview:baseTableView];
    self.baseTableView = baseTableView;
    
    [baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view).offset(0);
    }];
    
    
    [baseTableView registerClass:[KZHAddFirendCell class] forCellReuseIdentifier:UserInfoTableViewReuse];
    
    [self.view addLongLine:0.5];
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KZHAddFH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KZHAddFirendCell *cell = [tableView dequeueReusableCellWithIdentifier:UserInfoTableViewReuse];
    cell.userInfo = self.dataArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] init];
    _addBtn = [KZHLoginButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(KZHLoginTFX, 25, SCREEN_WIDTH - KZHLoginTFX*2, KZHLoginBTMH);
    _addBtn.backgroundColor = RGBA(26, 176, 211, 1);
    [_addBtn setTitle:@"添加到通讯录" forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:_addBtn];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return KZHLoginBTMH+50;
}


#pragma mark - 添加好友方法
- (void)addBtnClick {
    KZHApplyFriendViewController *applyFVC = [[KZHApplyFriendViewController alloc] init];
    applyFVC.userInfo = self.dataArray[0];
    [self.navigationController pushViewController:applyFVC animated:YES];
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
