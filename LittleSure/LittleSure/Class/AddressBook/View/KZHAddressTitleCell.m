//
//  KZHAddressTitleCell.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/6.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHAddressTitleCell.h"

@implementation KZHAddressTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *logoImg = [[UIImageView alloc] init];
    logoImg.image = [UIImage imageNamed:@"MoreSetting"];
    [self.contentView addSubview:logoImg];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"添加联系人";
    [titleLabel getBlackType_14];
    [self.contentView addSubview:titleLabel];
    
    __weak typeof(self) weakself = self;
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.contentView.mas_left).offset(10);
        make.top.mas_equalTo(weakself.contentView.mas_top).offset(10);
        make.bottom.mas_equalTo(weakself.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(logoImg.mas_height);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoImg.mas_right).offset(10);
        make.right.mas_equalTo(weakself.contentView.mas_right).offset(10);
        make.top.bottom.mas_equalTo(weakself.contentView).offset(0);
    }];
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
