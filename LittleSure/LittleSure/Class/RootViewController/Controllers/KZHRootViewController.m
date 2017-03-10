//
//  KZHRootViewController.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/2/28.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHRootViewController.h"
#import "KZHAddFirendCell.h"

#define MessageCellReuse @"MessageCellReuse"

@interface KZHRootViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *baseTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation KZHRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"LittleSure";
    self.view.backgroundColor = KZH_Back_Gray;
    
    
    
    
    // 删除左边按钮
    [self base_removeLiftBarButton];
    // 创建UI
    [self setupUI];
    // 创建数据
    [self setupData];
}

- (void)setupData {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *array = [[KZHFMDBTool tool] DataBase:FMDB_GetLittleSureDataBase selectKeyTypes:FMDB_ChatMessageTableQuery fromTable:FMDB_ChatMessageTable];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.dataArray = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *tempDic in array) {
                KZHMainModel *model = [KZHMainModel getDataForDictionary:tempDic];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.baseTableView tableViewNoDataOrNewworkFail:array.count];
            [weakSelf.baseTableView reloadData];
        });
    });
}

- (void)setupUI {
    UITableView *baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - KZHNavigationH) style:UITableViewStylePlain];
    baseTableView.backgroundColor = [UIColor clearColor];
    baseTableView.delegate = self;
    baseTableView.dataSource = self;
    baseTableView.sectionIndexColor = KZH_Black;
    baseTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:baseTableView];
    self.baseTableView = baseTableView;
    
    [baseTableView registerClass:[KZHAddFirendCell class] forCellReuseIdentifier:MessageCellReuse];
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
    KZHAddFirendCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageCellReuse];
    cell.userInfo = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
