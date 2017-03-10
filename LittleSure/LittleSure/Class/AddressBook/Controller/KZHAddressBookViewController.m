//
//  KZHAddressBookViewController.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/2/28.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHAddressBookViewController.h"
#import "KZHAddFirendViewController.h"
#import "KZHApplyFListViewController.h"
#import "KZHMessageViewController.h"
#import "KZHAddressModel.h"

#import "KZHAddFirendCell.h"
#import "KZHAddressTitleCell.h"

#define AddressTableViewReuse @"addressTableViewReuse"

#define AddressTitleCellReuse @"addressTitleCellReuse"

@interface KZHAddressBookViewController ()<UITableViewDelegate, UITableViewDataSource>
//{
//    NSArray *_rowArr;       //row arr
//    NSArray *_sectionArr;   //section arr
//}

@property (nonatomic, weak) UITableView * baseTableView;

// model数据数组
@property (nonatomic, strong) NSMutableArray *serverDataArr;


@property (nonatomic, strong) NSArray *rowArr;

@property (nonatomic, strong) NSArray *sectionArr;


@end

@implementation KZHAddressBookViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 创建数据源
    [self setupFriendsData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"通讯录";
    self.view.backgroundColor = KZH_Back_Gray;
    [self base_removeLiftBarButton];
    
    // 创建右边添加按钮
    [self setupBarButtonItem];
    // 创建UI
    [self setupUI];
}

#pragma mark - 获取好友列表
- (void)setupFriendsData{
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        NSArray *buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        LSLog(@"%@", buddyList);
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 通过好友数组获取好友信息
                [[KZHUserInfoTool sharedManager] getFriendPersionInfo:buddyList success:^(NSArray *array) {
                    _serverDataArr = [NSMutableArray arrayWithCapacity:0];
                    for (BmobObject *userInfoObject in array) {
                        NSDictionary *tempDic = [NSDictionary getUserInfoWithBmobObject:userInfoObject];
                        KZHMainModel *model = [KZHMainModel getDataForDictionary:tempDic];
                        [_serverDataArr addObject:model];
                    }
                    weakself.rowArr = [KZHContactDataHelper getFriendListDataBy:self.serverDataArr];
                    weakself.sectionArr = [KZHContactDataHelper getFriendListSectionBy:[_rowArr mutableCopy]];
                    [weakself.baseTableView reloadData];
                } failure:^(NSError *error) {
                }];
            });
        }
    });
}


#pragma mark - 添加好友按钮
- (void)setupBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(addContactAction)];
}

- (void)addContactAction {
    KZHAddFirendViewController *addFirendVC = [[KZHAddFirendViewController alloc] init];
    addFirendVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addFirendVC animated:YES];
}

#pragma mark - 创建视图
- (void)setupUI {
    UITableView *baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - KZHNavigationH) style:UITableViewStylePlain];
    baseTableView.backgroundColor = KZH_Back_Gray;
    baseTableView.delegate = self;
    baseTableView.dataSource = self;
    baseTableView.sectionIndexColor = KZH_Black;
    [self.view addSubview:baseTableView];
    self.baseTableView = baseTableView;
    
    // 注册talbeview
    [baseTableView registerClass:[KZHAddFirendCell class] forCellReuseIdentifier:AddressTableViewReuse];
    [baseTableView registerClass:[KZHAddressTitleCell class] forCellReuseIdentifier:AddressTitleCellReuse];
}


#pragma mark - tableview delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rowArr.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        NSArray *rowArr = self.rowArr[section - 1];
        return [rowArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    } else {
        return KZHAddFH;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KZHAddressTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressTitleCellReuse];
        return cell;
    } else {
        KZHAddFirendCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressTableViewReuse];
        KZHMainModel *model = _rowArr[indexPath.section - 1][indexPath.row];
        cell.userInfo = model;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KZHApplyFListViewController *applyVC = [[KZHApplyFListViewController alloc] init];
        applyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:applyVC animated:YES];
    } else {
        KZHMainModel *model = _rowArr[indexPath.section - 1][indexPath.row];
        
        LSLog(@"%@", [model toDictionary]);
        
        [[KZHFMDBTool tool] DataBase:FMDB_GetLittleSureDataBase
                     insertKeyValues:[model toDictionary]
                           intoTable:FMDB_ChatMessageTable];
        
        
        KZHMessageViewController *chatController = [[KZHMessageViewController alloc] initWithConversationChatter:model.userName conversationType:EMConversationTypeChat];
        chatController.dataModel = model;
        chatController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatController animated:YES];
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //更改索引的背景颜色
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    // 更改索引栏字体颜色
    tableView.sectionIndexColor = KZH_Black;
    return self.sectionArr;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    SHOW(title);
    
    return index-1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [[UIView alloc] init];
    }else{
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = KZH_Back_Gray;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 20)];
        [label getGrayType_14];
        label.text = [NSString stringWithFormat:@"%@", _sectionArr[section - 1]];
        [backView addSubview:label];
        return backView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 20;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
