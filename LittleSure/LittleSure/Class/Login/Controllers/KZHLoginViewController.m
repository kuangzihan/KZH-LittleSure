//
//  KZHLoginViewController.m
//  环信Demo
//
//  Created by 邝子涵 on 2017/2/24.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHLoginViewController.h"
#import "KZHLoginBackView.h"
#import "KZHLTView.h"
#import "KZHLogo.h"
#import "KZHLoginButton.h"
@interface KZHLoginViewController ()<KZHLTViewDelegate>
// 背景
@property (nonatomic, weak) KZHLoginBackView *backView;

@property (nonatomic, weak) KZHLogo *logo;
// 账号
@property (nonatomic, weak) KZHLTView *userName;
// 密码
@property (nonatomic, weak) KZHLTView *password;
// 登录按钮
@property (nonatomic, weak) KZHLoginButton *loginBtn;
// 注册按钮
@property (nonatomic, weak) KZHLoginButton *registerBtn;

@end

@implementation KZHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

#pragma mark - setupUI
- (void)setupUI {
    // 背景
    KZHLoginBackView *backView = [[KZHLoginBackView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:backView];
    self.backView = backView;
    
    
    
    KZHLogo *logo = [[KZHLogo alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-AD_WIDTH(200))/2, AD_HEIGHT(140), AD_WIDTH(200), AD_HEIGHT(50))];
    [backView addSubview:logo];
    self.logo = logo;
    
    KZHLTView *userName = [[KZHLTView alloc] initWithFrame:CGRectMake(KZHLoginTFX, CGRectGetMaxY(logo.frame) + AD_HEIGHT(60), SCREEN_WIDTH - KZHLoginTFX*2, KZHLoginTextFHeight)];
    userName.myImg.image = [UIImage imageNamed:@"l_name"];
    userName.imgCorners = UIRectCornerTopLeft;
    userName.textFCorners = UIRectCornerTopRight;
    userName.myTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [userName.myTextField setPlaceholderWithString:@"请输入登录账号" withPlaceholderColor:RGBA(120, 120, 120, 1)];
    userName.delegate = self;
    [backView addSubview:userName];
    self.userName = userName;
    
    KZHLTView *password = [[KZHLTView alloc] initWithFrame:CGRectMake(KZHLoginTFX, CGRectGetMaxY(userName.frame)+1, SCREEN_WIDTH - KZHLoginTFX*2, KZHLoginTextFHeight)];
    password.myTextField.keyboardType = UIKeyboardTypeASCIICapable;
    password.myImg.image = [UIImage imageNamed:@"l_password"];
    password.imgCorners = UIRectCornerBottomLeft;
    password.textFCorners = UIRectCornerBottomRight;
    [password.myTextField setPlaceholderWithString:@"输入密码" withPlaceholderColor:RGBA(120, 120, 120, 1)];
    // 隐藏密码
    password.myTextField.secureTextEntry = YES;
    password.delegate = self;
    [backView addSubview:password];
    self.password = password;
    
    
    KZHLoginButton *loginBtn = [KZHLoginButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(KZHLoginTFX, CGRectGetMaxY(password.frame) + AD_HEIGHT(50), SCREEN_WIDTH - KZHLoginTFX*2, KZHLoginBTMH);
    loginBtn.backgroundColor = RGBA(26, 176, 211, 0.4);
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [backView addSubview:loginBtn];
    self.loginBtn = loginBtn;
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    KZHLoginButton *registerBtn = [KZHLoginButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(KZHLoginTFX, CGRectGetMaxY(loginBtn.frame) + AD_HEIGHT(30), SCREEN_WIDTH - KZHLoginTFX*2, KZHLoginBTMH);
    registerBtn.backgroundColor = RGBA(26, 176, 211, 0.1);
    [registerBtn setTitle:@"注册LittleSure" forState:UIControlStateNormal];
    [backView addSubview:registerBtn];
    self.registerBtn = registerBtn;
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -  Login Click 
- (void)loginBtnClick {
    [self loginWithUsername:self.userName.myTextField.text password:self.password.myTextField.text];
}


// 点击登录or注册操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    if (username.length == 0) {
        SHOW(@"请输入账户");
        return;
    }
    if (password.length == 0) {
        SHOW(@"请输入密码");
        return;
    }
    
    if ([self.loginBtn.titleLabel.text isEqualToString:@"登  录"]) {
        // 登录
        [self requestLoginWithUsername:username password:password];
    }else{
        // 注册
        [self requestRegisterWithUsername:username password:password];
    }
}

// 点击登陆后的操作
- (void)requestLoginWithUsername:(NSString *)username password:(NSString *)password {
    // 显示button风火轮
    self.loginBtn.spinner.alpha = 1;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:username password:password];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 隐藏button风火轮
            self.loginBtn.spinner.alpha = 0;
            if (!error) {
                // 存储登录账号
                [KZHManager insertMyUserName:username];
                
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    [[EMClient sharedClient] migrateDatabaseToLatestSDK];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //发送自动登陆状态通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@([[EMClient sharedClient] isLoggedIn])];
                    });
                });
            } else {
                switch (error.code)
                {
                    case EMErrorNetworkUnavailable:
                        TTAlertNoTitle(NSLocalizedString(@"网络不可用", @"No network connection!"));
                        break;
                    case EMErrorServerNotReachable:
                        TTAlertNoTitle(NSLocalizedString(@"服务器未连接", @"Connect to the server failed!"));
                        break;
                    case EMErrorUserAuthenticationFailed:
                        TTAlertNoTitle(error.errorDescription);
                        break;
                    case EMErrorServerTimeout:
                        TTAlertNoTitle(NSLocalizedString(@"服务器超时", @"Connect to the server timed out!"));
                        break;
                    case EMErrorServerServingForbidden:
                        TTAlertNoTitle(NSLocalizedString(@"服务被禁用", @"Serving is banned"));
                        break;
                    default:
                        TTAlertNoTitle(NSLocalizedString(@"login.fail", @"Login failure"));
                        break;
                }
            }
        });
    });
}

