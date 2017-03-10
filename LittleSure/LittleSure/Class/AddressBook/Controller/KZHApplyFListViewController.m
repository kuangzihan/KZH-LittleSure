//
//  KZHApplyFListViewController.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/6.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHApplyFListViewController.h"
#import "KZHApplyFListCell.h"

#define KZHApplyFListCellReuse @"KZHApplyFListCellReuse"

@interface KZHApplyFListViewController ()<UITableViewDelegate, UITableViewDataSource, KZHApplyFListCellDelegate>
@property (nonatomic, weak) UITableView * baseTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation KZHApplyFListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KZH_Back_Gray;
    self.titleLabel.text = @"新的朋友";
    
    
    
    [self setupUI];
    
    [self setupData];
}

- (void)setupData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        self.dataArray = [[KZHFMDBUserInfoTool sharedFMDBDManager] getNewFriendList];
        NSArray *array = [[KZHFMDBTool tool] DataBase:FMDB_GetLittleSureDataBase selectKeyTypes:FMDB_AddressTableQuery fromTable:FMDB_AddressTable];
        dispatch_async(dispatch_get_main_queue(), ^{
            _dataArray = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *tempDic in array) {
                KZHMainModel *model = [KZHMainModel getDataForDictionary:tempDic];
                [_dataArray addObject:model];
            }
            [_baseTableView tableViewNoDataOrNewworkFail:array.count];
            [_baseTableView reloadData];
        });
    });
    
}


- (void)setupUI {
    UITableView *baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - KZHNavigationH) style:UITableViewStylePlain];
    baseTableView.backgroundColor = KZH_Back_Gray;
    baseTableView.delegate = self;
    baseTableView.dataSource = self;
    baseTableView.sectionIndexColor = KZH_Black;
    [self.view addSubview:baseTableView];
    self.baseTableView = baseTableView;
    // 隐藏多余分割线
    baseTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [baseTableView registerClass:[KZHApplyFListCell class] forCellReuseIdentifier:KZHApplyFListCellReuse];
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KZHApplyFListCell *cell = [tableView dequeueReusableCellWithIdentifier:KZHApplyFListCellReuse];
    cell.delegate = self;
    cell.userinfo = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 接受好友申请按钮
- (void)KZHApplyFListCellConsentWithType:(NSInteger)type withUserName:(NSString *)userName{
    if (type == 1) {
        [self agreeToApplyWithUserName:userName];
    }else{
        [self refuseToApplyWithUserName:userName];
    }
}

// 同意
- (void)agreeToApplyWithUserName:(NSString *)userName{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:userName];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                SHOW(@"已接受请求");
//                [[KZHFMDBUserInfoTool sharedFMDBDManager] updateFriendWithType:KZHFriend_OK withUserName:userName];
                [[KZHFMDBTool tool] DataBase:FMDB_GetLittleSureDataBase
                                 updateTable:FMDB_AddressTable
                                setKeyValues:@{@"friendType":KZHFriend_OK}
                              whereCondition:@{@"userName":userName}];
                
                [self setupData];
            }
        });
    });
}

// 拒绝
- (void)refuseToApplyWithUserName:(NSString *)userName {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:userName];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
//                [[KZHFMDBUserInfoTool sharedFMDBDManager] updateFriendWithType:KZHFriend_Refuse withUserName:userName];
                [[KZHFMDBTool tool] DataBase:FMDB_GetLittleSureDataBase
                                 updateTable:FMDB_AddressTable
                                setKeyValues:@{@"friendType":KZHFriend_Refuse}
                              whereCondition:@{@"userName":userName}];
                [self setupData];
            }
        });
    });
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return <#expression#>;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return <#expression#>;
//}
//
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return <#expression#>;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return <#expression#>;
//}


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
