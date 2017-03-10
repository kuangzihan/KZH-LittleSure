//
//  KZHAddFirendCell.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/6.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHAddFirendCell.h"



@implementation KZHAddFirendCell

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
    [iconImg borderViewStyleWithCornerRadius:5 withColor:KZH_Line_Gray];
    [self.contentView addSubview:iconImg];
    self.iconImg = iconImg;
    
    UILabel *nicknameLabel = [[UILabel alloc] init];
    [nicknameLabel getBlackType_14];
    [self.contentView addSubview:nicknameLabel];
    self.nicknameLabel = nicknameLabel;
    
    UILabel *accountLabel = [[UILabel alloc] init];
    [accountLabel getBlackType_12];
    [self.contentView addSubview:accountLabel];
    self.accountLabel = accountLabel;
    
    
    __weak typeof(self) weakself = self;
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.contentView.mas_top).offset(10);
        make.bottom.mas_equalTo(weakself.contentView.mas_bottom).offset(-10);
        make.left.mas_equalTo(weakself.contentView.mas_left).offset(10);
        make.width.mas_equalTo(iconImg.mas_height);
    }];
    
    [nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImg.mas_right).offset(10);
        make.right.mas_equalTo(weakself.contentView.mas_right).offset(-80);
        make.top.mas_equalTo(iconImg.mas_top).offset(10);
        make.height.mas_equalTo(KZHAddFH/3);
    }];
    
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImg.mas_right).offset(10);
        make.right.mas_equalTo(weakself.contentView.mas_right).offset(-80);
        make.top.mas_equalTo(nicknameLabel.mas_bottom).offset(0);
        make.bottom.mas_equalTo(iconImg.mas_bottom).offset(-10);
    }];
    
//    [self addLongLine:KZHAddFH];
}

- (void)setUserInfo:(KZHMainModel *)userInfo {
    if (_userInfo != userInfo) {
        _userInfo = userInfo;
        
    }
    
    if ([_userInfo.iconURL isEqualToString:@"1"]) {
        self.iconImg.image = [UIImage imageNamed:@"defaultIcon"];
    } else {
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:_userInfo.iconURL] placeholderImage:[UIImage imageNamed:@"defaultIcon"]];
    }
    
    self.nicknameLabel.text = [NSString stringWithFormat:@"昵称:%@",_userInfo.nickName];
    
    self.accountLabel.text = [NSString stringWithFormat:@"账号:%@",_userInfo.userName];
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
