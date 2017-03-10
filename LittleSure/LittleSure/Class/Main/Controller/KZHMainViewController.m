//
//  KZHMainViewController.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/2/28.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHMainViewController.h"
#import "KZHPersonalDataCell.h"
#import "KZHMainSettingsCell.h"
#import "KZHMainModel.h"

#import "KZHMainDetailsViewController.h"
#import "KZHSettingsViewController.h"

#define MainTableViewReuse @"mainTableViewReuse"
#define SettingsCellReuse @"SettingsCellReuse"

@interface KZHMainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView * baseTableView;

@property (nonatomic, strong) KZHMainModel *userInfo;

@end

@implementation KZHMainViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KZH_Back_Gray;
    self.titleLabel.text = @"我的";
    [self base_removeLiftBarButton];
    
    // 创建UI
    [self setupUI];
    
    
}

- (void)setupData {
    [[KZHUserInfoTool sharedManager] getUserInfoWithUserName:[KZHManager getMyUserName] success:^(NSArray *array) {
        BmobObject *userInfo = array[0];
        NSDictionary *dataDic = [NSDictionary getUserInfoWithBmobObject:userInfo];
        _userInfo = [KZHMainModel getDataForDictionary:dataDic];
        
        [_baseTableView reloadData];
    } failure:^(NSError *error) {
    }];
}


// 创建UI
- (void)setupUI {
    UITableView *baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - KZHNavigationH) style:UITableViewStyleGrouped];
    baseTableView.backgroundColor = [UIColor clearColor];
    baseTableView.delegate = self;
    baseTableView.dataSource = self;
    baseTableView.sectionIndexColor = KZH_Black;
    [self.view addSubview:baseTableView];
    self.baseTableView = baseTableView;
    
    
    // 注册talbeview
    [baseTableView registerClass:[KZHPersonalDataCell class] forCellReuseIdentifier:MainTableViewReuse];
    
    [baseTableView registerClass:[KZHMainSettingsCell class] forCellReuseIdentifier:SettingsCellReuse];
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return AD_HEIGHT(100);
    } else {
        return AD_HEIGHT(50);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KZHPersonalDataCell *cell = [tableView dequeueReusableCellWithIdentifier:MainTableViewReuse];
        cell.userInfo = self.userInfo;
        return cell;
    }else{
        KZHMainSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingsCellReuse];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KZHMainDetailsViewController *details = [[KZHMainDetailsViewController alloc] init];
        details.userInfo = self.userInfo;
        details.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:details animated:YES];
    }else{
        KZHSettingsViewController *settingsVC = [[KZHSettingsViewController alloc] init];
        [self.navigationController pushViewController:settingsVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }else{
        return 25;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}




@end
