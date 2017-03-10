//
//  KZHMainDetailsCell.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/3.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KZHMainModel.h"

@interface KZHMainDetailsCell : UITableViewCell

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UIImageView *iconImg;





- (void)setDataForUserInfo:(KZHMainModel *)userInfo withNSIndexPath:(NSIndexPath *)indexPath;

@end
