//
//  KZHApplyFListCell.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/6.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZHMainModel.h"

@protocol KZHApplyFListCellDelegate <NSObject>

@optional
- (void)KZHApplyFListCellConsentWithType:(NSInteger)type withUserName:(NSString *)userName;

@end


@interface KZHApplyFListCell : UITableViewCell<UIAlertViewDelegate>

@property (nonatomic, weak) id<KZHApplyFListCellDelegate> delegate;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *userName;

@property (nonatomic, weak) UILabel *describeLabel;

@property (nonatomic, weak) UIButton *typeBtn;

@property (nonatomic, strong) KZHMainModel * userinfo;

@end
