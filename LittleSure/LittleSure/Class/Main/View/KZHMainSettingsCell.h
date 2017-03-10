//
//  KZHMainSettingsCell.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/3.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KZHMainSettingsCell : UITableViewCell

@property (nonatomic, weak) UIImageView *logoImg;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UISwitch *mySwitch;

@property (nonatomic, assign) BOOL isOpenSwitch;

@end