// 注册
- (void)requestRegisterWithUsername:(NSString *)username password:(NSString *)password {
    // 显示button风火轮
    self.loginBtn.spinner.alpha = 1;
    [self.userName.myTextField resignFirstResponder];
    [self.password.myTextField resignFirstResponder];
    [self updateWithExpand:NO withDuration:0.25];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] registerWithUsername:username password:password];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 隐藏button风火轮
            self.loginBtn.spinner.alpha = 0;
            if (!error) {
                TTAlertNoTitle(NSLocalizedString(@"注册成功", nil));
                // 添加注册信息
                [[KZHUserInfoTool sharedManager] addUser:username];
                
                // 改变按钮为登录
                [self loginViewFrame];
                
            } else {
                switch (error.code) {
                    case EMErrorServerNotReachable:
                        TTAlertNoTitle(NSLocalizedString(@"服务器未连接", nil));
                        break;
                    case EMErrorUserAlreadyExist:
                        TTAlertNoTitle(NSLocalizedString(@"用户已存在", nil));
                        break;
                    case EMErrorNetworkUnavailable:
                        TTAlertNoTitle(NSLocalizedString(@"网络不可用", nil));
                        break;
                    case EMErrorServerTimeout:
                        TTAlertNoTitle(NSLocalizedString(@"服务器超时", nil));
                        break;
                    case EMErrorServerServingForbidden:
                        TTAlertNoTitle(NSLocalizedString(@"服务被禁用", nil));
                        break;
                    default:
                        TTAlertNoTitle(NSLocalizedString(@"register.fail", @"Registration failed"));
                        break;
                }
            }
        });
    });
}

#pragma mark - register Click
- (void)registerBtnClick {
    if ([self.registerBtn.titleLabel.text isEqualToString:@"注册LittleSure"]) {
        [self registerViewFrame];
    }else{
        [self loginViewFrame];
    }
}

