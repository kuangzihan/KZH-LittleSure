//
//  KZHMainDetailsViewController.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/3.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHMainDetailsViewController.h"
#import "KZHMainDetailsCell.h"



#define MainDetailsTableViewReuse @"mainDetailsTableViewReuse"

@interface KZHMainDetailsViewController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TZImagePickerControllerDelegate>

@property (nonatomic, weak) UITableView * baseTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation KZHMainDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KZH_Back_Gray;
    self.titleLabel.text = @"个人资料";
    
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
    [baseTableView registerClass:[KZHMainDetailsCell class] forCellReuseIdentifier:MainDetailsTableViewReuse];
}


#pragma mark - tableView delegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    }else{
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KZHMainDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:MainDetailsTableViewReuse];
    [cell setDataForUserInfo:self.userInfo withNSIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            [self uesrImageClicked];
            break;
        }
        case 1:
            [self setupChangeNickName];
            break;
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

#pragma mark - create UIAlterView
- (void)setupChangeNickName {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入昵称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alertView show];
}

#pragma mark - UIAlterViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UITextField *evaluate = [alertView textFieldAtIndex:0];//获取alertView的文本框
        if (evaluate.text.length != 0) {
            KZHMainDetailsCell *cell = (KZHMainDetailsCell *)[self getCurrentCellWithRow:1];
            cell.nameLabel.text = evaluate.text;
            
            [[KZHUserInfoTool sharedManager] changeNickName:evaluate.text withUserName:_userInfo.userName];
        }
        
    }
}

#pragma mark - create UIActionSheet
- (void)uesrImageClicked {
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 255) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    [self setupCameraPickerController];         // 相机
                    break;
                case 1:
                    [self setupPhotoLibraryPickerController];   // 相册
                    break;
                default:
                    break;
            }
        } else {
            [self setupPhotoLibraryPickerController];   // 相册
        }
    }
}

#pragma mark - 跳转相机
- (void)setupCameraPickerController {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    //为NO，则不会出现系统的编辑界面
    imagePicker.allowsEditing = YES;
    // 设置为相机
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 弹出切换风格
    imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //通过UIImagePickerControllerMediaType判断返回的是照片还是视频
    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
    //如果返回的type等于kUTTypeImage，代表返回的是照片,并且需要判断当前相机使用的sourcetype是拍照还是相册
    if ([type isEqualToString:(NSString*)kUTTypeImage]&&picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        [self setDataForBombWithImage:[info objectForKey:UIImagePickerControllerEditedImage]];
    }
    //模态方式退出uiimagepickercontroller
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 跳转相册
- (void)setupPhotoLibraryPickerController {
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePicker.showSelectBtn = NO;
    imagePicker.allowCrop = YES;
    // 弹出切换风格
    imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    NSLog(@"%ld  %ld", photos.count, assets.count);
    
    [self setDataForBombWithImage:[photos firstObject]];
}

#pragma mark - 赋值视图及上传数据
- (void)setDataForBombWithImage:(UIImage *)image {
    //获取图片
    UIImage *img = [image imageWithscaleMaxWidth:290];
    
    // 获取当前cell
    KZHMainDetailsCell *cell = (KZHMainDetailsCell *)[self getCurrentCellWithRow:0];
    cell.iconImg.image = img;
    
    // 上传服务器
    [[KZHUserInfoTool sharedManager] changeUserIcon:img withUserName:[KZHManager getMyUserName]];
}

#pragma mark - 获取当前cell
- (UITableViewCell *)getCurrentCellWithRow:(NSInteger)row {
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    UITableViewCell *cell = [self.baseTableView cellForRowAtIndexPath:path];
    return cell;
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
