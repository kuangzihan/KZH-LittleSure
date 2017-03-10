//
//  KZHAddFirendViewController.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/6.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHAddFirendViewController.h"
#import "KZHUserInfoViewController.h"
#import "KZHAddFirendCell.h"
#import "KZHMainModel.h"

#define AddFirendTableViewReuse @"addFirendTableViewReuse"

#define jianxi 15

@interface KZHAddFirendViewController ()<UITableViewDelegate, UITableViewDataSource>
// 创建搜索栏
@property (nonatomic, weak) KZHSearchView *searchView;

// 创建TableView
@property (nonatomic, weak) UITableView *baseTableView;

// 数据数组
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation KZHAddFirendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"查找用户";
    
    self.view.backgroundColor = KZH_Back_Gray;
    
    [self setupUI];
}

#pragma mark - 创建UI
- (void)setupUI {
    KZHSearchView *searchView = [[KZHSearchView alloc] init];
    searchView.placeholder = @"请输入账号/昵称";
    [self.view addSubview:searchView];
    self.searchView = searchView;
    
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(0);
        make.right.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.view).offset(10);
        make.height.mas_equalTo(KZHSearchViewH);
    }];
    // 点击return进行搜索
    self.searchView.returnBlock = ^(NSString *searchResult) {
        [[KZHUserInfoTool sharedManager] getUserInfo:searchResult success:^(NSArray *array) {
            _dataArray = [NSMutableArray arrayWithCapacity:0];
            for (BmobObject *userInfo in array) {
                NSDictionary *dataDic = [NSDictionary getUserInfoWithBmobObject:userInfo];
                KZHMainModel *model = [KZHMainModel getDataForDictionary:dataDic];
                [_dataArray addObject:model];
            }
            [_baseTableView tableViewNoDataOrNewworkFail:array.count];
            [_baseTableView reloadData];
        } failure:^(NSError *error) {
            LSLog(@"%@", error);
        }];
    };
    
    [self setupTableView];
}

#pragma mark - 创建TableView
- (void)setupTableView {
    UITableView *baseTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    baseTableView.backgroundColor = [UIColor clearColor];
    baseTableView.separatorStyle = NO;
    baseTableView.delegate = self;
    baseTableView.dataSource = self;
    baseTableView.sectionIndexColor = KZH_Black;
    [self.view addSubview:baseTableView];
    self.baseTableView = baseTableView;
    
    [baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.searchView.mas_bottom).offset(jianxi);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
    }];
    
    
    [baseTableView registerClass:[KZHAddFirendCell class] forCellReuseIdentifier:AddFirendTableViewReuse];
    
    
//    [self.view addLongLine:KZHSearchViewH + jianxi + 10];
}


#pragma mark - tableView delegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KZHAddFH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KZHAddFirendCell *cell = [tableView dequeueReusableCellWithIdentifier:AddFirendTableViewReuse];
    cell.userInfo = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KZHUserInfoViewController *userInfoVC = [[KZHUserInfoViewController alloc] init];
    userInfoVC.dataArray = self.dataArray;
    [self.navigationController pushViewController:userInfoVC animated:YES];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] init];
//    [view addLongLine:19.5];
//    return view;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 20;
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
