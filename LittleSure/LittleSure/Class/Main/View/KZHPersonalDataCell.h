//
//  KZHPersonalDataCell.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/2.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZHMainModel.h"

@interface KZHPersonalDataCell : UITableViewCell

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *nicknameLabel;

@property (nonatomic, weak) UILabel *accountLabel;


@property (nonatomic, strong) KZHMainModel *userInfo;

@end
