//
//  KZHMessageViewController.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/7.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHMessageViewController.h"
#import "KZHCallViewController.h"
@interface KZHMessageViewController ()<EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource>

@end

@implementation KZHMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 开启刷新
    self.showRefreshHeader = YES;
    
    // 签订方法
    self.delegate = self;
    self.dataSource = self;
    
    
    
//    [[EMClient sharedClient].callManager startCall:EMCallTypeVoice remoteName:self.dataModel.userName ext:nil completion:^(EMCallSession *aCallSession, EMError *aError) {
//        if (!aError) {
//            LSLog(@"申请成");
//        }else{
//            LSLog(@"描述:%@ 错误码:%u", aError.errorDescription, aError.code);
//        }
//    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeCall:) name:KNOTIFICATION_CALL object:nil];
    
}

#pragma mark - 语音及视频
- (void)makeCall:(NSNotification *)notifincation {
    NSString *tpye = [NSString stringWithFormat:@"%@", notifincation.object];
    if ([tpye isEqualToString:@"0"]) {
        
    }else{
        KZHCallViewController *vc                                                                                                                                                      = [[KZHCallViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



#pragma mark - EaseMessageViewControllerDelegate

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   didLongPressRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if (![object isKindOfClass:[NSString class]]) {
        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        self.menuIndexPath = indexPath;
        [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
    }
    return YES;
}



- (BOOL)messageViewController:(EaseMessageViewController *)viewController
        didSelectMessageModel:(id<IMessageModel>)messageModel
{
    BOOL flag = NO;
    //样例为如果消息是文件消息用户自定义处理选中逻辑
    switch (messageModel.bodyType) {
        case EMMessageBodyTypeImage:
        case EMMessageBodyTypeLocation:
        case EMMessageBodyTypeVideo:
        case EMMessageBodyTypeVoice:
            break;
        case EMMessageBodyTypeFile:
        {
            flag = YES;
            NSLog(@"用户自定义实现");
        }
            break;
        default:
            break;
    }
    return flag;
}


#pragma mark - EaseMessageViewControllerDataSource
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    model.avatarImage = [UIImage imageNamed:@"defaultIcon"];
//    UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:model.nickname];
//    if (profileEntity) {
//        model.avatarURLPath = profileEntity.imageUrl;
//        model.nickname = profileEntity.nickname;
//    }
//    model.failImageName = @"imageDownloadFail";
    return model;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KNOTIFICATION_CALL object:nil];
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
