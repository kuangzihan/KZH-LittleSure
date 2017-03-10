//
//  KZHSettingsViewController.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/10.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHSettingsViewController.h"
#import "KZHMainSettingsCell.h"
#define KZHSettingsTableViewCell @"KZHSettingsTableViewCell"

@interface KZHSettingsViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, weak) UITableView *baseTableView;

@property (nonatomic, strong) NSArray *dataArray;

/** 自动登录的开关 */
@property(nonatomic, strong) UISwitch *autoSwitch;

@end

@implementation KZHSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KZH_Back_Gray;
    self.titleLabel.text = @"设置";
    
    self.dataArray = @[@[@"自动登录"],
                       @[@"退出登录"]];
    
    [self setupUI];
}

- (void)setupUI {
    UITableView *baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - KZHNavigationH) style:UITableViewStyleGrouped];
    baseTableView.backgroundColor = [UIColor clearColor];
    baseTableView.delegate = self;
    baseTableView.dataSource = self;
    baseTableView.sectionIndexColor = KZH_Black;
    [self.view addSubview:baseTableView];
    self.baseTableView = baseTableView;
    
    
    // 注册talbeview
    [baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KZHSettingsTableViewCell];
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataArray[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KZHSettingsTableViewCell];
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = KZH_Black;
    cell.textLabel.font = KZHFONT_14;
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                //右侧放置开关
                cell.accessoryType = UITableViewCellAccessoryNone;
                _autoSwitch = [[UISwitch alloc]init];
                if ([EMClient sharedClient].options.isAutoLogin == YES) {
                    [_autoSwitch setOn:YES];
                }else{
                    [_autoSwitch setOn:NO];
                }
                
                [_autoSwitch addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];
                cell.accessoryView = _autoSwitch;
            }
            break;
        case 1:
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.accessoryType = UITableViewCellAccessoryNone;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请问您确定退出吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alertView show];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // 退出账号
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];        
    }
}

/*开关点击了*/
- (void)switchDidChange:(UISwitch*)mySwitch{
    [EMClient sharedClient].options.isAutoLogin = mySwitch.isOn;
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
