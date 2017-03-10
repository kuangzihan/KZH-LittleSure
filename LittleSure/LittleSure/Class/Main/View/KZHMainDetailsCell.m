//
//  KZHMainDetailsCell.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/3.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHMainDetailsCell.h"

@implementation KZHMainDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [self setupUI];
    }
    return self;
}

#pragma mark - 创建UI
- (void)setupUI {
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel getBlackType_14];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *iconImg = [[UIImageView alloc] init];
    [iconImg borderViewStyleWithCornerRadius:5 withColor:KZH_Line_Gray];
    [self.contentView addSubview:iconImg];
    iconImg.image = [UIImage imageNamed:@"defaultIcon"];
    self.iconImg = iconImg;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentRight;
    [nameLabel getGrayType_14];
    nameLabel.text = @"asdasda";
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    
    __weak typeof(self) weakself = self;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.contentView.mas_left).offset(10);
        make.top.bottom.mas_equalTo(weakself.contentView).offset(0);
        make.width.mas_equalTo(AD_WIDTH(100));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_right).offset(0);
        make.right.mas_equalTo(weakself.contentView.mas_right).offset(-10);
        make.top.bottom.mas_equalTo(weakself.contentView).offset(0);
    }];
    
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.contentView.mas_top).offset(10);
        make.bottom.mas_equalTo(weakself.contentView.mas_bottom).offset(-10);
        make.right.mas_equalTo(weakself.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(iconImg.mas_height);
    }];
}

- (void)setDataForUserInfo:(KZHMainModel *)userInfo withNSIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self isHiddenImg:NO];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.titleLabel.text = @"头像";
            if ([userInfo.iconURL isEqualToString:@"1"]) {
                self.iconImg.image = [UIImage imageNamed:@"defaultIcon"];
            }else{
                [self.iconImg sd_setImageWithURL:[NSURL URLWithString:userInfo.iconURL] placeholderImage:[UIImage imageNamed:@"defaultIcon"]];
            }
            
            break;
        case 1:
            [self isHiddenImg:YES];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.titleLabel.text = @"昵称";
            self.nameLabel.text = userInfo.nickName;
            break;
        case 2:
            [self isHiddenImg:YES];
            self.accessoryType = UITableViewCellAccessoryNone;
            self.titleLabel.text = @"账号";
            self.nameLabel.text = userInfo.userName;
            break;
        default:
            break;
    }
}

- (void)isHiddenImg:(BOOL)ishiiden {
    self.iconImg.hidden = ishiiden;
    self.nameLabel.hidden = !ishiiden;
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