- (void)registerViewFrame {
    [self.userName.myTextField becomeFirstResponder];
    [self.loginBtn setTitle:@"注  册" forState:UIControlStateNormal];
    [self.registerBtn setTitle:@"返回登录" forState:UIControlStateNormal];
    [self.userName.myTextField setPlaceholderWithString:@"请输入注册账号" withPlaceholderColor:RGBA(120, 120, 120, 1)];
    [self.password.myTextField setPlaceholderWithString:@"输入密码" withPlaceholderColor:RGBA(120, 120, 120, 1)];
}

- (void)loginViewFrame {
    [self.loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [self.registerBtn setTitle:@"注册LittleSure" forState:UIControlStateNormal];
    [self.userName.myTextField setPlaceholderWithString:@"请输入登录账号" withPlaceholderColor:RGBA(120, 120, 120, 1)];
    [self.password.myTextField setPlaceholderWithString:@"输入密码" withPlaceholderColor:RGBA(120, 120, 120, 1)];
}


#pragma mark - keyboard delegate
- (void)keyboardWillShowDelegate:(KZHLTView *)LTView withDuration:(NSTimeInterval)duration {
    [self updateWithExpand:YES withDuration:duration];
}

- (void)keyboardWillHideDelegate:(KZHLTView *)LTView withDuration:(NSTimeInterval)duration {
    [self updateWithExpand:NO withDuration:duration];
}

#pragma mark - 更新视图
- (void)updateWithExpand:(BOOL)isExpanded withDuration:(NSTimeInterval)duration {
    
    [self.logo hiddenWith:isExpanded withDuration:duration];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        if (isExpanded == YES) {
            weakSelf.userName.frame = CGRectMake(KZHLoginTFX, AD_HEIGHT(140), SCREEN_WIDTH - KZHLoginTFX*2, KZHLoginTextFHeight);
            weakSelf.password.frame = CGRectMake(KZHLoginTFX, CGRectGetMaxY(weakSelf.userName.frame)+1, SCREEN_WIDTH - KZHLoginTFX*2, KZHLoginTextFHeight);
            weakSelf.loginBtn.frame = CGRectMake(KZHLoginTFX, CGRectGetMaxY(weakSelf.password.frame) + AD_HEIGHT(50), SCREEN_WIDTH - KZHLoginTFX*2, KZHLoginBTMH);
        }else{
            weakSelf.userName.frame = CGRectMake(KZHLoginTFX, CGRectGetMaxY(self.logo.frame) + AD_HEIGHT(60), SCREEN_WIDTH - KZHLoginTFX*2, KZHLoginTextFHeight);
            weakSelf.password.frame = CGRectMake(KZHLoginTFX, CGRectGetMaxY(weakSelf.userName.frame)+1, SCREEN_WIDTH - KZHLoginTFX*2, KZHLoginTextFHeight);
            weakSelf.loginBtn.frame = CGRectMake(KZHLoginTFX, CGRectGetMaxY(weakSelf.password.frame) + AD_HEIGHT(50), SCREEN_WIDTH - KZHLoginTFX*2, KZHLoginBTMH);
        }
    }];
}




#pragma mark - Player
- (void)getPlayerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerStateChangeNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
}

#pragma mark - Notifications
- (void)moviePlayerStateChangeNotification:(NSNotification *)notification {
    MPMoviePlayerController *moviePlayer = notification.object;
    MPMoviePlaybackState playbackState = moviePlayer.playbackState;
    
    switch (playbackState) {
        case MPMoviePlaybackStatePaused:
        case MPMoviePlaybackStateStopped:
        case MPMoviePlaybackStateInterrupted:{
            if (self.backView.isLoop) {
                moviePlayer.controlStyle = MPMovieControlStyleNone;
                [self.backView.player play];
            }
            break;
            
        }
        default:
            break;
    }
}

#pragma mark - preferredStatusBarStyle
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Called
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self getPlayerNotifications];
    [self.backView.player play];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.backView.player pause];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.userName.myTextField resignFirstResponder];
    [self.password.myTextField resignFirstResponder];
}

- (void)dealloc {
    NSLog(@"KZHLoginViewController释放了");
//    AppDelegate * appDelegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
//    [[NSNotificationCenter defaultCenter] removeObserver:appDelegate name:KNOTIFICATION_LOGINCHANGE object:nil];
}


@end
