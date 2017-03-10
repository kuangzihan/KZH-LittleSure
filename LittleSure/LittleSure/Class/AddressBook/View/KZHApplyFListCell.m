//
//  KZHApplyFListCell.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/6.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHApplyFListCell.h"

@implementation KZHApplyFListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *iconImg = [[UIImageView alloc] init];
    iconImg.image = [UIImage imageNamed:@"defaultIcon"];
    [iconImg borderViewStyleWithCornerRadius:5 withColor:KZH_Line_Gray];
    [self.contentView addSubview:iconImg];
    self.iconImg = iconImg;
    
    UILabel *userName = [[UILabel alloc] init];
    userName.font = FONT_Helvetica_16;
    userName.textColor = KZH_Black;
    [self.contentView addSubview:userName];
    self.userName = userName;
    
    
    UILabel *describeLabel = [[UILabel alloc] init];
    [describeLabel getGrayType_12];
    [self.contentView addSubview:describeLabel];
    self.describeLabel = describeLabel;
    
    
    UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    typeBtn.backgroundColor = KZH_Back_Gray;
    typeBtn.titleLabel.font = KZHFONT_14;
    typeBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:typeBtn];
    [typeBtn addTarget:self action:@selector(typeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.typeBtn = typeBtn;
    
    __weak typeof(self) weakself = self;
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.contentView.mas_left).offset(10);
        make.top.mas_equalTo(weakself.contentView.mas_top).offset(10);
        make.bottom.mas_equalTo(weakself.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(iconImg.mas_height);
    }];
    
    [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(weakself.contentView.mas_top).offset(20);
        make.bottom.mas_equalTo(weakself.contentView.mas_bottom).offset(-20);
        make.width.mas_equalTo(typeBtn.mas_height).multipliedBy(2);
    }];
    
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImg.mas_right).offset(10);
        make.right.mas_equalTo(typeBtn.mas_left).offset(-10);
        make.top.mas_equalTo(weakself.contentView.mas_top).offset(5);
        make.height.mas_equalTo(weakself.contentView.mas_height).multipliedBy(0.5);
    }];
    
    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImg.mas_right).offset(10);
        make.right.mas_equalTo(typeBtn.mas_left).offset(-10);
        make.top.mas_equalTo(userName.mas_bottom).offset(0);
        make.bottom.mas_equalTo(weakself.contentView.mas_bottom).offset(-5);
    }];
}

- (void)typeButtonClick {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:[NSString stringWithFormat:@"您确认将%@加为好友吗？",_userinfo.userName]
                                                       delegate:self
                                              cancelButtonTitle:@"拒绝"
                                              otherButtonTitles:@"同意", nil];
    [alertView show];
}


- (void)setUserinfo:(KZHMainModel *)userinfo {
    if (_userinfo != userinfo) {
        _userinfo = userinfo;
    }
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:_userinfo.iconURL] placeholderImage:[UIImage imageNamed:@"defaultIcon"]];
    
    self.userName.text = _userinfo.userName;
    
    self.describeLabel.text = _userinfo.message;

    [self getCurrterWith:_userinfo.friendType];
}


- (void)getCurrterWith:(NSString *)friendType {
    NSLog(@"%@", friendType);
    
    if ([friendType isEqualToString:KZHFriend_Wait]) {
        [self.typeBtn setTitle:@"待确认" forState:UIControlStateNormal];
        [self.typeBtn setTitleColor:KZH_Gray forState:UIControlStateNormal];
        self.typeBtn.backgroundColor = [UIColor clearColor];
        [self.typeBtn borderViewStyleWithCornerRadius:3 withColor:[UIColor clearColor]];
        self.typeBtn.userInteractionEnabled = NO;
    } else if ([friendType isEqualToString:KZHFriend_OK]){
        [self.typeBtn setTitle:@"已验证" forState:UIControlStateNormal];
        [self.typeBtn setTitleColor:KZH_Gray forState:UIControlStateNormal];
        self.typeBtn.backgroundColor = [UIColor clearColor];
        [self.typeBtn borderViewStyleWithCornerRadius:3 withColor:[UIColor clearColor]];
        self.typeBtn.userInteractionEnabled = NO;
    } else if ([friendType isEqualToString:KZHFriend_NEW]){
        [self.typeBtn setTitle:@"添加" forState:UIControlStateNormal];
        [self.typeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.typeBtn.backgroundColor = KZH_Button_Blue;
        [self.typeBtn borderViewStyleWithCornerRadius:3 withColor:KZH_Button_Blue];
        self.typeBtn.userInteractionEnabled = YES;
    } else if ([friendType isEqualToString:KZHFriend_Refuse]){
        [self.typeBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
        [self.typeBtn setTitleColor:KZH_Gray forState:UIControlStateNormal];
        self.typeBtn.backgroundColor = [UIColor clearColor];
        [self.typeBtn borderViewStyleWithCornerRadius:3 withColor:[UIColor clearColor]];
        self.typeBtn.userInteractionEnabled = NO;
    }
    
    
//    switch (friendType) {
//        case [KZHFriend_Wait]:
//            
//            break;
//        case KZHFriend_OK:
//            [self.typeBtn setTitle:@"已验证" forState:UIControlStateNormal];
//            [self.typeBtn setTitleColor:KZH_Gray forState:UIControlStateNormal];
//            self.typeBtn.backgroundColor = [UIColor clearColor];
//            [self.typeBtn borderViewStyleWithCornerRadius:3 withColor:[UIColor clearColor]];
//            self.typeBtn.userInteractionEnabled = NO;
//            break;
//        case KZHFriend_NEW:
//            [self.typeBtn setTitle:@"添加" forState:UIControlStateNormal];
//            [self.typeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            self.typeBtn.backgroundColor = KZH_Button_Blue;
//            [self.typeBtn borderViewStyleWithCornerRadius:3 withColor:KZH_Button_Blue];
//            self.typeBtn.userInteractionEnabled = YES;
//            break;
//        case KZHFriend_Refuse:
//            [self.typeBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
//            [self.typeBtn setTitleColor:KZH_Gray forState:UIControlStateNormal];
//            self.typeBtn.backgroundColor = [UIColor clearColor];
//            [self.typeBtn borderViewStyleWithCornerRadius:3 withColor:[UIColor clearColor]];
//            self.typeBtn.userInteractionEnabled = NO;
//            break;
//        default:
//            break;
//    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.delegate KZHApplyFListCellConsentWithType:buttonIndex withUserName:_userinfo.userName];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
